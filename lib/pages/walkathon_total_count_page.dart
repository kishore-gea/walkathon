import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wellnesswalkathon/pages/walkthon_stats/animater_text.dart';

import '../style/text_style.dart';


class WalkathonTotalStepCountPage extends StatelessWidget {
  const WalkathonTotalStepCountPage({super.key, required this.targetValue});

  final int targetValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('OVERALL STATUS',style: AppTextStyles.headline.copyWith(color: AppTextStyles.primaryBlue),),),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
              Text(
                'WELLNESS WALKATHON 2025 ',
                textAlign: TextAlign.center,
                style: AppTextStyles.headline.copyWith(
                  color: AppTextStyles.primaryBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 60,
                ),
              ),
              Text(
                'TOTAL STEP COUNT ( MARCH - SEPTEMBER )',
                textAlign: TextAlign.center,
                style: AppTextStyles.headline.copyWith(
                  color: AppTextStyles.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 50),
              AnimatedCounter(
                targetValue: targetValue.toDouble(),
                duration: const Duration(seconds: 30),
                style: TextStyle(
                  color: AppTextStyles.primaryBlue,
                  fontSize: 150,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],

          ),
        ),
      ),
    );
  }
}

