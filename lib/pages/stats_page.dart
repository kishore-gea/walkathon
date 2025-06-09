import 'package:flutter/material.dart';
import 'package:wellnesswalkathon/style/slow_text_loader.dart';
import 'package:wellnesswalkathon/style/text_style.dart';

class StatsPage extends StatefulWidget {
  final int totalSteps;
  final int hyderabadSteps;
  final int bangaloreSteps;
  const StatsPage({
    super.key,
    required this.totalSteps,
    required this.hyderabadSteps,
    required this.bangaloreSteps,
  });

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: AppTextStyles.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Stats',
            style: AppTextStyles.headline.copyWith(color: AppTextStyles.white),
          ),
          backgroundColor: AppTextStyles.primaryBlue,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Card(
                    elevation: 15,
                    color: AppTextStyles.primaryBlue,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade400,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.orange.shade400),
                      ),
                      child: Text(
                        'Total Step Count',
                        style: AppTextStyles.subtitle.copyWith(
                          color: AppTextStyles.primaryBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'INDIA',
                  style: AppTextStyles.headline.copyWith(
                    color: AppTextStyles.primaryBlue,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Card(
                    elevation: 30,
                    color: AppTextStyles.primaryBlue,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppTextStyles.primaryBlue,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppTextStyles.primaryBlue,
                          width: 5,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SlowTextLoader(
                          fullText: AppTextStyles().formatIndianNumber(
                            widget.totalSteps,
                          ),
                          style: AppTextStyles.subtitle.copyWith(
                            color: AppTextStyles.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 50,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  'HYDERABAD',
                  style: AppTextStyles.headline.copyWith(
                    color: AppTextStyles.primaryBlue,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTextStyles.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: AppTextStyles.secondaryBlue,
                        width: 2,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SlowTextLoader(
                        fullText: AppTextStyles().formatIndianNumber(
                          widget.hyderabadSteps,
                        ),
                        style: AppTextStyles.subtitle.copyWith(
                          color: AppTextStyles.primaryBlue,
                          fontWeight: FontWeight.w500,
                          fontSize: 50,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  'BANGALORE',
                  style: AppTextStyles.headline.copyWith(
                    color: AppTextStyles.primaryBlue,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTextStyles.white,
                      borderRadius: BorderRadius.circular(25),

                      border: Border.all(
                        color: AppTextStyles.secondaryBlue,
                        width: 2,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SlowTextLoader(
                        fullText: AppTextStyles().formatIndianNumber(
                          widget.bangaloreSteps,
                        ),
                        style: AppTextStyles.subtitle.copyWith(
                          color: AppTextStyles.primaryBlue,
                          fontWeight: FontWeight.w500,
                          fontSize: 50,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
