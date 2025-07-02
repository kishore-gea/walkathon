import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:wellnesswalkathon/data_constants/stepcount_data.dart';

import '../model/participent_data.dart';
import '../style/text_style.dart';

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
                    getMonthDifferenceValue(widget.participant),
                    SizedBox(height: 10),
                    getAwardsForUser(widget.participant),
                    SizedBox(height: 10),
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
                      maxX: 8,
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
    );
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
    }
    int avg = (steps / val).toInt();
    return AppTextStyles().formatIndianNumber(int.parse(avg.toString()));
  }

  int getStepGrowth(ParticipentData participant) {
    // Map months to their corresponding step values
    Map<int, String?> monthSteps = {
      3: participant.steps, // March
      4: participant.apr,
      5: participant.may,
      6: participant.jun,
      7: participant.jul,
      8: participant.aug,
      9: participant.sep,
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
    int marSteps = int.parse(participant.steps.toString());
    int aprSteps = int.parse(participant.apr.toString());
    int maySteps = int.parse(participant.may.toString());
    int junSteps = int.parse(participant.jun.toString());
    int julSteps = int.parse(participant.jul.toString());
    int augSteps = int.parse(participant.aug.toString());
    int sepSteps = int.parse(participant.sep.toString());
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
    int currentMonth = DateTime.now().month;
    List<Widget> monthWidgets = [];
    int difference = 0;

    for (int i = 3; i < currentMonth && i <= 9; i++) {
      String totalSteps = '0';
      String monthForWalk = '';

      switch (i) {
        case 3:
          totalSteps = participant.steps ?? '0';
          monthForWalk = 'MAR';
          break;
        case 4:
          totalSteps = participant.apr ?? '0';
          monthForWalk = 'APR';
          difference =
              int.parse(participant.apr.toString()) -
              int.parse(participant.steps.toString());
          break;
        case 5:
          totalSteps = participant.may ?? '0';
          monthForWalk = 'MAY';
          difference =
              int.parse(participant.may.toString()) -
              int.parse(participant.apr.toString());
          break;
        case 6:
          totalSteps = participant.jun ?? '0';
          monthForWalk = 'JUN';
          difference =
              int.parse(participant.jun.toString()) -
              int.parse(participant.may.toString());
          break;
        case 7:
          totalSteps = participant.jul ?? '0';
          monthForWalk = 'JUL';
          difference =
              int.parse(participant.jul.toString()) -
              int.parse(participant.jun.toString());
          break;
        case 8:
          totalSteps = participant.aug ?? '0';
          monthForWalk = 'AUG';
          difference =
              int.parse(participant.aug.toString()) -
              int.parse(participant.jul.toString());
          break;
        case 9:
          totalSteps = participant.sep ?? '0';
          monthForWalk = 'SEP';
          difference =
              int.parse(participant.sep.toString()) -
              int.parse(participant.aug.toString());
          break;
      }

      totalSteps != '0'
          ? monthWidgets.add(
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
                        monthForWalk,
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
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: AppTextStyles.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: AppTextStyles.orange,
                              width: 3,
                            ),
                          ),
                          child: Text(
                            getAvgForMonth(totalSteps, i),
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
                        i > 3
                            ? Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    difference > 0 ? Colors.green : Colors.red,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color:
                                      difference > 0
                                          ? Colors.green
                                          : Colors.red,
                                  width: 3,
                                ),
                              ),
                              child: Row(
                                children: [
                                  difference > 0
                                      ? Icon(
                                        Icons.trending_up_outlined,
                                        color: Colors.white,
                                        size: 15,
                                      )
                                      : Icon(
                                        Icons.trending_down_outlined,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                  SizedBox(width: 5),
                                  Text(
                                    AppTextStyles().formatIndianNumber(
                                      difference,
                                    ),
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
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: AppTextStyles.primaryBlue,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: AppTextStyles.primaryBlue,
                              width: 3,
                            ),
                          ),
                          child: Text(
                            AppTextStyles().formatIndianNumber(
                              int.parse(totalSteps.toString()),
                            ),
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
          )
          : SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: monthWidgets,
    );
  }

  List<FlSpot> generateFlSpots(ParticipentData participant) {
    Map<int, String?> monthData = {
      3: participant.steps, // March
      4: participant.apr,
      5: participant.may,
      6: participant.jun,
      7: participant.jul,
      8: participant.aug,
      9: participant.sep,
    };

    List<FlSpot> spots = [];

    for (int month = 3; month < DateTime.now().month; month++) {
      String? value = monthData[month];
      double y = 0;

      if (value != null && value != '0') {
        try {
          y = double.parse(value);
        } catch (_) {
          y = 0; // fallback if parse fails
        }
        spots.add(FlSpot(month.toDouble(), y));
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
