//
//  ViewController.swift
//  DigitalSignature
//
//  Created by Naveen on 24/08/24.
//

import UIKit
import PSPDFKit
import PSPDFKitUI

class ViewController: UIViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Perform the document signing and PDF processing on a background thread
        DispatchQueue.global(qos: .background).async {
            Task {
                await self.signDocument()
            }
        }
    }
    
    func signDocument() async {
        // Update to use your document name.
        guard let fileURL = Bundle.main.url(forResource: "blank_signed", withExtension: "pdf") else {
            print("Error: Could not find 'Document.pdf' in the bundle.")
            return
        }
        let document = Document(url: fileURL)

        guard let p12URL = Bundle.main.url(forResource: "test-signer", withExtension: "p12") else {
            print("Error: Could not find 'test-signer.p12' in the bundle.")
            return
        }
        guard let p12data = try? Data(contentsOf: p12URL) else {
            print("Error reading p12 data from \(p12URL)")
            return
        }
        let p12 = PKCS12(data: p12data)
        guard let (certificates, privateKey) = try? p12.unlockCertificateChain(withPassword: "apple") else {
            print("Error unlocking certificate chain with password.")
            return
        }

        // Add CA certificates to the trust store for the signature validation process.
        guard let caCertURL = Bundle.main.url(forResource: "test-ca", withExtension: "cert") else {
            print("Error: Could not find 'test-ca.cert' in the bundle.")
            return
        }
        guard let caCertData = try? Data(contentsOf: caCertURL) else {
            print("Error reading CA certificate data from \(caCertURL)")
            return
        }
        guard let caCertificates = try? X509.certificates(fromPKCS7Data: caCertData) else {
            print("Error parsing CA certificates from data.")
            return
        }
        for certificate in caCertificates {
            SDK.shared.signatureManager.addTrustedCertificate(certificate)
        }
        
        var signatureFormElement: SignatureFormElement?
        for pageIndex in 0..<document.pageCount {
            let elements = document.annotations(at: pageIndex, type: SignatureFormElement.self)
            if let firstElement = elements.first {
                signatureFormElement = firstElement
                break
            }
        }
        guard let formElement = signatureFormElement else {
            print("Error: Could not find signature form element in the document.")
            return
        }
        
        let fileName = "\(UUID().uuidString).pdf"
        let url = URL(fileURLWithPath: NSTemporaryDirectory().appending(fileName))

        do {
            let configuration = SigningConfiguration(dataSigner: privateKey, certificates: certificates)
            try await document.sign(formElement: formElement, configuration: configuration, outputDataProvider: FileDataProvider(fileURL: url))
            let signedDocument = Document(url: url)
            
            // Present the PDF view controller within a `UINavigationController` to show built-in toolbar buttons.
            DispatchQueue.main.async {
                let pdfController = PDFViewController(document: signedDocument)
                self.present(UINavigationController(rootViewController: pdfController), animated: true)
            }
        } catch {
            print(error)
        }
    }
}
