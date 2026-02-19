import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:wellnesswalkathon/pages/walkthon_stats/animater_text.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../data_constants/stepcount_data.dart';
import '../style/text_style.dart';

class Customteams extends StatefulWidget {
  const Customteams({super.key});

  @override
  State<Customteams> createState() => _CustomteamsState();
}

class _CustomteamsState extends State<Customteams> {

  List<String> teamNames = [
    'IRON PACE',
    'Safar Hyderabad Se Bengaluru Tak',
    'AROGYA AVENGERS',
    'STRIDE ALCHEMY',
    'STEP UP CREW',
    'WALK GPT',
    'BINDAAS WALKERS',
    'WHITE WALKERS',
    'DON"T STOP',
    'WALK ROCK ROLL',
    'LAKSHYA WALK WARRIORS',
    'VIJAYA PADA',
    'PACE KEEPERS',
    'AMAZON WALKERS',
    'BLOCKBUSTER WALKERS',
    'A = DV/DT',
    'WITNESS THE FITNESS',
    'MINDFULL MILES',
    'MILES DONT LIE',
    'KILL-O-METERS',
    'THE POWER WALKERS',
    'THE WALKING FIVE',
    'HAPPY SOUL',
    'HAPPY FEET',
    'WALK YOGIS',
    'HAPPY FEET 2.0',
    'MILES FOR SMILES'
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'GE Appliances India Teams - [MARCH 2025 - JANUARY 2026 Step Count]',
          style: AppTextStyles.headline.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTextStyles.primaryBlue,
            fontSize: 22,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [ FutureBuilder(
            builder: (context, snapshot) {
              final data = snapshot.data;
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                print('snapshot data length: ${snapshot.data!.length}');
                final data = snapshot.data!;
                final chunkedData = chunkList(data, 5);

                // Map each group to its total steps
                final chunkedWithTotals = chunkedData.asMap().entries.map((entry) {
                  final int index = entry.key;
                  final group = entry.value;
                  final int groupTotalSteps = group.fold(
                    0,
                        (sum, item) => sum + (item.jan != null ? int.tryParse(item.jan.toString()) ?? 0 : 0),
                  );
                  final String teamName = index < teamNames.length ? teamNames[index] : 'TEAM ${index+1}';
                  return {'group': group, 'total': groupTotalSteps, 'teamName': teamName};
                }).toList();

                // Sort by groupTotalSteps descending
                chunkedWithTotals.sort((a, b) => (b['total'] as int).compareTo(a['total'] as int));

                return SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: chunkedWithTotals.length,
                        itemBuilder: (context, chunkIndex) {
                          final group = chunkedWithTotals[chunkIndex]['group'] as List;
                          final int groupTotalSteps = chunkedWithTotals[chunkIndex]['total'] as int;
                          final String teamName = chunkedWithTotals[chunkIndex]['teamName'] as String;
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                            child: Card(
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap:(){
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return
                                              AlertDialog(
                                              title: Column(
                                                  children: [
                                                      Text('${teamName}',style: AppTextStyles.headline.copyWith(fontWeight: FontWeight.bold,color: AppTextStyles.primaryBlue),),
                                                    SizedBox(height: 10,),
                                                    Container(
                                                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                                      decoration: BoxDecoration(
                                                        color: AppTextStyles.orange,
                                                        borderRadius: BorderRadius.circular(8)
                                                      ),
                                                      child: Text('${AppTextStyles().formatIndianNumber(groupTotalSteps)} Steps',style: AppTextStyles.body.copyWith(color: AppTextStyles.primaryBlue,fontWeight: FontWeight.bold),)),
                                                      Container(
                                                        padding: EdgeInsets.all(15),
                                                        decoration: BoxDecoration(
                                                          color: AppTextStyles.primaryBlue,
                                                          shape: BoxShape.circle,
                                                        ),
                                                        child: Padding(
                                                            padding: EdgeInsetsGeometry.symmetric(horizontal: 5,vertical: 5),child: Text('${chunkIndex+1}',style: AppTextStyles.body.copyWith(color: AppTextStyles.white,fontWeight: FontWeight.bold,fontSize: 50),))
                                                      )

                                                  ],
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: group.map((item) => ListTile(
                                                  title: Text('${item.name}',style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),),
                                                  subtitle: Container(
                                                    padding: EdgeInsetsGeometry.symmetric(vertical: 5,horizontal: 10),
                                                      decoration: BoxDecoration(
                                                        color: AppTextStyles.primaryBlue,
                                                        borderRadius: BorderRadius.circular(8)
                                                      ),
                                                      child: Text('${AppTextStyles().formatIndianNumber(int.parse(item.jan))} Km',style: AppTextStyles.body.copyWith(color: AppTextStyles.white,fontWeight: FontWeight.bold),)),
                                              )).toList(),
                                            ),
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () async {
                                                  await generateAndSharePdf({
                                                    'teamName': teamName,
                                                    'total': groupTotalSteps,
                                                    'group': group,
                                                  }, rank: chunkIndex + 1);
                                                },
                                                child: Text('Generate PDF'),
                                              ),
                                              TextButton(
                                                onPressed: () => Navigator.pop(context),
                                                child: Text('Close'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SelectableText(' ${chunkIndex+1}. ${teamName} ', style: AppTextStyles.subtitle.copyWith(fontSize:35,fontWeight: FontWeight.bold, color: AppTextStyles.primaryBlue),),
                                            Container(
                                                decoration: BoxDecoration(
                                                  color: AppTextStyles.primaryBlue,
                                                  borderRadius: BorderRadius.circular(16),
                                                ),
                                                padding: const EdgeInsetsGeometry.symmetric(horizontal: 15,vertical: 10),
                                                child: SelectableText('${AppTextStyles().formatIndianNumber(groupTotalSteps)} Steps', style: AppTextStyles.subtitle.copyWith(fontSize:30,fontWeight: FontWeight.bold, color: AppTextStyles.white),)),

                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: group.map((item) => Row(
                                              children: [
                                                SelectableText('${item.name}',textAlign: TextAlign.start,style: AppTextStyles.body.copyWith(color: AppTextStyles.primaryBlue,fontWeight: item.name!.contains('(C)') ? FontWeight.bold : FontWeight.normal),),
                                                SizedBox(width: 10,),
                                                item.location == 'HYD' ? Container(
                                                  decoration: BoxDecoration(
                                                    color: item.jan!='0' ? AppTextStyles.orange : AppTextStyles.white,
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  padding: EdgeInsetsGeometry.symmetric(horizontal: 7,vertical: 2),
                                                  child: Text('HYD',style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold,fontSize: 12),),
                                                )
                                                    : Container(
                                                  decoration: BoxDecoration(
                                                    color: item.jan!='0' ? AppTextStyles.orange : AppTextStyles.white,
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  padding: EdgeInsetsGeometry.symmetric(horizontal: 7,vertical: 2),
                                                  child: Text('BLR',style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold,fontSize: 12),),
                                                ),
                                                // item.jan!='0' ? Text('${item.jan}'):Text('000000'),
                                              ]
                                              )).toList(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ],
                              ),
                            ),
                          ));
                        },
                      ),
                    ],
                  ),
                );
              } else {
                return Text('No data found');
              }
            },
            future: StepCountData().getTeamWiseData(),
          ),],
        ),
      ),
    );
  }

  List<List<T>> chunkList<T>(List<T> list, int chunkSize) {
    List<List<T>> chunks = [];
    for (var i = 0; i < list.length; i += chunkSize) {
      chunks.add(list.sublist(i, i + chunkSize > list.length ? list.length : i + chunkSize));
    }
    return chunks;
  }

  Future<void> generateAndSharePdf(Map<String, dynamic> team, {int? rank}) async {
    final formatNumber = AppTextStyles().formatIndianNumber;
    final pdf = pw.Document();
    // Load the logo images as bytes
    final wellwithinBytes = await rootBundle.load('assets/images/wellwithin.png');
    final geBytes = await rootBundle.load('assets/images/ge.png');
    final wellwithinLogo = pw.MemoryImage(wellwithinBytes.buffer.asUint8List());
    final geLogo = pw.MemoryImage(geBytes.buffer.asUint8List());
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
              'Wellness Walkathon Season 1\n GRAND FINALE (JAN 2026 - FEB 2026)',
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.normal, color:PdfColor.fromHex('#1E3A8A')),
            ),
          ),

          pw.SizedBox(height: 16),
          pw.Center(
            child: pw.Text(
              team['teamName'],
              style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold,color: PdfColor.fromHex('#1E3A8A')),
            ),
          ),
          pw.SizedBox(height: 10),
          if (rank != null)
            pw.Center(
              child: pw.Container(
                width: 120,
                height: 120,
                decoration: pw.BoxDecoration(
                  color: PdfColor.fromHex('#1E3A8A'),
                  shape: pw.BoxShape.circle,
                  border: pw.Border.all(color: PdfColor.fromHex('#1E3A8A'), width: 4),
                ),
                alignment: pw.Alignment.center,
                child: pw.Text(
                  '$rank',
                  style: pw.TextStyle(fontSize: 70, fontWeight: pw.FontWeight.bold, color: PdfColors.white),
                ),
              ),
            ),
          pw.SizedBox(height: 10),
          pw.Center(
            child: pw.Container(
              padding: const pw.EdgeInsets.all(8),
              decoration: pw.BoxDecoration(
                color: PdfColor.fromHex('#FFA500'),
                borderRadius: pw.BorderRadius.circular(8),
              ),
              child: pw.Text(
                'RANK',
                style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('#1E3A8A')),
              ),
            ),
          ),
          pw.SizedBox(height: 20),
          // Replace pw.Table.fromTextArray with a custom table for conditional styling
          pw.Table(
            border: null,
            columnWidths: {
              0: pw.FlexColumnWidth(2),
              1: pw.FlexColumnWidth(1),
            },
            children: [
              pw.TableRow(
                decoration: pw.BoxDecoration(color: PdfColor.fromHex('#1E3A8A')),
                children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Text('Name', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white)),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Text('Steps', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white)),
                  ),
                ],
              ),
              ...((team['group'] as List).map((item) {
                final isCaptain = item.name.toString().contains('(C)');
                return pw.TableRow(
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text(
                        item.name,
                        style: pw.TextStyle(
                          fontWeight: isCaptain ? pw.FontWeight.bold : pw.FontWeight.normal,
                          color: PdfColor.fromHex('#1E3A8A'),
                        ),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text(
                        formatNumber(int.tryParse(item.jan.toString()) ?? 0),
                        style: pw.TextStyle(fontWeight: pw.FontWeight.normal, color: PdfColors.black),
                      ),
                    ),
                  ],
                );
              })),
            ],
          ),
          pw.SizedBox(height: 10),
          pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Container(
              padding: const pw.EdgeInsets.symmetric(vertical: 6, horizontal: 16),
              decoration: pw.BoxDecoration(
                color: PdfColor.fromHex('#FFA500'),
                borderRadius: pw.BorderRadius.circular(8),
              ),
              child: pw.Text(
                ' ${formatNumber(team['total'])} Steps',
                style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('#1E3A8A')),
              ),
            ),
          ),
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
            child: pw.Text('Generated on ${DateTime.now()}', style: pw.TextStyle(fontSize: 10, color: PdfColors.grey)),
          ),
        ],
      ),
    );
    await Printing.layoutPdf(onLayout: (format) async => pdf.save());
  }
}
