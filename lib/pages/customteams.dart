import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wellnesswalkathon/pages/walkthon_stats/animater_text.dart';

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
                  child: ListView.builder(
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
                                Row(
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
                                ],
                            ),
                          ),
                        ),
                      );
                    },
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
}
