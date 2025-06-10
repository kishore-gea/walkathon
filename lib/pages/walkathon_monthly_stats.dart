import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data_constants/stepcount_data.dart';
import '../style/text_style.dart';

class MonthlyStats extends StatefulWidget {
  const MonthlyStats({super.key});

  @override
  State<MonthlyStats> createState() => _MonthlyStatsState();
}

class _MonthlyStatsState extends State<MonthlyStats> {
  var totalStepCountHYDCurrentMonth = 0.obs;
  var totalStepCountBLRCurrentMonth = 0.obs;
  var totalStepCountHYD = 0.obs;
  var totalStepCountBLR = 0.obs;
  var differenceStepsMonthly = 0.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Walkathon Monthly Stats',
          style: AppTextStyles.headline.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTextStyles.primaryBlue,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Expanded(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                FutureBuilder(
                  future: fetchStepCountData(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final data = snapshot.data![index];
                        return Card(
                          color: Colors.blue.shade200,
                          elevation: 8,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        children: [
                                          // Container(
                                          //   padding: const EdgeInsets.all(7.0),
                                          //   decoration: BoxDecoration(
                                          //     shape: BoxShape.circle,
                                          //     color: AppTextStyles.white,
                                          //   ),
                                          //   child: Image.asset(
                                          //     'assets/images/hyd.png', // Path to your image
                                          //     width:
                                          //         25, // Adjust width as per your logo size
                                          //     height:
                                          //         25, // Adjust height if needed
                                          //   ),
                                          // ),
                                          SizedBox(height: 10),
                                          Text(
                                            AppTextStyles().formatIndianNumber(
                                              data.totalStepsHYD!,
                                            ),
                                            style: AppTextStyles.subtitle
                                                .copyWith(
                                                  color: AppTextStyles.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22,
                                                ),
                                          ),
                                          Text(
                                            'Hyderabad'.toUpperCase(),
                                            style: AppTextStyles.subtitle
                                                .copyWith(
                                                  color: AppTextStyles.black,
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 14,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        children: [
                                          Text(
                                            '${data.month}',
                                            style: AppTextStyles.headline
                                                .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      AppTextStyles.primaryBlue,
                                                  fontSize: 20,
                                                ),
                                          ),
                                          SizedBox(width: 10),
                                          data.month != '3'
                                              ? Container(
                                                decoration: BoxDecoration(
                                                  color:
                                                      AppTextStyles.primaryBlue,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        vertical: 5.0,
                                                        horizontal: 8,
                                                      ),
                                                  child: Text(
                                                    ' ${AppTextStyles().formatIndianNumber(data.currentMonthTotalSteps!)}',
                                                    style: AppTextStyles
                                                        .headline
                                                        .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              AppTextStyles
                                                                  .white,
                                                          fontSize: 20,
                                                        ),
                                                  ),
                                                ),
                                              )
                                              : SizedBox(),
                                          SizedBox(height: 15),
                                          data.month != 'March'
                                              ? getMonthDifferenceValue(
                                                snapshot
                                                    .data![index]
                                                    .currentMonthTotalSteps!,
                                                snapshot
                                                    .data![index - 1]
                                                    .currentMonthTotalSteps!,
                                              )
                                              : SizedBox(),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        children: [
                                          // Container(
                                          //   padding: const EdgeInsets.all(7.0),
                                          //   decoration: BoxDecoration(
                                          //     shape: BoxShape.circle,
                                          //     color: AppTextStyles.white,
                                          //   ),
                                          //   child: Image.asset(
                                          //     'assets/images/blr.png', // Path to your image
                                          //     width:
                                          //         25, // Adjust width as per your logo size
                                          //     height:
                                          //         25, // Adjust height if needed
                                          //   ),
                                          // ),
                                          SizedBox(height: 10),
                                          Text(
                                            AppTextStyles().formatIndianNumber(
                                              data.totalStepsBLR!,
                                            ),
                                            style: AppTextStyles.subtitle
                                                .copyWith(
                                                  color: AppTextStyles.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22,
                                                ),
                                          ),
                                          Text(
                                            'Bangalore'.toUpperCase(),
                                            style: AppTextStyles.subtitle
                                                .copyWith(
                                                  color: AppTextStyles.black,
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 14,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getMonthDifferenceValue(int val1, int val2) {
    final val = val1 - val2;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
      decoration: BoxDecoration(
        color: AppTextStyles.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.orange.shade200, width: 2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppTextStyles().formatIndianNumber(val),
            textAlign: TextAlign.center,
            style: AppTextStyles.subtitle.copyWith(
              fontSize: 18,
              color: AppTextStyles.primaryBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 5),
          val > 0
              ? Icon(Icons.trending_up_outlined, color: Colors.green.shade700)
              : Icon(Icons.trending_down_outlined, color: Colors.redAccent),
        ],
      ),
    );
  }

  Future<List<MonthlyData>> fetchStepCountData() async {
    int totalMonthStepsHYD = 0;
    int totalMonthStepsBLR = 0;
    List<MonthlyData> monthlyStatsList = [];
    final data = StepCountData.originalData;

    for (int i = 4; i <= DateTime.now().month; i++) {
      int dateMonth = i;
      String monthName = '';
      for (int i = 0; i < data.length; i++) {
        if (data[i].location == "HYD") {
          if (dateMonth == 4) {
            monthName = 'March';
            totalMonthStepsHYD += int.parse(data[i].steps.toString());
          } else if (dateMonth == 5) {
            monthName = 'April';
            totalMonthStepsHYD += int.parse(data[i].apr.toString());
          } else if (dateMonth == 6) {
            monthName = 'May';
            totalMonthStepsHYD += int.parse(data[i].may.toString());
          } else if (dateMonth == 7) {
            monthName = 'June';
            totalMonthStepsHYD += int.parse(data[i].jun.toString());
          } else if (dateMonth == 8) {
            monthName = 'July';
            totalMonthStepsHYD += int.parse(data[i].jul.toString());
          } else if (dateMonth == 9) {
            monthName = 'August';
            totalMonthStepsHYD += int.parse(data[i].aug.toString());
          } else if (dateMonth == 10) {
            monthName = 'September';
            totalMonthStepsHYD += int.parse(data[i].sep.toString());
          }

          totalStepCountHYDCurrentMonth.value = totalMonthStepsHYD;
          totalStepCountHYD.value += int.parse(data[i].total.toString());
        } else if (data[i].location == "BLR") {
          if (dateMonth == 4) {
            monthName = 'March';
            totalMonthStepsBLR += int.parse(data[i].steps.toString());
          } else if (dateMonth == 5) {
            monthName = 'April';
            totalMonthStepsBLR += int.parse(data[i].apr.toString());
          } else if (dateMonth == 6) {
            monthName = 'May';
            totalMonthStepsBLR += int.parse(data[i].may.toString());
          } else if (dateMonth == 7) {
            monthName = 'June';
            totalMonthStepsBLR += int.parse(data[i].jun.toString());
          } else if (dateMonth == 8) {
            monthName = 'July';
            totalMonthStepsBLR += int.parse(data[i].jul.toString());
          } else if (dateMonth == 9) {
            monthName = 'August';
            totalMonthStepsBLR += int.parse(data[i].aug.toString());
          } else if (dateMonth == 10) {
            monthName = 'September';
            totalMonthStepsBLR += int.parse(data[i].sep.toString());
          }

          totalStepCountBLRCurrentMonth.value = totalMonthStepsBLR;
          totalStepCountBLR.value += int.parse(data[i].total.toString());
        }
      }
      differenceStepsMonthly.value =
          totalStepCountHYDCurrentMonth.value -
          totalStepCountBLRCurrentMonth.value;

      MonthlyData monthlyData = MonthlyData(
        month: monthName,
        totalStepsHYD: totalStepCountHYDCurrentMonth.value,
        totalStepsBLR: totalStepCountBLRCurrentMonth.value,
        differenceSteps: differenceStepsMonthly.value,
        currentMonthTotalSteps:
            totalStepCountHYDCurrentMonth.value +
            totalStepCountBLRCurrentMonth.value,
      );

      // print('Monthly Data for Month $i: $monthlyData');
      // print('Total Steps HYD: $i --> ${totalStepCountHYDCurrentMonth.value}');
      // print('Total Steps BLR: $i --> ${totalStepCountBLRCurrentMonth.value}');

      monthlyStatsList.add(monthlyData);
      totalMonthStepsHYD = 0; // Reset for next month
      totalMonthStepsBLR = 0; // Reset for next month
      totalStepCountHYDCurrentMonth.value = 0; // Reset for next month
      totalStepCountBLRCurrentMonth.value = 0; // Reset for next month
      totalStepCountHYD.value = 0; // Reset for next month
      totalStepCountBLR.value = 0; // Reset for next month
    }

    // Update the observable variables with the calculated values

    // print('Monthly Stats: $monthlyStatsList');

    return monthlyStatsList;
  }
}

class MonthlyData {
  String? month;
  int? totalStepsHYD;
  int? totalStepsBLR;
  int? differenceSteps;
  int? currentMonthTotalSteps;

  MonthlyData({
    required this.month,
    required this.totalStepsHYD,
    required this.totalStepsBLR,
    required this.differenceSteps,
    required this.currentMonthTotalSteps,
  });

  factory MonthlyData.fromJson(Map<String, dynamic> json) {
    return MonthlyData(
      month: json['month'] as String,
      totalStepsHYD: _parseInt(json['totalStepsHYD']),
      totalStepsBLR: _parseInt(json['totalStepsBLR']),
      differenceSteps: _parseInt(json['differenceSteps']),
      currentMonthTotalSteps: _parseInt(json['currentMonthTotalSteps']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'totalStepsHYD': totalStepsHYD,
      'totalStepsBLR': totalStepsBLR,
      'differenceSteps': differenceSteps,
      'currentMonthTotalSteps': currentMonthTotalSteps,
    };
  }

  @override
  String toString() {
    return 'MonthlyData(month: $month, HYD: $totalStepsHYD, BLR: $totalStepsBLR, Diff: $differenceSteps, Current: $currentMonthTotalSteps)';
  }

  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }
}

// Row(
//   children: [
//     Text(
//       textAlign: TextAlign.start,
//       'MARCH - 2025',
//       style: AppTextStyles.headline.copyWith(
//         fontWeight: FontWeight.bold,
//         color: AppTextStyles.primaryBlue,
//
//         fontSize: 20,
//       ),
//     ),
//     SizedBox(width: 10),
//     SizedBox(width: 10),
//   ],
// ),
// Align(
//   child:
//   Row(
//     children: [
//       Container(
//         padding: const EdgeInsets.symmetric(
//           vertical: 5.0,
//           horizontal: 8,
//         ),
//         decoration: BoxDecoration(
//           color: AppTextStyles.primaryBlue,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Text(
//           ' ${AppTextStyles().formatIndianNumber(totalStepCountMAR.toInt())}',
//           style: AppTextStyles.headline.copyWith(
//             fontWeight: FontWeight.bold,
//             color: AppTextStyles.white,
//             fontSize: 20,
//           ),
//         ),
//       ),
//       SizedBox(width: 5),
//       Text(
//         'Steps',
//         style: AppTextStyles.headline.copyWith(
//           fontWeight: FontWeight.normal,
//           color: AppTextStyles.primaryBlue,
//           fontSize: 15,
//         ),
//       ),
//     ],
//   ),
// ),
// SizedBox(height: 10),
// Row(
//   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   crossAxisAlignment: CrossAxisAlignment.center,
//   children: [
//     Container(
//       width: MediaQuery.of(context).size.width * 0.45,
//       padding: const EdgeInsets.all(8.0),
//       decoration: BoxDecoration(
//         color: Colors.pink.shade100,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Container(
//             padding: const EdgeInsets.all(7.0),
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: AppTextStyles.white,
//             ),
//             child: Image.asset(
//               'assets/images/hyd.png', // Path to your image
//               width: 25, // Adjust width as per your logo size
//               height: 25, // Adjust height if needed
//             ),
//           ),
//           SizedBox(height: 10),
//           Obx(
//             () => Text(
//               AppTextStyles().formatIndianNumber(
//                 totalStepCountHYDMar.value,
//               ),
//               style: AppTextStyles.subtitle.copyWith(
//                 color: AppTextStyles.black,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 22,
//               ),
//             ),
//           ),
//           Text(
//             'Hyderabad',
//             style: AppTextStyles.subtitle.copyWith(
//               color: AppTextStyles.black,
//               fontWeight: FontWeight.w300,
//               fontSize: 11,
//             ),
//           ),
//         ],
//       ),
//     ),
//     Container(
//       width: MediaQuery.of(context).size.width * 0.45,
//       padding: const EdgeInsets.all(8.0),
//       decoration: BoxDecoration(
//         color: Colors.pink.shade100,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Container(
//             padding: const EdgeInsets.all(7.0),
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: AppTextStyles.white,
//             ),
//             child: Image.asset(
//               'assets/images/blr.png', // Path to your image
//               width: 25, // Adjust width as per your logo size
//               height: 25, // Adjust height if needed
//             ),
//           ),
//           SizedBox(height: 10),
//           Obx(
//             () => Text(
//               AppTextStyles().formatIndianNumber(
//                 totalStepCountBLRMar.value,
//               ),
//               style: AppTextStyles.subtitle.copyWith(
//                 color: AppTextStyles.black,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 22,
//               ),
//             ),
//           ),
//           Text(
//             'Bangalore',
//             style: AppTextStyles.subtitle.copyWith(
//               color: AppTextStyles.black,
//               fontWeight: FontWeight.w300,
//               fontSize: 11,
//             ),
//           ),
//         ],
//       ),
//     ),
//   ],
// ),
// SizedBox(height: 10),
// Divider(color: AppTextStyles.metallicGrey, thickness: 1),
// SizedBox(height: 10),
// Row(
//   children: [
//     Text(
//       textAlign: TextAlign.start,
//       'APRIL - 2025',
//       style: AppTextStyles.headline.copyWith(
//         fontWeight: FontWeight.bold,
//         color: AppTextStyles.primaryBlue,
//         fontSize: 20,
//       ),
//     ),
//     SizedBox(width: 10),
//     getMonthDifferenceValue(
//       totalStepCountAPR.value,
//       totalStepCountMAR.value,
//     ),
//     SizedBox(width: 10),
//   ],
// ),
// SizedBox(height: 0),
// Align(
//   alignment: Alignment.topLeft,
//   child: Row(
//     children: [
//       Container(
//         padding: const EdgeInsets.symmetric(
//           vertical: 5.0,
//           horizontal: 8,
//         ),
//         decoration: BoxDecoration(
//           color: AppTextStyles.primaryBlue,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Text(
//           AppTextStyles().formatIndianNumber(
//             totalStepCountAPR.toInt(),
//           ),
//           style: AppTextStyles.headline.copyWith(
//             fontWeight: FontWeight.bold,
//             color: AppTextStyles.white,
//             fontSize: 20,
//           ),
//         ),
//       ),
//       SizedBox(width: 5),
//       Text(
//         'Steps',
//         style: AppTextStyles.headline.copyWith(
//           fontWeight: FontWeight.normal,
//           color: AppTextStyles.primaryBlue,
//           fontSize: 15,
//         ),
//       ),
//     ],
//   ),
// ),
// SizedBox(height: 10),
// Row(
//   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   crossAxisAlignment: CrossAxisAlignment.center,
//   children: [
//     Expanded(
//       flex: 1,
//       child: Container(
//         width: MediaQuery.of(context).size.width * 0.45,
//         padding: const EdgeInsets.all(8.0),
//         decoration: BoxDecoration(
//           color: Colors.green.shade100,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(height: 5),
//             Container(
//               padding: const EdgeInsets.all(4.0),
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: AppTextStyles.white,
//               ),
//               child: Image.asset(
//                 'assets/images/hyd.png', // Path to your image
//                 width: 30, // Adjust width as per your logo size
//                 height: 30, // Adjust height if needed
//               ),
//             ),
//             Obx(
//               () => Text(
//                 AppTextStyles().formatIndianNumber(
//                   totalStepCountHYDApr.value,
//                 ),
//                 style: AppTextStyles.subtitle.copyWith(
//                   color: AppTextStyles.primaryBlue,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 22,
//                 ),
//               ),
//             ),
//             SizedBox(height: 5),
//             Text(
//               'HYDERABAD',
//               style: AppTextStyles.subtitle.copyWith(
//                 color: AppTextStyles.black,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 13,
//               ),
//             ),
//             SizedBox(height: 5),
//             getMonthDifferenceValue(
//               totalStepCountHYDApr.value,
//               totalStepCountHYDMar.value,
//             ),
//           ],
//         ),
//       ),
//     ),
//     SizedBox(width: 10),
//     Expanded(
//       flex: 1,
//       child: Container(
//         width: MediaQuery.of(context).size.width * 0.45,
//         padding: const EdgeInsets.all(8.0),
//         decoration: BoxDecoration(
//           color: Colors.green.shade100,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(height: 5),
//             Container(
//               padding: const EdgeInsets.all(7.0),
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: AppTextStyles.white,
//               ),
//               child: Image.asset(
//                 'assets/images/blr.png', // Path to your image
//                 width: 25, // Adjust width as per your logo size
//                 height: 25, // Adjust height if needed
//               ),
//             ),
//             Obx(
//               () => Text(
//                 AppTextStyles().formatIndianNumber(
//                   totalStepCountBLRApr.value,
//                 ),
//                 style: AppTextStyles.subtitle.copyWith(
//                   color: AppTextStyles.primaryBlue,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 22,
//                 ),
//               ),
//             ),
//             SizedBox(height: 5),
//             Text(
//               'BANGALORE',
//               style: AppTextStyles.subtitle.copyWith(
//                 color: AppTextStyles.black,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 13,
//               ),
//             ),
//             SizedBox(height: 5),
//             getMonthDifferenceValue(
//               totalStepCountBLRApr.value,
//               totalStepCountBLRMar.value,
//             ),
//           ],
//         ),
//       ),
//     ),
//   ],
// ),
