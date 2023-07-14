import 'dart:io';
import 'dart:typed_data';

import 'package:lms/model/userModal.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class CertificateCreation {
  Future<Uint8List> main(String courseName) async {
    final pdf = pw.Document();

    pdf.addPage(pw.Page(
      build: (pw.Context context) => pw.Column(children: [
        pw.Center(
          child: pw.Text('Certificate of Completetion'),
        ),
        pw.SizedBox(height: 20),
        pw.Center(
          child: pw.Text(courseName),
        ),
        pw.SizedBox(height: 20),
        pw.Center(
          child: pw.Text(UserList.users.first.name),
        ),
      ]),
    ));
    var _docDirectory = await getApplicationDocumentsDirectory();
    final file = File('${_docDirectory.path}/${UserList.users.first.name}.pdf');
    await file.writeAsBytes(await pdf.save());
    return pdf.save();
  }
}
