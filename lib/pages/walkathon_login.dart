import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellnesswalkathon/pages/wellness_dashboard.dart';
import 'package:wellnesswalkathon/style/text_style.dart';

import '../provider/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: AppTextStyles.lightBiscuit,
      appBar: AppBar(
        backgroundColor: AppTextStyles.primaryBlue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/options');
          },
        ),
        title: Text("The Wellness Corner",style: AppTextStyles.subtitle.copyWith(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 24),),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome Back!",
                      style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: idController,
                      style: AppTextStyles.subtitle.copyWith(color: AppTextStyles.primaryBlue, fontWeight: FontWeight.w700,fontSize: 20),
                      decoration: InputDecoration(labelText: "User ID"),
                    ),
                    TextField(
                      style: AppTextStyles.subtitle.copyWith(color: AppTextStyles.primaryBlue, fontWeight: FontWeight.w700,fontSize: 20),
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(labelText: "Password"),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(AppTextStyles.primaryBlue),
                        foregroundColor: WidgetStateProperty.all(Colors.white),
                        padding: WidgetStateProperty.all(
                          EdgeInsets.symmetric(vertical: 18, horizontal: 50),
                        ),
                        textStyle: WidgetStateProperty.all(
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      onPressed: () async {
                        print('Login button pressed with ID: ${idController.text} and Password: ${passwordController.text}');
                        final authProvider =
                        Provider.of<AuthProvider>(context, listen: false);

                        await authProvider.login(
                          idController.text,
                          passwordController.text,
                        );

                        print('Login status: ${authProvider.isLoggedIn}');

                        if (authProvider.isLoggedIn) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => WellnessDashboard()),
                          );
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Invalid credentials. Please try again.")),
                          );
                        }
                      },
                      child: Text("Login"),
                    ),
                    SizedBox(height: 40,),
                    Text(
                      "Not a member of Wellness Activities! Join us now.",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: AppTextStyles.primaryBlue),
                    ),
                    SizedBox(height: 20,),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(AppTextStyles.orange),
                        foregroundColor: WidgetStateProperty.all(Colors.white),
                        padding: WidgetStateProperty.all(
                          EdgeInsets.symmetric(vertical: 18, horizontal: 50),
                        ),
                        textStyle: WidgetStateProperty.all(
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      onPressed: () async {
                        bool created = await authProvider.signUp(
                          idController.text,
                          passwordController.text,
                        );

                        if (created) {
                          print("User registered successfully");
                        } else {
                          print("User already exists");
                        }
                      },
                      child: Text("Sign Up"),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              flex: 5,
              child: Image.asset(
                'assets/images/wwact1.jpg', // Path to your image
                width: 300, // Adjust width as per your image size
                height: 800, // Adjust height if needed
              ),
            ),
          ],
        ),
      ),
    );
  }
}