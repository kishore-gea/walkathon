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

  int _selectedYear = 2026;

  /// Month config: {name, fieldGetter, submissionCode}
  /// submissionCode is used for StepCountData.monthlySubmissions (month index offset)
  /// Season 1 (2025): Mar 2025 → Feb 2026
  static const _months2025 = [
    {'name': 'March',      'field': 'steps',  'code': 3},
    {'name': 'April',      'field': 'apr',    'code': 4},
    {'name': 'May',        'field': 'may',    'code': 5},
    {'name': 'June',       'field': 'jun',    'code': 6},
    {'name': 'July',       'field': 'jul',    'code': 7},
    {'name': 'August',     'field': 'aug',    'code': 8},
    {'name': 'September',  'field': 'sep',    'code': 9},
    {'name': 'October',    'field': 'oct',    'code': 10},
    {'name': 'November',   'field': 'nov',    'code': 11},
    {'name': 'December',   'field': 'dec',    'code': 12},
    {'name': 'January 26', 'field': 'jan26',  'code': 13},
    {'name': 'February 26','field': 'feb26',  'code': 14},
  ];

  /// Season 2 (2026): Mar 2026 onwards
  static const _months2026 = [
    {'name': 'March 26', 'field': 'mar26', 'code': 15},
    // {'name': 'April 26', 'field': 'apr26', 'code': 16},
    // {'name': 'May 26',   'field': 'may26', 'code': 17},
  ];

  @override
  void initState() {
    super.initState();
    // Default to current year
    _selectedYear = DateTime.now().year;
  }

  String _getFieldValue(dynamic participant, String field) {
    switch (field) {
      case 'steps':  return participant.steps?.toString()  ?? '0';
      case 'apr':    return participant.apr?.toString()    ?? '0';
      case 'may':    return participant.may?.toString()    ?? '0';
      case 'jun':    return participant.jun?.toString()    ?? '0';
      case 'jul':    return participant.jul?.toString()    ?? '0';
      case 'aug':    return participant.aug?.toString()    ?? '0';
      case 'sep':    return participant.sep?.toString()    ?? '0';
      case 'oct':    return participant.oct?.toString()    ?? '0';
      case 'nov':    return participant.nov?.toString()    ?? '0';
      case 'dec':    return participant.dec?.toString()    ?? '0';
      case 'jan26':  return participant.jan26?.toString()  ?? '0';
      case 'feb26':  return participant.feb26?.toString()  ?? '0';
      case 'mar26':  return participant.mar26?.toString()  ?? '0';
      case 'apr26':  return participant.apr26?.toString()  ?? '0';
      case 'may26':  return participant.may26?.toString()  ?? '0';
      default: return '0';
    }
  }

  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Walkathon Season ${_selectedYear == 2025 ? '1' : '2'} Stats',
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
                // ── Year Selector ──────────────────────────────────────
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTextStyles.primaryBlue, width: 1.5),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      {'year': 2025, 'label': 'Season 1\nMar\'25 – Feb\'26'},
                      {'year': 2026, 'label': 'Season 2\nMar\'26 onwards'},
                    ].map((item) {
                      final year = item['year'] as int;
                      final label = item['label'] as String;
                      final selected = _selectedYear == year;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedYear = year),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                          decoration: BoxDecoration(
                            color: selected ? AppTextStyles.primaryBlue : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            label,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.headline.copyWith(
                              fontWeight: FontWeight.bold,
                              color: selected ? Colors.white : AppTextStyles.primaryBlue,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                // ── Stats List ─────────────────────────────────────────
                FutureBuilder(
                  future: fetchStepCountData(_selectedYear),
                  key: ValueKey(_selectedYear),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No data available'));
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final data = snapshot.data![index];
                        return Card(
                          color: Colors.blue.shade200,
                          elevation: 8,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    // HYD column
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 10),
                                          Text(
                                            AppTextStyles().formatIndianNumber(data.totalStepsHYD!),
                                            style: AppTextStyles.subtitle.copyWith(
                                              color: AppTextStyles.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30,
                                            ),
                                          ),
                                          Text(
                                            'Hyderabad : ${data.hydSubmissions}'.toUpperCase(),
                                            style: AppTextStyles.subtitle.copyWith(
                                              color: AppTextStyles.primaryBlue,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Middle column
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        children: [
                                          Text(
                                            data.month.toString().toUpperCase(),
                                            style: AppTextStyles.headline.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: AppTextStyles.primaryBlue,
                                              fontSize: 24,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: AppTextStyles.primaryBlue,
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8),
                                              child: data.month.toString() == 'September'
                                                  ? AnimatedCounter(
                                                      targetValue: data.currentMonthTotalSteps!.toDouble(),
                                                      duration: const Duration(seconds: 15),
                                                      style: AppTextStyles.headline.copyWith(
                                                        color: AppTextStyles.white,
                                                        fontSize: 35,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    )
                                                  : Text(
                                                      ' ${AppTextStyles().formatIndianNumber(data.currentMonthTotalSteps!)}',
                                                      style: AppTextStyles.headline.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: AppTextStyles.white,
                                                        fontSize: 35,
                                                      ),
                                                    ),
                                            ),
                                          ),
                                          const SizedBox(height: 15),
                                          index > 0
                                              ? getMonthDifferenceValue(
                                                  snapshot.data![index].currentMonthTotalSteps!,
                                                  snapshot.data![index - 1].currentMonthTotalSteps!,
                                                )
                                              : const SizedBox(),
                                          Container(
                                            margin: const EdgeInsets.only(top: 10),
                                            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                                            decoration: BoxDecoration(
                                              color: AppTextStyles.orange,
                                              borderRadius: BorderRadius.circular(16),
                                              border: Border.all(color: Colors.orange.shade200, width: 2),
                                            ),
                                            child: Text(
                                              '${data.totalSubmissions}',
                                              style: AppTextStyles.subtitle.copyWith(
                                                fontSize: 40,
                                                color: AppTextStyles.primaryBlue,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Total Submissions',
                                            style: AppTextStyles.subtitle.copyWith(
                                              fontSize: 16,
                                              color: AppTextStyles.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // BLR column
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 10),
                                          Text(
                                            AppTextStyles().formatIndianNumber(data.totalStepsBLR!),
                                            style: AppTextStyles.subtitle.copyWith(
                                              color: AppTextStyles.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30,
                                            ),
                                          ),
                                          Text(
                                            'Bangalore : ${data.blrSubmissions}'.toUpperCase(),
                                            style: AppTextStyles.subtitle.copyWith(
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
    } catch (e) {
      print('Exception caught in MonthlyStats build: $e');
      return Scaffold(
        body: Center(child: Text('An error occurred: $e')),
      );
    }
  }

  Widget getMonthDifferenceValue(int val1, int val2) {
    final val = val1 - val2;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
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
          const SizedBox(width: 5),
          val > 0
              ? Icon(Icons.trending_up_outlined, color: Colors.green.shade700)
              : Icon(Icons.trending_down_outlined, color: Colors.redAccent),
        ],
      ),
    );
  }

  Future<List<MonthlyData>> fetchStepCountData(int year) async {
    try {
      final data = StepCountData.originalData;
      final months = year == 2025 ? _months2025 : _months2026;

      // For 2026 Season 2, only show months up to current (Apr 2026 = code 16)
      List<Map<String, Object>> visibleMonths;
      if (year == 2026) {
        final now = DateTime.now();
        // code 15=Mar26, 16=Apr26, 17=May26  →  currentCode = now.month + 12
        final currentCode = (now.year == 2026) ? now.month + 12 : 15;
        visibleMonths = (_months2026 as List<Map<String, Object>>)
            .where((m) => (m['code'] as int) <= currentCode)
            .toList();
      } else {
        visibleMonths = List<Map<String, Object>>.from(months);
      }

      List<MonthlyData> monthlyStatsList = [];

      for (final monthConfig in visibleMonths) {
        final field = monthConfig['field'] as String;
        final monthName = monthConfig['name'] as String;

        int totalHYD = 0;
        int totalBLR = 0;
        int hydSubmissions = 0;
        int blrSubmissions = 0;

        for (final participant in data) {
          final val = safeParse(_getFieldValue(participant, field));
          if (participant.location == 'HYD') {
            totalHYD += val;
            if (val > 0) hydSubmissions++;
          } else if (participant.location == 'BLR') {
            totalBLR += val;
            if (val > 0) blrSubmissions++;
          }
        }

        final monthlyData = MonthlyData(
          month: monthName,
          totalStepsHYD: totalHYD,
          totalStepsBLR: totalBLR,
          differenceSteps: totalHYD - totalBLR,
          currentMonthTotalSteps: totalHYD + totalBLR,
          hydSubmissions: hydSubmissions,
          blrSubmissions: blrSubmissions,
          totalSubmissions: hydSubmissions + blrSubmissions,
        );

        print('Monthly Data for $monthName: $monthlyData');
        monthlyStatsList.add(monthlyData);
      }

      return monthlyStatsList;
    } catch (e) {
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
  int? hydSubmissions;
  int? blrSubmissions;
  int? totalSubmissions;

  MonthlyData({
    required this.month,
    required this.totalStepsHYD,
    required this.totalStepsBLR,
    required this.differenceSteps,
    required this.currentMonthTotalSteps,
    this.hydSubmissions = 0,
    this.blrSubmissions = 0,
    this.totalSubmissions = 0,
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
