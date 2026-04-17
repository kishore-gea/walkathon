import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:wellnesswalkathon/data_constants/stepcount_data.dart';
import 'package:wellnesswalkathon/pages/customteams.dart';
import 'package:wellnesswalkathon/pages/india_teams.dart';
import 'package:wellnesswalkathon/pages/rolling_leader.dart';
import 'package:wellnesswalkathon/pages/walkathon_monthly_stats.dart';
import 'package:wellnesswalkathon/pages/walkathon_total_count_page.dart';
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
  var totalStepCountHYDSeason1 = 0.obs;
  var totalStepCountHYDSeason2 = 0.obs;
  var totalStepCountBLRSeason1 = 0.obs;
  var totalStepCountBLRSeason2 = 0.obs;
  int _selectedHydSeason = StepCountData.currentSeason;
  int _selectedBlrSeason = StepCountData.currentSeason;
  bool _initialized = false;

  final List<bool> monthSelected = [
    true,
    true,
    true,
    true,
    true,
    true,
    true,
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
      body:
           Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
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
                            print('Sync Data tapped');
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
                        GestureDetector(
                          onTap: (){
                            Get.to(
                                  () => WalkathonTotalStepCountPage(
                                targetValue: totalStepCount.value,
                                  ),
                              transition: Transition.rightToLeft,
                              duration: const Duration(milliseconds: 500),
                            );
                          },
                          child: Container(
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
                        ),
                        SizedBox(width: 10),
                        // Obx(
                        //   () =>
                              Text(
                            // AppTextStyles().formatIndianNumber(
                            //   totalStepCount.value,
                            // ),
                            'Total Step Count'.toUpperCase(),
                            style: AppTextStyles.headline.copyWith(
                              color: AppTextStyles.primaryBlue,
                              fontSize: 44,
                            ),
                          ),
                        // ),
                        Text(
                          'MARCH 2025 - NOVEMBER 2025',
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
                Center(
                  child: Container(
                    alignment: Alignment.center,
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
                              if(selectedMonth == 'SEP'){
                                monthSelected[index] = false;
                              }
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
                              hydTotalSteps: _selectedHydSeasonTotal,
                              blrTotalSteps: _selectedBlrSeasonTotal,
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
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildHydSeasonOption(1, 'S1'),
                                  const SizedBox(width: 6),
                                  _buildHydSeasonOption(2, 'S2'),
                                ],
                              ),
                              SizedBox(height: 5),
                              Obx(
                                () => Text(
                                  AppTextStyles().formatIndianNumber(
                                    _selectedHydSeasonTotal,
                                  ),
                                  style: AppTextStyles.subtitle.copyWith(
                                    color: AppTextStyles.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                              Text(
                                _selectedHydSeasonLabel,
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
                              hydTotalSteps: _selectedHydSeasonTotal,
                              blrTotalSteps: _selectedBlrSeasonTotal,
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
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildBlrSeasonOption(1, 'S1'),
                                  const SizedBox(width: 6),
                                  _buildBlrSeasonOption(2, 'S2'),
                                ],
                              ),
                               SizedBox(height: 5),
                               Obx(
                                 () => Text(
                                   AppTextStyles().formatIndianNumber(
                                    _selectedBlrSeasonTotal,
                                   ),
                                   style: AppTextStyles.subtitle.copyWith(
                                     color: AppTextStyles.black,
                                     fontWeight: FontWeight.bold,
                                     fontSize: 22,
                                   ),
                                 ),
                               ),
                               Text(
                                _selectedBlrSeasonLabel,
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
                          ' India Leaderboard',
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
                          () => const StatsDisplay(
                        title: 'Monthly Leaderboard',
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
                          '${getMonthName()} - Leaderboard',
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
                      () =>  RollingLeader(
                        totalWalkathonSteps: totalStepCount.value,
                        hydTotalSteps: totalStepCountHYD.value,
                        blrTotalSteps: totalStepCountBLR.value,
                      ),
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
                          'Walkathon Step Spectrum ',
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
                    // Navigate to Dashboard Data page
                    Get.to(
                          () => IndiaTeamsDashboard(),
                      transition: Transition.rightToLeft,
                      duration: const Duration(milliseconds: 500),
                    ); // 1- IND 2- HYD 3- BLR
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
                            Icons.leaderboard,
                            size: 20,
                            color: AppTextStyles.primaryBlue,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          ' India Teams',
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
                    // Navigate to Dashboard Data page
                    Get.to(
                          () => Customteams(),
                      transition: Transition.rightToLeft,
                      duration: const Duration(milliseconds: 500),
                    ); // 1- IND 2- HYD 3- BLR
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
                            Icons.leaderboard,
                            size: 20,
                            color: AppTextStyles.primaryBlue,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          ' Custom Teams',
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
                // GestureDetector(
                //   onTap: () {
                //     // Handle tap event
                //     // Navigate to Walkathon Facts page
                //     Get.to(
                //       () => const WalkathonFacts(),
                //       transition: Transition.rightToLeft,
                //       duration: const Duration(milliseconds: 500),
                //     );
                //   },
                //   child: Container(
                //     padding: const EdgeInsets.all(8.0),
                //     decoration: BoxDecoration(
                //       color: Colors.pink.shade100,
                //       borderRadius: BorderRadius.circular(8),
                //     ),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.start,
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       children: [
                //         Container(
                //           padding: const EdgeInsets.all(8.0),
                //           decoration: BoxDecoration(
                //             shape: BoxShape.circle,
                //             color: AppTextStyles.white,
                //           ),
                //           child: Icon(
                //             Icons.fact_check_outlined,
                //             size: 20,
                //             color: AppTextStyles.primaryBlue,
                //           ),
                //         ),
                //         SizedBox(width: 10),
                //
                //         Text(
                //           'Walkathon Facts ',
                //           style: AppTextStyles.subtitle.copyWith(
                //             color: AppTextStyles.black,
                //             fontWeight: FontWeight.w500,
                //             fontSize: 16,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                //
                // SizedBox(height: 10),
                // GestureDetector(
                //   onTap: () {
                //     // Handle tap event
                //     // Navigate to Walkathon Facts page
                //     Get.to(
                //       () => const WalkathonContactUs(),
                //       transition: Transition.rightToLeft,
                //       duration: const Duration(milliseconds: 500),
                //     );
                //   },
                //   child: Container(
                //     padding: const EdgeInsets.all(8.0),
                //     decoration: BoxDecoration(
                //       color: Colors.blue.shade100,
                //       borderRadius: BorderRadius.circular(8),
                //     ),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.start,
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       children: [
                //         Container(
                //           padding: const EdgeInsets.all(8.0),
                //           decoration: BoxDecoration(
                //             shape: BoxShape.circle,
                //             color: AppTextStyles.white,
                //           ),
                //           child: Icon(
                //             Icons.contact_mail,
                //             size: 20,
                //             color: AppTextStyles.primaryBlue,
                //           ),
                //         ),
                //         SizedBox(width: 10),
                //
                //         Text(
                //           'Contact WellWithin Team ',
                //           style: AppTextStyles.subtitle.copyWith(
                //             color: Colors.black,
                //             fontSize: 16,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
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
        'https://opensheet.elk.sh/14nQs7JlgHbFqzGlwpHi2egdIAsdpOSlyXUvfpGj6TNk/Sheet1';
    final response = await http.get(Uri.parse(url));

    final jsonData = jsonDecode(response.body);

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

    // print('Original Data Dashboard: ${StepCountData.originalData.length}');
    totalStepCountHYD.value = await StepCountData().getLocationWiseDataCount(
      'HYD',
    );

    totalStepCountHYDSeason1.value = _getLocationSeasonTotal('HYD', 1);
    totalStepCountHYDSeason2.value = _getLocationSeasonTotal('HYD', 2);
    totalStepCountBLRSeason1.value = _getLocationSeasonTotal('BLR', 1);
    totalStepCountBLRSeason2.value = _getLocationSeasonTotal('BLR', 2);

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
    // print('Headers FROM Excel: $headersList');
    AppTextStyles().hideLoadingDialog(context);
  }

  int _getLocationSeasonTotal(String location, int season) {
    int total = 0;
    final months = StepCountData.getSeasonMonths(season);
    for (final participant in StepCountData.originalData) {
      if (participant.location != location) continue;
      for (final month in months) {
        final code = month['code'] as int;
        total += int.tryParse(StepCountData.getMonthValue(participant, code)) ?? 0;
      }
    }
    return total;
  }

  int get _selectedHydSeasonTotal =>
      _selectedHydSeason == 1
          ? totalStepCountHYDSeason1.value
          : totalStepCountHYDSeason2.value;

  int get _selectedBlrSeasonTotal =>
      _selectedBlrSeason == 1
          ? totalStepCountBLRSeason1.value
          : totalStepCountBLRSeason2.value;

  String get _selectedHydSeasonLabel =>
      _selectedHydSeason == 1 ? "Season 1 (Mar'25 - Feb'26)" : "Season 2 (Mar'26 onwards)";

  String get _selectedBlrSeasonLabel =>
      _selectedBlrSeason == 1 ? "Season 1 (Mar'25 - Feb'26)" : "Season 2 (Mar'26 onwards)";

  String getMonthName() {
    int monthIndex = DateTime.now().month;
    print('Current Month Index: $monthIndex');
    monthIndex = (monthIndex == 1) ? 12 : monthIndex - 1;
    switch(monthIndex){
      case 1:
        return 'JANUARY';
      case 2:
        return 'FEBRUARY';
      case 3:
        return 'MARCH';
      case 4:
        return 'APRIL';
      case 5:
        return 'MAY';
      case 6:
        return 'JUNE';
      case 7:
        return 'JULY';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
  }

  Widget _buildHydSeasonOption(int season, String label) {
    final isSelected = _selectedHydSeason == season;
    return GestureDetector(
      onTap: () => setState(() => _selectedHydSeason = season),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? AppTextStyles.primaryBlue : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTextStyles.primaryBlue, width: 1.5),
        ),
        child: Text(
          label,
          style: AppTextStyles.subtitle.copyWith(
            color: isSelected ? Colors.white : AppTextStyles.primaryBlue,
            fontWeight: FontWeight.bold,
            fontSize: 11,
          ),
        ),
      ),
    );
  }

  Widget _buildBlrSeasonOption(int season, String label) {
    final isSelected = _selectedBlrSeason == season;
    return GestureDetector(
      onTap: () => setState(() => _selectedBlrSeason = season),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? AppTextStyles.primaryBlue : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTextStyles.primaryBlue, width: 1.5),
        ),
        child: Text(
          label,
          style: AppTextStyles.subtitle.copyWith(
            color: isSelected ? Colors.white : AppTextStyles.primaryBlue,
            fontWeight: FontWeight.bold,
            fontSize: 11,
          ),
        ),
      ),
    );
  }
}
