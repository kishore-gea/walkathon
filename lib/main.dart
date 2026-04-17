import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wellnesswalkathon/pages/get_app_data.dart';
import 'package:wellnesswalkathon/pages/splash_screen.dart';
import 'package:wellnesswalkathon/pages/walkathon_login.dart';
import 'package:wellnesswalkathon/pages/walkathon_options_select_screen.dart';
import 'package:wellnesswalkathon/pages/wellness_dashboard.dart';
import 'package:wellnesswalkathon/provider/auth_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => AuthProvider(),
    child: MyApp(),
  ),);
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
        '/options': (context) => const WalkathonOptionsSelectScreen(),
        '/get-health-data': (context) => const GetHealthDataFromApp(),
        '/home': (context) => WellnessDashboard(),
        '/login': (context) => const LoginPage(),
      },
    );
  }
}
