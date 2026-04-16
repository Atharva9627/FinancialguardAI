import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ReportGenerator {

  static Future generateReport(
      Map result,
      String aiReport,
      ) async {

    final pdf = pw.Document();

    pdf.addPage(

      pw.Page(
        build: (context) {

          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [

              pw.Text(
                "FinancialGuard AI Report",
                style: pw.TextStyle(
                  fontSize: 28,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),

              pw.SizedBox(height: 20),

              pw.Text(
                "Financial Summary",
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),

              pw.SizedBox(height: 10),

              pw.Text("Monthly Income: ${result["income"]} Rupees"),

              pw.Text("Monthly Expenses: ${result["expenses"]} Rupees"),

              pw.Text("Monthly Savings: ${result["savings"]} Rupees"),

              pw.SizedBox(height: 20),

              pw.Text(
                "Risk Level: ${result["risk"]}",
                style: pw.TextStyle(fontSize: 16),
              ),

              pw.SizedBox(height: 20),

              pw.Text(
                "Projected Wealth:",
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),

              pw.Text("${result["projection"]} Rupees"),

              pw.SizedBox(height: 20),

              pw.Text(
                "AI Generated Financial Analysis",
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),

              pw.SizedBox(height: 10),

              pw.Text(
                aiReport,
                style: pw.TextStyle(fontSize: 12),
              ),

            ],
          );

        },
      ),

    );

    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
    );

  }

}