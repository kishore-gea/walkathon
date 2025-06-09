import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppTextStyles {
  static const Color primaryBlue = Color(0xFF003C71);
  static const Color secondaryBlue = Color(0xFF0057B7);
  static const Color metallicGrey = Color(0xFF97999B);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color lightGrey = Color(0xFFD9D9D6);
  static const Color orange = Color(0xFFFFA500);

  String formatIndianNumber(int number) {
    final formatter = NumberFormat.decimalPattern('en_IN');
    return formatter.format(number);
  }

  static const TextStyle headline = TextStyle(
    fontFamily: 'Barlow',
    fontWeight: FontWeight.w700,
    fontSize: 24,
  );

  static const TextStyle subtitle = TextStyle(
    fontFamily: 'Barlow',
    fontWeight: FontWeight.w500,
    fontSize: 18,
  );

  static const TextStyle body = TextStyle(
    fontFamily: 'Barlow',
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );

  static const TextStyle italic = TextStyle(
    fontFamily: 'Barlow',
    fontStyle: FontStyle.italic,
    fontSize: 16,
  );

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismiss on tap outside
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text(
                "Counting our steps \none by one..",
                style: AppTextStyles.subtitle.copyWith(
                  color: AppTextStyles.primaryBlue,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void hideLoadingDialog(BuildContext context) {
    Navigator.pop(context); // Close the dialog
  }
}
