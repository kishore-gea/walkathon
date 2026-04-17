import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:wellnesswalkathon/data_constants/stepcount_data.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../model/participent_data.dart';
import '../style/text_style.dart';
import '../utils/pdf_utils.dart';

class UserDetail extends StatefulWidget {
  final ParticipentData participant;
  final int totalSteps;
  final int hyderabadSteps;
  final int bangaloreSteps;
  final int rank;
  final List<ParticipentData> participants;

  const UserDetail({
    super.key,
    required this.participant,
    required this.totalSteps,
    required this.hyderabadSteps,
    required this.bangaloreSteps,
    required this.rank,
    required this.participants,
  });

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  late final double individualWithIndia;
  late final double individualWithLocation;
  late int locationRank = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    individualWithIndia = calculatePercentage(
      int.parse(widget.participant.total.toString()),
      widget.totalSteps,
    );

    if (widget.participant.location == 'HYD') {
      individualWithLocation = calculatePercentageLocation(
        int.parse(widget.participant.total.toString()),
        widget.hyderabadSteps,
      );
    } else if (widget.participant.location == 'BLR') {
      individualWithLocation = calculatePercentageLocation(
        int.parse(widget.participant.total.toString()),
        widget.bangaloreSteps,
      );
    }

    final locationList =
    widget.participants
        .where((p) => p.location == widget.participant.location)
        .toList();

    for (int i = 0; i < locationList.length; i++) {
      if (locationList[i].name == widget.participant.name) {
        locationRank = i + 1;
        break;
      }
    }
  }

  double calculatePercentage(int individualSteps, int totalSteps) {
    if (totalSteps == 0) return 0;
    return (individualSteps / totalSteps) * 100;
  }

  double calculatePercentageLocation(int individualSteps, int localSteps) {
    if (localSteps == 0) return 0;
    return (individualSteps / localSteps) * 100;
  }

  @override
  Widget build(BuildContext context) {
    final String displayName = widget.participant.name ?? 'Unknown';
    final String location = widget.participant.location ?? 'N/A';

    return Scaffold(
      backgroundColor: AppTextStyles.white,
      appBar: AppBar(
        title: Text(
          'Participant Details',
          style: AppTextStyles.headline.copyWith(
            color: AppTextStyles.primaryBlue,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: AppTextStyles.primaryBlue),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor:
                      widget.participant.gender == 'Male'
                          ? AppTextStyles.primaryBlue
                          : Colors.pinkAccent,
                      child: Text(
                        widget.participant.name!.isNotEmpty
                            ? widget.participant.name![0].toUpperCase()
                            : 'P',
                        style: TextStyle(
                          fontSize: 39,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(height: 5),
                    Text(
                      displayName,
                      style: AppTextStyles.headline.copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                        color: AppTextStyles.primaryBlue,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: AppTextStyles.orange,
                          size: 20,
                        ),
                        SizedBox(width: 2),
                        Text(
                          location,
                          style: AppTextStyles.body.copyWith(
                            fontSize: 18,
                            color: AppTextStyles.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      AppTextStyles().formatIndianNumber(
                        int.parse(widget.participant.total.toString()),
                      ),
                      style: AppTextStyles.headline.copyWith(
                        fontSize: 30,
                        color: AppTextStyles.primaryBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    // getMonthDifferenceValue(widget.participant),
                    SizedBox(height: 10),
                    // getAwardsForUser(widget.participant),
                    // SizedBox(height: 10),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade400,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.orange.shade400),
                      ),
                      child: Text(
                        'IND #${widget.rank.toString()}',
                        style: AppTextStyles.body.copyWith(
                          fontSize: 20,
                          color: AppTextStyles.primaryBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Team contribution to the Walkathon is highly appreciated!',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body.copyWith(
                        fontSize: 14,
                        color: AppTextStyles.primaryBlue,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: 10),

                    Text(
                      'Your steps contribution towards the Wellness Walkathon ${DateTime.now().year} is,',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body.copyWith(
                        fontSize: 14,
                        color: AppTextStyles.primaryBlue,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'INDIA : ${individualWithIndia.toStringAsFixed(2)}%',

                      textAlign: TextAlign.center,
                      style: AppTextStyles.subtitle.copyWith(
                        fontSize: 16,
                        color: AppTextStyles.primaryBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    location == 'HYD'
                        ? Text(
                      'HYD : ${individualWithLocation.toStringAsFixed(2)}%',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.subtitle.copyWith(
                        fontSize: 16,
                        color: AppTextStyles.primaryBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                        : Text(
                      'BLR : ${individualWithLocation.toStringAsFixed(2)}%',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.subtitle.copyWith(
                        fontSize: 16,
                        color: AppTextStyles.primaryBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Divider(color: AppTextStyles.primaryBlue, thickness: 1),
                    Text(
                      textAlign: TextAlign.center,
                      'Your steps contribution towards the \nWellness Walkathon ${DateTime.now().year}',
                      style: AppTextStyles.body.copyWith(
                        fontSize: 18,
                        color: AppTextStyles.primaryBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Divider(color: AppTextStyles.lightGrey, thickness: 1),
                getDataForMonthToDisplay(widget.participant),
                SizedBox(height: 10),
                Text(
                  'Your steps contribution towards the Wellness Walkathon in Graphical Mode ${DateTime.now().year} is,',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body.copyWith(
                    fontSize: 14,
                    color: AppTextStyles.primaryBlue,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  width: 400, // Give it a definite width
                  height: 300, // and height
                  child: LineChart(
                    LineChartData(
                      maxX: 12,
                      // point show label
                      lineBarsData: [
                        LineChartBarData(
                          spots: generateFlSpots(widget.participant),
                          isCurved: true,
                          barWidth: 3,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  'Above are Month"s in numerical format',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body.copyWith(
                    fontSize: 14,
                    color: AppTextStyles.primaryBlue,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: generateAndShareUserPdf,
        label: Text('Generate PDF'),
        icon: Icon(Icons.picture_as_pdf),
      ),
    );
  }

  Future<void> generateAndShareUserPdf() async {
    final pdf = await generateParticipantPdf(
      participant: widget.participant,
      rank: widget.rank,
      generatedDate: DateTime(2026, 2, 17),
    );
    await Printing.layoutPdf(onLayout: (format) async => pdf.save());
  }

  bool compareWithPreviousMonth(String? mar, String? apr) {
    if (mar == null || apr == null) {
      return false;
    }
    final int marSteps = int.parse(mar);
    final int aprSteps = int.parse(apr);

    // Compare the steps for March and April
    if (aprSteps > marSteps) {
      return true;
    } else {
      return false;
    }
  }

  String getAvgForMonth(String count, int monthCode) {
    int steps = int.parse(count);
    var val = 0;
    if (monthCode == 3) {
      val = 31;
    } else if (monthCode == 4) {
      val = 30;
    } else if (monthCode == 5) {
      val = 31;
    } else if (monthCode == 6) {
      val = 30;
    } else if (monthCode == 7) {
      val = 31;
    } else if (monthCode == 8) {
      val = 31;
    } else if (monthCode == 9) {
      val = 30;
    }else if (monthCode == 10) {
      val = 31;
    } else if (monthCode == 11) {
      val = 30;
    }else if(monthCode == 12){
      val = 31;
    }else if(monthCode == 13){
      val = 31;
    }
    int avg = (steps / val).toInt();
    return AppTextStyles().formatIndianNumber(int.parse(avg.toString()));
  }

  int getStepGrowth(ParticipentData participant) {
    // Map months to their corresponding step values
    Map<int, String?> monthSteps = {
      3: participant.mar, // March
      4: participant.apr,
      5: participant.may,
      6: participant.jun,
      7: participant.jul,
      8: participant.aug,
      9: participant.sep,
      10: participant.oct,
      11: participant.nov,
    };

    int currentMonth = DateTime.now().month;

    if (currentMonth <= 3 || currentMonth > 9) {
      return 0; // Not enough data to compare
    }

    int thisMonthSteps = int.tryParse(monthSteps[currentMonth] ?? '0') ?? 0;
    int prevMonthSteps = int.tryParse(monthSteps[currentMonth - 1] ?? '0') ?? 0;

    return thisMonthSteps > 0 ? thisMonthSteps - prevMonthSteps : 0;
  }

  Widget getMonthDifferenceValue(ParticipentData participant) {
    int marSteps = int.parse(participant.mar.toString());
    int aprSteps = int.parse(participant.apr.toString());
    int maySteps = int.parse(participant.may.toString());
    int junSteps = int.parse(participant.jun.toString());
    int julSteps = int.parse(participant.jul.toString());
    int augSteps = int.parse(participant.aug.toString());
    int sepSteps = int.parse(participant.sep.toString());
    int octSteps = int.parse(participant.oct.toString());
    int novSteps = int.parse(participant.nov.toString());
    int decSteps = int.parse(participant.dec.toString());

    var val = aprSteps - marSteps;
    if (DateTime.now().month == 6 && maySteps > 0) {
      val = aprSteps > 0 ? maySteps - aprSteps : 0;
    } else if (DateTime.now().month == 7 && junSteps > 0) {
      val = junSteps - maySteps;
    } else if (DateTime.now().month == 8 && julSteps > 0) {
      val = julSteps - junSteps;
    } else if (DateTime.now().month == 9 && augSteps > 0) {
      val = augSteps - julSteps;
    } else if (DateTime.now().month == 10 && sepSteps > 0) {
      val = sepSteps - augSteps;
    }else if (DateTime.now().month == 11 && octSteps > 0) {
      val = octSteps - sepSteps;
    }else if (DateTime.now().month == 12  && novSteps > 0) {
      val = novSteps - octSteps;
    } else if(DateTime.now().month == 1 && decSteps > 0){
      val = decSteps - novSteps;
    }
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
      decoration: BoxDecoration(
        color: AppTextStyles.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTextStyles.primaryBlue, width: 2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            val > 0
                ? AppTextStyles().formatIndianNumber(val)
                : val < 0
                ? AppTextStyles().formatIndianNumber(val)
                : 'N.A',

            textAlign: TextAlign.center,
            style: AppTextStyles.subtitle.copyWith(
              fontSize: 16,
              color: AppTextStyles.primaryBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 5),
          val > 0
              ? Icon(Icons.trending_up_outlined, color: Colors.green)
              : aprSteps == 0 || maySteps == 0
              ? Icon(Icons.timer, color: Colors.grey)
              : Icon(Icons.trending_down_outlined, color: Colors.redAccent),
        ],
      ),
    );
  }

  Widget getLevelForUser(ParticipentData participant) {
    int totalSteps = int.parse(participant.total.toString());
    int highestVal = StepCountData().getHighestValueOfWalkathon();

    var levelVal = (totalSteps / highestVal) * 100;
    int stars = 0;
    // caluculate the level of the user
    // if more than 90% of the highest value then 1st level
    // if more than 80% of the highest value then 2nd level
    // if more than 70% of the highest value then 3rd level
    // if more than 60% of the highest value then 4th level
    // if more than 50% of the highest value then 5th level
    if (levelVal >= 80) {
      stars = 6;
    } else if (levelVal >= 60) {
      stars = 5;
    } else if (levelVal >= 40) {
      stars = 4;
    } else if (levelVal >= 30) {
      stars = 3;
    } else if (levelVal >= 25) {
      stars = 2;
    } else {
      stars = 1;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(
        stars,
            (index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Icon(
            Icons.star,
            color: stars < 4 ? Colors.red : Colors.orange,
          ),
        ),
      ),
    );
  }

  getAwardsForUser(ParticipentData participant) {
    final awardsString = participant.awards ?? '';
    if (awardsString.isNotEmpty) {
      final list = awardsString.split(',');
      //MAR-L to MAR - LEADER in the list

      for (int i = 0; i < list.length; i++) {
        if (list[i].contains('MAR-L')) {
          list[i] = 'MAR - LEADER';
        } else if (list[i].contains('MAR-RL')) {
          list[i] = 'MAR - ROLLING LEADER';
        } else if (list[i].contains('APR-L')) {
          list[i] = 'APR - LEADER';
        } else if (list[i].contains('APR-RL')) {
          list[i] = 'APR - ROLLING LEADER';
        }
      }

      //SIMILARLY FOR LIST.LENGTH = 1 OR FOR STRIN

      return list.length == 1
          ? Container(
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.orange.shade400),
        ),
        child: Text(
          list[0],
          style: AppTextStyles.body.copyWith(
            fontSize: 16,
            color: AppTextStyles.primaryBlue,
            fontWeight: FontWeight.w500,
          ),
        ),
      )
          : Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          list.length,
              (index) =>
          list[index].isNotEmpty
              ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Container(
              margin: EdgeInsets.only(top: 5),
              padding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.orange.shade400,
                  width: 4,
                ),
              ),
              child: Text(
                list[index],
                style: AppTextStyles.body.copyWith(
                  fontSize: 16,
                  color: AppTextStyles.primaryBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
              : SizedBox(),
        ),
      );
    } else {
      return SizedBox(height: 0);
    }
  }

Widget getDataForMonthToDisplay(ParticipentData participant) {
    final Map<String, dynamic> json = participant.toJson();

    int readInt(List<String> keys) {
      for (final key in keys) {
        if (json.containsKey(key)) {
          final parsed = int.tryParse('${json[key]}');
          if (parsed != null) return parsed;
        }
      }
      return 0;
    }

    // Season 1: Mar'25 → Feb'26  |  Season 2: Mar'26 → May'26
    final List<Map<String, dynamic>> months = [
      {'label': 'MAR 2025', 'steps': readInt(['steps', 'mar', 'Mar']), 'days': 31},
      {'label': 'APR 2025', 'steps': readInt(['apr', 'Apr']), 'days': 30},
      {'label': 'MAY 2025', 'steps': readInt(['may', 'May']), 'days': 31},
      {'label': 'JUN 2025', 'steps': readInt(['jun', 'Jun']), 'days': 30},
      {'label': 'JUL 2025', 'steps': readInt(['jul', 'Jul']), 'days': 31},
      {'label': 'AUG 2025', 'steps': readInt(['aug', 'Aug']), 'days': 31},
      {'label': 'SEP 2025', 'steps': readInt(['sep', 'sept', 'Sep', 'Sept']), 'days': 30},
      {'label': 'OCT 2025', 'steps': readInt(['oct', 'Oct']), 'days': 31},
      {'label': 'NOV 2025', 'steps': readInt(['nov', 'Nov']), 'days': 30},
      {'label': 'DEC 2025', 'steps': readInt(['dec', 'Dec']), 'days': 31},
      // Season 1 tail
      {'label': 'JAN 2026', 'steps': readInt(['jan26', 'Jan26']), 'days': 31},
      {'label': 'FEB 2026', 'steps': readInt(['feb26', 'Feb26']), 'days': 28},
      // Season 2
      {'label': 'MAR 2026', 'steps': readInt(['mar26', 'Mar26']), 'days': 31},
      // {'label': 'APR 2026', 'steps': readInt(['apr26', 'Apr26']), 'days': 30},
      // {'label': 'MAY 2026', 'steps': readInt(['may26', 'May26']), 'days': 31},
    ];

    final List<Widget> monthWidgets = [];

    for (int i = 0; i < months.length; i++) {
      final String monthLabel = months[i]['label'] as String;
      final int steps = months[i]['steps'] as int;
      final int days = months[i]['days'] as int;
      final int avg = days > 0 ? (steps / days).floor() : 0;

      final bool showDiff = i > 0;
      final int difference = showDiff ? steps - (months[i - 1]['steps'] as int) : 0;

      final Color diffColor = difference > 0
          ? Colors.green
          : difference < 0
              ? Colors.red
              : Colors.grey;

      monthWidgets.add(
        Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: BoxDecoration(
            color: AppTextStyles.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppTextStyles.primaryBlue, width: 3),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    monthLabel,
                    style: AppTextStyles.subtitle.copyWith(
                      fontSize: 20,
                      color: AppTextStyles.primaryBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppTextStyles.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppTextStyles.orange, width: 3),
                      ),
                      child: Text(
                        AppTextStyles().formatIndianNumber(avg),
                        style: AppTextStyles.subtitle.copyWith(
                          fontSize: 16,
                          color: AppTextStyles.primaryBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    showDiff
                        ? Container(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: diffColor,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: diffColor, width: 3),
                            ),
                            child: Row(
                              children: [
                                difference > 0
                                    ? Icon(Icons.trending_up_outlined, color: Colors.white, size: 15)
                                    : difference < 0
                                        ? Icon(Icons.trending_down_outlined, color: Colors.white, size: 15)
                                        : Icon(Icons.trending_flat_outlined, color: Colors.white, size: 15),
                                SizedBox(width: 5),
                                Text(
                                  AppTextStyles().formatIndianNumber(difference),
                                  style: AppTextStyles.subtitle.copyWith(
                                    fontSize: 15,
                                    color: AppTextStyles.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : SizedBox(width: 0, height: 0),
                    SizedBox(width: 10),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppTextStyles.primaryBlue,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppTextStyles.primaryBlue, width: 3),
                      ),
                      child: Text(
                        AppTextStyles().formatIndianNumber(steps),
                        style: AppTextStyles.subtitle.copyWith(
                          fontSize: 18,
                          color: AppTextStyles.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: monthWidgets,
    );
  }
  List<FlSpot> generateFlSpots(ParticipentData participant) {
    // Season 1: codes 3–14 mapped to x=1..12, Season 2: codes 15–17 mapped to x=13..15
    final allMonths = [
      ...StepCountData.season1Months,
      ...StepCountData.season2Months,
    ];

    List<FlSpot> spots = [];
    for (int i = 0; i < allMonths.length; i++) {
      final code = allMonths[i]['code'] as int;
      final raw = StepCountData.getMonthValue(participant, code);
      final y = double.tryParse(raw) ?? 0;
      if (y > 0) {
        spots.add(FlSpot((i + 1).toDouble(), y));
      }
    }

    return spots;
  }
}

// Widget buildMonthCard(String monthsForWalk, ParticipentData participant) {
//   final isSpecial = monthsForWalk == 'MAR';
//   final backgroundColor =
//       isSpecial ? AppTextStyles.primaryBlue : Colors.green.shade500;
//   final borderColor =
//       isSpecial ? AppTextStyles.primaryBlue : Colors.red.shade500;
//
//   return Container(
//     margin: EdgeInsets.all(5),
//     padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//     decoration: BoxDecoration(
//       color: backgroundColor,
//       borderRadius: BorderRadius.circular(16),
//       border: Border.all(color: borderColor, width: 3),
//     ),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           monthsForWalk,
//           style: AppTextStyles.subtitle.copyWith(
//             fontSize: 20,
//             color: AppTextStyles.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         Container(
//           padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//           decoration: BoxDecoration(
//             color: AppTextStyles.white,
//             borderRadius: BorderRadius.circular(16),
//             border: Border.all(color: AppTextStyles.orange, width: 3),
//           ),
//           child: Text(
//             getAvgForMonth('3333333', DateTime.now().month),
//             style: AppTextStyles.subtitle.copyWith(
//               fontSize: 16,
//               color: AppTextStyles.primaryBlue,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         Text(
//           AppTextStyles().formatIndianNumber(int.parse(month.data)),
//           style: AppTextStyles.subtitle.copyWith(
//             fontSize: 20,
//             color: AppTextStyles.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ],
//     ),
//   );
// }
