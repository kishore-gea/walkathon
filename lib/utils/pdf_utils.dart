import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show rootBundle;
import '../model/participent_data.dart';

Future<pw.Document> generateParticipantPdf({
  required ParticipentData participant,
  required int rank,
  required DateTime generatedDate,
}) async {
  final pdf = pw.Document();
  final wellwithinBytes = await rootBundle.load('assets/images/wellwithin.png');
  final geBytes = await rootBundle.load('assets/images/ge.png');
  final wellwithinLogo = pw.MemoryImage(wellwithinBytes.buffer.asUint8List());
  final geLogo = pw.MemoryImage(geBytes.buffer.asUint8List());

  // Prepare monthly data inside the function for correct scoping
  final months = [
    {'label': 'MAR', 'days': 31, 'value': participant.steps},
    {'label': 'APR', 'days': 30, 'value': participant.apr},
    {'label': 'MAY', 'days': 31, 'value': participant.may},
    {'label': 'JUN', 'days': 30, 'value': participant.jun},
    {'label': 'JUL', 'days': 31, 'value': participant.jul},
    {'label': 'AUG', 'days': 31, 'value': participant.aug},
    {'label': 'SEP', 'days': 30, 'value': participant.sep},
    {'label': 'OCT', 'days': 31, 'value': participant.oct},
    {'label': 'NOV', 'days': 30, 'value': participant.nov},
    {'label': 'DEC', 'days': 31, 'value': participant.dec},
    {'label': 'JAN', 'days': 31, 'value': participant.jan},
  ];
  int totalSteps = 0;
  final tableRows = <pw.TableRow>[];
  tableRows.add(
    pw.TableRow(
      decoration: pw.BoxDecoration(color: PdfColor.fromHex('#1E3A8A')),
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.all(6),
          child: pw.Text('Month', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white)),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(6),
          child: pw.Text('Steps', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white)),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(6),
          child: pw.Text('Avg/Day', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white)),
        ),
      ],
    ),
  );
  for (final m in months) {
    final int days = (m['days'] as int);
    final int steps = int.tryParse((m['value'] ?? '0').toString()) ?? 0;
    totalSteps += steps;
    final int avg = days > 0 ? (steps / days).round() : 0;
    tableRows.add(
      pw.TableRow(
        children: [
          pw.Padding(
            padding: const pw.EdgeInsets.all(6),
            child: pw.Text((m['label'] ?? '').toString(), style: pw.TextStyle(fontWeight: pw.FontWeight.normal)),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(6),
            child: pw.Text(steps.toString()),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(6),
            child: pw.Text(avg.toString()),
          ),
        ],
      ),
    );
  }
  // Add total row
  tableRows.add(
    pw.TableRow(
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.all(6),
          child: pw.Text('Total', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(6),
          child: pw.Text(totalSteps.toString(), style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(6),
          child: pw.Text('-', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        ),
      ],
    ),
  );

  pdf.addPage(
    pw.MultiPage(
      build: (context) => [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.center,
          children: [
            pw.Image(wellwithinLogo, width: 70, height: 70),
            pw.SizedBox(width: 24),
            pw.Image(geLogo, width: 70, height: 70),
          ],
        ),
        pw.SizedBox(height: 10),
        pw.Center(
          child: pw.Text(
            'Wellness Walkathon Season 1\n(MARCH 2025 - JANUARY 2026)',
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.normal, color: PdfColor.fromHex('#1E3A8A')),
          ),
        ),
        pw.SizedBox(height: 16),
        pw.Center(
          child: pw.Text(
            participant.name ?? 'Unknown',
            style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('#1E3A8A')),
          ),
        ),
        pw.SizedBox(height: 10),
        pw.Text('Location: ${participant.location ?? 'N/A'}', style: pw.TextStyle(fontSize: 16)),
        pw.Text('Rank: $rank', style: pw.TextStyle(fontSize: 16)),
        pw.Text('Total Steps: ${participant.total ?? 'N/A'}', style: pw.TextStyle(fontSize: 16)),
        pw.SizedBox(height: 30),
        pw.Divider(),
        pw.SizedBox(height: 10),
        pw.Text(
          'Your dedication, enthusiasm, and active participation made this journey inspiring.\n\nThank you for every step, every submission, and the incredible energy you shared.\n\nTogether, we built healthier habits and strengthened our culture of wellness.',
          style: pw.TextStyle(fontSize: 12, color: PdfColors.black),
          textAlign: pw.TextAlign.left,
        ),
        pw.SizedBox(height: 16),
        pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.Text('Team WellWithin', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('#1E3A8A'))),
        ),
        pw.SizedBox(height: 10),
        pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.Text('Generated on: ${generatedDate.toLocal().toString().split(' ')[0]}', style: pw.TextStyle(fontSize: 10, color: PdfColors.grey)),
        ),
        pw.SizedBox(height: 20),
        pw.Text('Monthly Step Count', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('#1E3A8A'))),
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey, width: 0.5),
          children: tableRows,
        ),
        pw.SizedBox(height: 20),
        pw.Text('Monthly Steps Graph', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('#1E3A8A'))),
        pw.Container(
          height: 120,
          child: pw.CustomPaint(
            size: const PdfPoint(400, 120),
            painter: (PdfGraphics canvas, PdfPoint size) {
              final stepValues = months.map((m) => int.tryParse((m['value'] ?? '0').toString()) ?? 0).toList();
              final maxStep = stepValues.isNotEmpty ? stepValues.reduce((a, b) => a > b ? a : b) : 0;
              final graphHeight = size.y - 20;
              final graphWidth = size.x - 40;
              final dx = graphWidth / (stepValues.length > 1 ? (stepValues.length - 1) : 1);
              // Draw axes
              canvas.setStrokeColor(PdfColors.grey);
              canvas.setLineWidth(1);
              canvas.drawLine(20, 10, 20, graphHeight + 10);
              canvas.drawLine(20, graphHeight + 10, graphWidth + 20, graphHeight + 10);
              // Draw points and lines
              if (maxStep > 0 && stepValues.length > 1) {
                for (int i = 0; i < stepValues.length - 1; i++) {
                  final x1 = 20 + i * dx;
                  final y1 = graphHeight + 10 - (stepValues[i] / maxStep) * graphHeight;
                  final x2 = 20 + (i + 1) * dx;
                  final y2 = graphHeight + 10 - (stepValues[i + 1] / maxStep) * graphHeight;
                  canvas.setStrokeColor(PdfColors.blue);
                  canvas.setLineWidth(2);
                  canvas.drawLine(x1, y1, x2, y2);
                  // Draw points
                  canvas.setFillColor(PdfColors.orange);
                  canvas.drawLine(x1, y1, x2, y2);
                  if (i == stepValues.length - 2) {
                    canvas.drawLine(x1, y1, x2, y2);
                  }
                }
              }
            },
          ),
        ),
      ],
    ),
  );
  return pdf;
}
