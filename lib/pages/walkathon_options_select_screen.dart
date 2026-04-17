import 'package:flutter/material.dart';
import 'package:wellnesswalkathon/style/text_style.dart';

class WalkathonOptionsSelectScreen extends StatelessWidget {
  const WalkathonOptionsSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTextStyles.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  'assets/images/ge.png', // Path to your image
                  width: 50, // Adjust width as per your logo size
                  height: 50, // Adjust height if needed
                ),
                SizedBox(height: 30,),
                Image.asset(
                  'assets/images/img.png', // Path to your image
                  width: 50, // Adjust width as per your logo size
                  height: 50, // Adjust height if needed
                ),
                SizedBox(height: 60,),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/get-health-data');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTextStyles.primaryBlue,
                    foregroundColor: AppTextStyles.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('GetHealth Data'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTextStyles.primaryBlue,
                    foregroundColor: AppTextStyles.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Dashboard'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTextStyles.primaryBlue,
                    foregroundColor: AppTextStyles.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
