# Digital_Signature
 
---

# Digital Signature and Certificate Embedding for PDF Files

## Overview

This project is an iOS application that allows users to digitally sign PDF files using certificates stored on their device. The application integrates the PSPDFKit to load and display PDFs, enabling users to select a certificate file (`.crt`) from their iPad’s local storage. Upon selecting the certificate, users can embed it as a digital signature into the PDF. The final PDF will also include a preview of the certificate’s content in a small box on the PDF page.

## Features

- **PDF Loading and Display**: Uses PSPDFKit to load and display PDF documents.
- **Certificate Selection**: Provides an option for users to browse and select `.crt` certificate files from their iPad’s local storage.
- **Digital Signature Embedding**: Embeds the selected certificate’s digital signature into the PDF.
- **Certificate Content Preview**: Displays a preview of the certificate’s content within a small box on the PDF.
- **PDF Export**: Saves and exports the signed PDF with the embedded certificate.

## Requirements

- **iOS 14.0+**
- **Xcode 12.0+**
- **Swift 5.0+**
- **PSPDFKit 13.9.0+**

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/digital-signature-pdf.git
   ```
2. Open the project in Xcode:
   ```bash
   cd digital-signature-pdf
   open SignDigital.xcodeproj
   ```
3. Install PSPDFKit via Swift Package Manager if not already included:
   - Go to `File > Swift Packages > Add Package Dependency`.
   - Enter the PSPDFKit repository URL: `https://github.com/PSPDFKit/PSPDFKit-SP`.
   - Follow the prompts to add the package to your project.

4. Build and run the project on your simulator or physical iPad.

## Usage

1. **Loading a PDF**:
   - On the main screen, tap the "Load PDF" button to load a PDF file using PSPDFKit.

2. **Selecting a Certificate**:
   - Tap the "Choose Certificate" button to browse and select a `.crt` file from your iPad's file storage.

3. **Signing the PDF**:
   - After selecting a certificate, tap the "Sign PDF" button. This will embed the certificate's signature into the PDF and display a preview of the certificate content in a small box within the PDF.

4. **Exporting the Signed PDF**:
   - The signed PDF will be saved, and you can export or share it as needed.

## File Structure

```
YET TO MAKE
```

## Known Issues

- Ensure that PSPDFKit is correctly integrated via the Swift Package Manager.
- If "No module found" errors occur, check the framework link settings and ensure that PSPDFKit is properly linked.

## Contact

For any inquiries or issues, please contact 
[yashsawkar5@gmail.com](mailto:yashsawkar5@gmail.com)
[nsnaveen31@gmail.com](mailto:nsnaveen31@gmail.com)

---
