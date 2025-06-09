import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:wellnesswalkathon/data_constants/stepcount_data.dart';
import 'package:wellnesswalkathon/pages/rolling_leader.dart';
import 'package:wellnesswalkathon/pages/walkathon_contact_us.dart';
import 'package:wellnesswalkathon/pages/walkathon_facts.dart';
import 'package:wellnesswalkathon/pages/walkathon_monthly_stats.dart';
import 'package:wellnesswalkathon/pages/walkthon_stats/walkathon_stats.dart';
import 'package:wellnesswalkathon/pages/walkthon_stats/walkathon_stats_display.dart';

import '../model/participent_data.dart';
import '../style/text_style.dart';
import 'dashboard_data.dart';

class WellnessDashboard extends StatefulWidget {
  const WellnessDashboard({super.key});

  @override
  State<WellnessDashboard> createState() => _WellnessDashboardState();
}

class _WellnessDashboardState extends State<WellnessDashboard> {
  var totalStepCount = 0.obs;
  var totalStepCountHYD = 0.obs;
  var totalStepCountBLR = 0.obs;
  bool _initialized = false;

  final List<bool> monthSelected = [
    true,
    true,
    true,
    false,
    false,
    false,
    false,
  ];
  final List<String> months = ['MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP'];
  String selectedMonth = 'MAR';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_initialized) {
      _initialized = true;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        AppTextStyles().showLoadingDialog(
          context,
        ); // or use your progress phrase logic here

        fetchDataFromSheets().then((_) {
          Navigator.of(context).pop(); // Dismiss the dialog
        });
      });
    }
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   // Wait until the first frame is rendered
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     AppTextStyles().showLoadingDialog(
  //       context,
  //     ); // or use your progress phrase logic here
  //     fetchDataFromSheets();
  //     AppTextStyles().hideLoadingDialog(context);
  //   });
  //   fetchDataFromSheets();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTextStyles.white,
      appBar: AppBar(
        backgroundColor: AppTextStyles.white,
        title: Text(
          'Wellness Walkathon 2025',
          style: AppTextStyles.headline.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppTextStyles.primaryBlue,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    'assets/images/ge.png', // Path to your image
                    width: 120, // Adjust width as per your logo size
                    height: 150, // Adjust height if needed
                  ),
                  kIsWeb
                      ? Image.asset(
                        'assets/images/wwlogo.png', // Path to your image
                        width: 150, // Adjust width as per your logo size
                        height: 175, // Adjust height if needed
                      )
                      : const SizedBox(),
                  Image.asset(
                    'assets/images/wellwithin.png', // Path to your image
                    width: 120, // Adjust width as per your logo size
                    height: 150, // Adjust height if needed
                  ),
                ],
              ),

              GestureDetector(
                onTap: () {
                  // Handle tap event
                  // Refresh data from Google Sheets
                  Get.to(
                    () => MonthlyStats(),
                    transition: Transition.rightToLeft,
                    duration: const Duration(milliseconds: 500),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Handle tap event
                          // Refresh data from Google Sheets
                          fetchDataFromSheets();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 8.0,
                          ),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              padding: const EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                shape: BoxShape.rectangle,
                                color: AppTextStyles.white,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Sync Data',
                                    style: AppTextStyles.subtitle.copyWith(
                                      color: AppTextStyles.primaryBlue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(width: 2),
                                  Icon(
                                    Icons.refresh,
                                    size: 20,
                                    color: AppTextStyles.primaryBlue,
                                    semanticLabel: 'Refresh',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTextStyles.white,
                        ),
                        child: Image.asset(
                          'assets/images/ind.png', // Path to your image
                          width: 60, // Adjust width as per your logo size
                          height: 60, // Adjust height if needed
                        ),
                      ),
                      SizedBox(width: 10),
                      Obx(
                        () => Text(
                          AppTextStyles().formatIndianNumber(
                            totalStepCount.value,
                          ),
                          style: AppTextStyles.headline.copyWith(
                            color: AppTextStyles.primaryBlue,
                            fontSize: 44,
                          ),
                        ),
                      ),
                      Text(
                        'Walkathon Total Step Count',
                        style: AppTextStyles.subtitle.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 65,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: months.length,
                    separatorBuilder: (context, index) => SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final month = months[index];
                      final isSelected = monthSelected[index];

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedMonth = month;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 40,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    isSelected
                                        ? Colors.blue.shade200
                                        : Colors.transparent,
                                border: Border.all(
                                  color:
                                      isSelected
                                          ? Colors.blue.shade200
                                          : Colors.grey,
                                  width: 2,
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              month,
                              style: AppTextStyles.subtitle.copyWith(
                                color:
                                    isSelected
                                        ? AppTextStyles.primaryBlue
                                        : AppTextStyles.metallicGrey,
                                fontWeight:
                                    isSelected
                                        ? FontWeight.bold
                                        : FontWeight.w300,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        // Handle tap event
                        // Navigate to Dashboard Data page
                        Get.to(
                          () => DashboardData(
                            selectedCode: 'HYD',
                            headerName: 'Hyderabad',
                            totalWalkathonSteps: totalStepCount.value,
                            hydTotalSteps: totalStepCountHYD.value,
                            blrTotalSteps: totalStepCountBLR.value,
                          ),
                          transition: Transition.rightToLeft,
                          duration: const Duration(milliseconds: 500),
                        ); // 1- IND 2- HYD 3- BLR
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.pink.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 2),
                            Container(
                              padding: const EdgeInsets.all(7.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppTextStyles.white,
                              ),
                              child: Image.asset(
                                'assets/images/hyd.png', // Path to your image
                                width: 40, // Adjust width as per your logo size
                                height: 40, // Adjust height if needed
                              ),
                            ),
                            SizedBox(height: 5),
                            Obx(
                              () => Text(
                                AppTextStyles().formatIndianNumber(
                                  totalStepCountHYD.value,
                                ),
                                style: AppTextStyles.subtitle.copyWith(
                                  color: AppTextStyles.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                            Text(
                              'Overall Hyderabad Step Count',
                              style: AppTextStyles.subtitle.copyWith(
                                color: AppTextStyles.black,
                                fontWeight: FontWeight.w300,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        // Handle tap event
                        // Navigate to Dashboard Data page
                        Get.to(
                          () => DashboardData(
                            selectedCode: 'BLR',
                            headerName: 'Bangalore',
                            totalWalkathonSteps: totalStepCount.value,
                            hydTotalSteps: totalStepCountHYD.value,
                            blrTotalSteps: totalStepCountBLR.value,
                          ),
                          transition: Transition.rightToLeft,
                          duration: const Duration(milliseconds: 500),
                        ); // 1- IND 2- HYD 3- BLR
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 2),
                            Container(
                              padding: const EdgeInsets.all(9.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppTextStyles.white,
                              ),
                              child: Image.asset(
                                'assets/images/blr.png', // Path to your image
                                width: 35, // Adjust width as per your logo size
                                height: 35, // Adjust height if needed
                              ),
                            ),
                            SizedBox(height: 5),
                            Obx(
                              () => Text(
                                AppTextStyles().formatIndianNumber(
                                  totalStepCountBLR.value,
                                ),
                                style: AppTextStyles.subtitle.copyWith(
                                  color: AppTextStyles.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                            Text(
                              'Overall Bangalore Step Count',
                              style: AppTextStyles.subtitle.copyWith(
                                color: AppTextStyles.black,
                                fontWeight: FontWeight.w300,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  // Handle tap event
                  // Navigate to Dashboard Data page
                  Get.to(
                    () => DashboardData(
                      selectedCode: 'ALL',
                      headerName: 'India',
                      totalWalkathonSteps: totalStepCount.value,
                      hydTotalSteps: totalStepCountHYD.value,
                      blrTotalSteps: totalStepCountBLR.value,
                    ),
                    transition: Transition.rightToLeft,
                    duration: const Duration(milliseconds: 500),
                  ); // 1- IND 2- HYD 3- BLR
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTextStyles.white,
                        ),
                        child: Icon(
                          Icons.leaderboard,
                          size: 20,
                          color: AppTextStyles.primaryBlue,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        ' India Leaderboard [March - April]',
                        style: AppTextStyles.subtitle.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),

              GestureDetector(
                onTap: () {
                  // Handle tap event
                  // Navigate to Rolling Leader page
                  Get.to(
                    () => const StatsDisplay(
                      title: 'MAY 2025 - Leaderboard',
                      code1: '6A',
                      code2: '6B',
                    ),
                    transition: Transition.rightToLeft,
                    duration: const Duration(milliseconds: 500),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTextStyles.white,
                        ),
                        child: Icon(
                          Icons.groups_rounded,
                          size: 20,
                          color: AppTextStyles.primaryBlue,
                        ),
                      ),
                      SizedBox(width: 10),

                      Text(
                        'MAY 2025 - Leaderboard',
                        style: AppTextStyles.subtitle.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  // Handle tap event
                  // Navigate to Rolling Leader page
                  Get.to(
                    () => const RollingLeader(),
                    transition: Transition.rightToLeft,
                    duration: const Duration(milliseconds: 500),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTextStyles.white,
                        ),
                        child: Icon(
                          Icons.confirmation_number,
                          size: 20,
                          color: AppTextStyles.primaryBlue,
                        ),
                      ),
                      SizedBox(width: 10),

                      Text(
                        'Rolling Leaders',
                        style: AppTextStyles.subtitle.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  // Handle tap event
                  // Navigate to Walkathon Facts page
                  Get.to(
                    () => const WalkathonStats(),
                    transition: Transition.rightToLeft,
                    duration: const Duration(milliseconds: 500),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTextStyles.white,
                        ),
                        child: Icon(
                          Icons.auto_graph_outlined,
                          size: 20,
                          color: AppTextStyles.primaryBlue,
                        ),
                      ),
                      SizedBox(width: 10),

                      Text(
                        'Walkathon Stats ',
                        style: AppTextStyles.subtitle.copyWith(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  // Handle tap event
                  // Navigate to Walkathon Facts page
                  Get.to(
                    () => const WalkathonFacts(),
                    transition: Transition.rightToLeft,
                    duration: const Duration(milliseconds: 500),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.pink.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTextStyles.white,
                        ),
                        child: Icon(
                          Icons.fact_check_outlined,
                          size: 20,
                          color: AppTextStyles.primaryBlue,
                        ),
                      ),
                      SizedBox(width: 10),

                      Text(
                        'Walkathon Facts ',
                        style: AppTextStyles.subtitle.copyWith(
                          color: AppTextStyles.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  // Handle tap event
                  // Navigate to Walkathon Facts page
                  Get.to(
                    () => const WalkathonContactUs(),
                    transition: Transition.rightToLeft,
                    duration: const Duration(milliseconds: 500),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTextStyles.white,
                        ),
                        child: Icon(
                          Icons.contact_mail,
                          size: 20,
                          color: AppTextStyles.primaryBlue,
                        ),
                      ),
                      SizedBox(width: 10),

                      Text(
                        'Contact WellWithin Team ',
                        style: AppTextStyles.subtitle.copyWith(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  textAlign: TextAlign.end,
                  '@ Team WellWithin 2025',
                  style: AppTextStyles.subtitle.copyWith(
                    color: AppTextStyles.black,
                    fontSize: 12,
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Add more widgets here as needed
            ],
          ),
        ),
      ),
    );
  }

  Future<void> fetchDataFromSheets() async {
    AppTextStyles().showLoadingDialog(context);
    List<String> headersList = [];
    final url =
        'https://opensheet.vercel.app/14nQs7JlgHbFqzGlwpHi2egdIAsdpOSlyXUvfpGj6TNk/Sheet1';
    final response = await http.get(Uri.parse(url));
    final jsonData = jsonDecode(response.body);
    print('Data from Sheets: $jsonData');

    // Extracting headers from the first row of the JSON data
    var headers;
    if (jsonData.isNotEmpty && jsonData.first is Map<String, dynamic>) {
      headers = (jsonData.first as Map<String, dynamic>).keys.toList();
    }

    // Filtering Data according to MAR- descending order of step count
    jsonData.sort((a, b) {
      final aValue = int.tryParse(a['Mar'] ?? '0') ?? 0;
      final bValue = int.tryParse(b['Mar'] ?? '0') ?? 0;
      return bValue.compareTo(aValue); // descending
    });

    jsonData.sort((a, b) {
      final aValue = int.tryParse(a['Total'] ?? '0') ?? 0;
      final bValue = int.tryParse(b['Total'] ?? '0') ?? 0;
      return bValue.compareTo(aValue); // descending
    });
    for (int i = 0; i < jsonData.length; i++) {
      jsonData[i]['Rank'] = '${i + 1}';
    }

    final count = jsonData
        .map((item) => int.tryParse(item['Total'] ?? '0') ?? 0)
        .reduce((a, b) => a + b);
    totalStepCount.value = count;

    StepCountData.originalData.clear();
    StepCountData.originalData =
        jsonData
            .map<ParticipentData>((item) => ParticipentData.fromJson(item))
            .toList();

    print('Original Data Dashboard: ${StepCountData.originalData.length}');
    totalStepCountHYD.value = await StepCountData().getLocationWiseDataCount(
      'HYD',
    );

    totalStepCountBLR.value = await StepCountData().getLocationWiseDataCount(
      'BLR',
    );

    headersList.clear();
    for (int i = 0; i < headers.length; i++) {
      if (StepCountData().monthsForWalk.any(
        (month) => headers[i].toString().contains(month),
      )) {
        headersList.add(headers[i]);
      }
    }
    print('Headers FROM Excel: $headersList');
    AppTextStyles().hideLoadingDialog(context);
  }
}
