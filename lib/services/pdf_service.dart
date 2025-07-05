import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class PdfService {
  static Future<void> generateAndOpenPdf(List<(String, String, double)> transactions) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Split Summary', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              ...transactions.map((t) => pw.Text('${t.$1} owes ${t.$2} ₹${t.$3.toStringAsFixed(2)}')),
            ],
          );
        },
      ),
    );

    final output = await getExternalStorageDirectory();
    final filePath = "${output!.path}/Split_Summary_${DateTime.now().millisecondsSinceEpoch}.pdf";
    final file = File(filePath);

    await file.writeAsBytes(await pdf.save());

    // Open the file
    await OpenFile.open(filePath);
  }
}
