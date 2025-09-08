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
                                                fontSize: 22,
                                              ),
                                        ),
                                        Text(
                                          'Hyderabad : ${StepCountData().monthlySubmissionsLocationWise(index + 3, "HYD")}'
                                              .toUpperCase(),
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
                                                  style: AppTextStyles.headline
                                                      .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            AppTextStyles.white,
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
                                        Container(
                                          margin: EdgeInsets.only(top: 10),
                                          padding: EdgeInsets.symmetric(
                                            vertical: 2,
                                            horizontal: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppTextStyles.orange,
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            border: Border.all(
                                              color: Colors.orange.shade200,
                                              width: 2,
                                            ),
                                          ),
                                          child: Text(
                                            '${StepCountData().monthlySubmissions(index + 3)}',
                                            style: AppTextStyles.subtitle
                                                .copyWith(
                                                  fontSize: 16,
                                                  color:
                                                      AppTextStyles.primaryBlue,
                                                  fontWeight: FontWeight.bold,
                                                ),
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
                                                fontSize: 22,
                                              ),
                                        ),
                                        Text(
                                          'Bangalore : ${StepCountData().monthlySubmissionsLocationWise(index + 3, "BLR")}'
                                              .toUpperCase(),
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
    // Your existing fetchStepCountData implementation
    return [];
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
