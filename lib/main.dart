import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wellnesswalkathon/pages/splash_screen.dart';
import 'package:wellnesswalkathon/pages/wellness_dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => WellnessDashboard(),
      },
    );
  }
}
