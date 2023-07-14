import 'package:flutter/material.dart';
import 'package:lms/views/CerticateCreation.dart';
import 'package:printing/printing.dart';

class PreviewCertificate extends StatelessWidget {
  final String courseName;
  const PreviewCertificate({super.key, required this.courseName});
  @override
  Widget build(BuildContext context) {
    var cert = CertificateCreation();
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Preview'),
      ),
      body: PdfPreview(
        build: (context) => cert.main(courseName),
      ),
    );
  }
}
