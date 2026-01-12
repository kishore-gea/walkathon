import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wellnesswalkathon/pages/walkthon_stats/animater_text.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    try {
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                FutureBuilder(
                  future: fetchStepCountData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No data available'));
                    }

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
                                          SizedBox(height: 10),
                                          Text(
                                            AppTextStyles().formatIndianNumber(
                                              data.totalStepsHYD!,
                                            ),
                                            style: AppTextStyles.subtitle
                                                .copyWith(
                                              color: AppTextStyles.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30,
                                            ),
                                          ),
                                          Text(
                                            'Hyderabad : ${StepCountData()
                                                .monthlySubmissionsLocationWise(
                                                index + 3, "HYD")}'
                                                .toUpperCase(),
                                            style: AppTextStyles.subtitle
                                                .copyWith(
                                              color: AppTextStyles.primaryBlue,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
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
                                            data.month.toString().toUpperCase(),
                                            style: AppTextStyles.headline
                                                .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color:
                                              AppTextStyles.primaryBlue,
                                              fontSize: 24,
                                            ),
                                          ),
                                          SizedBox(height: 10),
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
                                              child:
                                              data.month.toString() ==
                                                  'September' ?
                                              AnimatedCounter(
                                                targetValue: data
                                                    .currentMonthTotalSteps!
                                                    .toDouble(),
                                                duration: const Duration(
                                                    seconds: 15),
                                                style: AppTextStyles.headline
                                                    .copyWith(
                                                  color: AppTextStyles.white,
                                                  fontSize: 35,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ) :
                                              Text(
                                                ' ${AppTextStyles()
                                                    .formatIndianNumber(data
                                                    .currentMonthTotalSteps!)}',
                                                style: AppTextStyles.headline
                                                    .copyWith(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  color:
                                                  AppTextStyles.white,
                                                  fontSize: 35,
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
                                          Container(
                                            margin: EdgeInsets.only(top: 10),
                                            padding: EdgeInsets.symmetric(
                                              vertical: 2,
                                              horizontal: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              color: AppTextStyles.orange,
                                              borderRadius: BorderRadius
                                                  .circular(
                                                16,
                                              ),
                                              border: Border.all(
                                                color: Colors.orange.shade200,
                                                width: 2,
                                              ),
                                            ),
                                            child: Text(
                                              '${StepCountData()
                                                  .monthlySubmissions(
                                                  index + 3)}',
                                              style: AppTextStyles.subtitle
                                                  .copyWith(
                                                fontSize: 40,
                                                color:
                                                AppTextStyles.primaryBlue,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Total Submissions',
                                            style: AppTextStyles.subtitle
                                                .copyWith(
                                              fontSize: 16,
                                              color:
                                              AppTextStyles.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        children: [
                                          SizedBox(height: 10),
                                          Text(
                                            AppTextStyles().formatIndianNumber(
                                              data.totalStepsBLR!,
                                            ),
                                            style: AppTextStyles.subtitle
                                                .copyWith(
                                              color: AppTextStyles.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30,
                                            ),
                                          ),
                                          Text(
                                            'Bangalore : ${StepCountData()
                                                .monthlySubmissionsLocationWise(
                                                index + 3, "BLR")}'
                                                .toUpperCase(),
                                            style: AppTextStyles.subtitle
                                                .copyWith(
                                              color: AppTextStyles.primaryBlue,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
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
      );
    }catch (e) {
      print('Exception caught in MonthlyStats build: $e');
      return Scaffold(
        body: Center(
          child: Text('An error occurred: $e'),
        ),
      );
    }
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
    // Your existing fetchStepCountData implementation
    try {
      int totalMonthStepsHYD = 0;
      int totalMonthStepsBLR = 0;
      List<MonthlyData> monthlyStatsList = [];
      final data = StepCountData.originalData;
      var monthValue = DateTime.now().month;
      if(monthValue <= 2){
        monthValue = 12;
      }
      for (int i = 4; i <= monthValue+1; i++) {
        int dateMonth = i;
        String monthName = '';
        for (int i = 0; i < data.length; i++) {
          if (data[i].location == "HYD") {
            if (dateMonth == 4) {
              monthName = 'March';
              totalMonthStepsHYD += safeParse(data[i].steps.toString());
            } else if (dateMonth == 5) {
              monthName = 'April';
              totalMonthStepsHYD += safeParse(data[i].apr.toString());
            } else if (dateMonth == 6) {
              monthName = 'May';
              totalMonthStepsHYD += safeParse(data[i].may.toString());
            } else if (dateMonth == 7) {
              monthName = 'June';
              totalMonthStepsHYD += safeParse(data[i].jun.toString());
            } else if (dateMonth == 8) {
              monthName = 'July';
              totalMonthStepsHYD += safeParse(data[i].jul.toString());
            } else if (dateMonth == 9) {
              monthName = 'August';
              totalMonthStepsHYD += safeParse(data[i].aug.toString());
            } else if (dateMonth == 10) {
              monthName = 'September';
              totalMonthStepsHYD += safeParse(data[i].sep.toString());
              print('Inside Sept $totalMonthStepsHYD');
            } else if (dateMonth == 11) {
              monthName = 'October';
              totalMonthStepsHYD += safeParse(data[i].oct.toString());
              print('Inside October $totalMonthStepsHYD');
            }else if (dateMonth == 12) {
              monthName = 'November';
              totalMonthStepsHYD += safeParse(data[i].nov.toString());
              print('Inside November $totalMonthStepsHYD');
            }else if (dateMonth == 13) {
              monthName = 'December';
              totalMonthStepsHYD += safeParse(data[i].dec.toString());
              print('Inside December $totalMonthStepsHYD');
            }
            totalStepCountHYDCurrentMonth.value = totalMonthStepsHYD;
            totalStepCountHYD.value += safeParse(data[i].total.toString());
          } else if (data[i].location == "BLR") {
            if (dateMonth == 4) {
              monthName = 'March';
              totalMonthStepsBLR += safeParse(data[i].steps.toString());
            } else if (dateMonth == 5) {
              monthName = 'April';
              totalMonthStepsBLR += safeParse(data[i].apr.toString());
            } else if (dateMonth == 6) {
              monthName = 'May';
              totalMonthStepsBLR += safeParse(data[i].may.toString());
            } else if (dateMonth == 7) {
              monthName = 'June';
              totalMonthStepsBLR += safeParse(data[i].jun.toString());
            } else if (dateMonth == 8) {
              monthName = 'July';
              totalMonthStepsBLR += safeParse(data[i].jul.toString());
            } else if (dateMonth == 9) {
              monthName = 'August';
              totalMonthStepsBLR += safeParse(data[i].aug.toString());
            } else if (dateMonth == 10) {
              monthName = 'September';
              totalMonthStepsBLR += safeParse(data[i].sep.toString());
            } else if (dateMonth == 11) {
              monthName = 'October';
              totalMonthStepsBLR += safeParse(data[i].oct.toString());
              print('Inside October $totalMonthStepsBLR');
            }
            else if (dateMonth == 12) {
              monthName = 'November';
              totalMonthStepsBLR += safeParse(data[i].nov.toString());
              print('Inside October $totalMonthStepsBLR');
            }else if (dateMonth == 13) {
              monthName = 'December';
              totalMonthStepsBLR += safeParse(data[i].dec.toString());
              print('Inside December $totalMonthStepsBLR');
            }

            totalStepCountBLRCurrentMonth.value = totalMonthStepsBLR;
            totalStepCountBLR.value += safeParse(data[i].total.toString());
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

        print('Monthly Data for Month $i: $monthlyData');
        print('Total Steps HYD: $i --> ${totalStepCountHYDCurrentMonth.value}');
        print('Total Steps BLR: $i --> ${totalStepCountBLRCurrentMonth.value}');

        monthlyStatsList.add(monthlyData);
        totalMonthStepsHYD = 0; // Reset for next month
        totalMonthStepsBLR = 0; // Reset for next month
        totalStepCountHYDCurrentMonth.value = 0; // Reset for next month
        totalStepCountBLRCurrentMonth.value = 0; // Reset for next month
        totalStepCountHYD.value = 0; // Reset for next month
        totalStepCountBLR.value = 0; // Reset for next month
      }

      // Update the observable variables with the calculated values

      print('Monthly Stats: $monthlyStatsList');

      return monthlyStatsList;
    }
    catch(e) {
      print('Exception caught in fetchStepCountData: $e');
      return [];
    }
  }

  int safeParse(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is String && value.trim().isNotEmpty) {
      return int.tryParse(value) ?? 0;
    }
    return 0;
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
