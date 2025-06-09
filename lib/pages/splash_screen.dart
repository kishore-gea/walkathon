import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wellnesswalkathon/style/text_style.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Controls the opacity for fade-in effect
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();

    // Start fade-in animation and navigate after 2 seconds
    _startAnimation();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(
        context,
        '/home',
      ); // Change '/home' to your next screen
    });
  }

  // Method to control fade-in effect
  void _startAnimation() {
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTextStyles.white, // Splash screen background color
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: Duration(seconds: 1),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/ge.png', // Path to your image
                    width: 150, // Adjust width as per your logo size
                    height: 150, // Adjust height if needed
                  ),
                  SizedBox(width: 20),
                  Text(
                    '|',
                    style: AppTextStyles.body.copyWith(
                      fontSize: 50,
                      fontWeight: FontWeight.normal,
                      color: AppTextStyles.primaryBlue,
                    ),
                  ),
                  Image.asset(
                    'assets/images/img.png', // Path to your image
                    width: 150, // Adjust width as per your logo size
                    height: 150, // Adjust height if needed
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        'Wellness',
                        style: AppTextStyles.headline.copyWith(
                          color: AppTextStyles.primaryBlue,
                          fontSize: 30,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        ' ',
                        style: AppTextStyles.subtitle.copyWith(
                          color: AppTextStyles.primaryBlue,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        ' Walkathon',
                        style: AppTextStyles.headline.copyWith(
                          color: AppTextStyles.primaryBlue,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Walk. Track. Achieve.',
                        style: AppTextStyles.subtitle.copyWith(
                          color: AppTextStyles.primaryBlue,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ), // Splash logo
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
