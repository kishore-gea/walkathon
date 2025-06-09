import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wellnesswalkathon/pages/walkthon_stats/walkathon_stats_display.dart';

import '../../style/text_style.dart';

class WalkathonStats extends StatefulWidget {
  const WalkathonStats({super.key});

  @override
  State<WalkathonStats> createState() => _WalkathonStatsState();
}

class _WalkathonStatsState extends State<WalkathonStats> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTextStyles.white,
      appBar: AppBar(
        title: Text(
          'Walkathon Stats',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Get.to(
                    () => const StatsDisplay(
                      title: '10K',
                      code1: '1A',
                      code2: '1B',
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
                          Icons.ten_k_rounded,
                          size: 25,
                          color: AppTextStyles.primaryBlue,
                        ),
                      ),
                      SizedBox(width: 10),

                      Text(
                        'Consistent 10k Leader [Average] ',
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
                  Get.to(
                    () => const StatsDisplay(
                      title: '7K',
                      code1: '2A',
                      code2: '2B',
                    ),
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
                          Icons.seven_k,
                          size: 25,
                          color: AppTextStyles.primaryBlue,
                        ),
                      ),
                      SizedBox(width: 10),

                      Text(
                        'Consistent 7K Leader [Average] ',
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
                  Get.to(
                    () => const StatsDisplay(
                      title: '5K',
                      code1: '3A',
                      code2: '3B',
                    ),
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
                          Icons.ten_k_rounded,
                          size: 25,
                          color: AppTextStyles.primaryBlue,
                        ),
                      ),
                      SizedBox(width: 10),

                      Text(
                        'Consistent 5K Leader [Average] ',
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
                onTap: () {},
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
                          Icons.download,
                          size: 25,
                          color: AppTextStyles.primaryBlue,
                        ),
                      ),
                      SizedBox(width: 10),

                      Text(
                        'Consistent Submission ',
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
                  Get.to(
                    () => const StatsDisplay(
                      title: 'Uptrend',
                      code1: '5A',
                      code2: '5B',
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
                          Icons.trending_up_outlined,
                          size: 25,
                          color: AppTextStyles.primaryBlue,
                        ),
                      ),
                      SizedBox(width: 10),

                      Text(
                        'Consistent Uptrend ',
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
              // Add your stats widgets here
              // For example, you can use ListTile or Card widgets to display stats
            ],
          ),
        ),
      ),
    );
  }
}
