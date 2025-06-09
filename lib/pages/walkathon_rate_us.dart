import 'package:flutter/material.dart';

import '../style/text_style.dart';

class WalkathonRateUs extends StatefulWidget {
  const WalkathonRateUs({super.key});

  @override
  State<WalkathonRateUs> createState() => _WalkathonRateUsState();
}

class _WalkathonRateUsState extends State<WalkathonRateUs> {
  int _rating = 0;

  void _setRating(int value) {
    setState(() {
      _rating = value;
    });
  }

  Widget buildStar(int index) {
    return GestureDetector(
      onTap: () {
        _setRating(index + 1);
      },
      child: Icon(
        index < _rating ? Icons.star : Icons.star_border,
        color: Colors.amber,
        size: 30,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: AppTextStyles.primaryBlue,
        child: Center(
          child: Text(
            'SUBMIT',
            style: AppTextStyles.headline.copyWith(
              fontWeight: FontWeight.bold,
              color: AppTextStyles.white,
              fontSize: 22,
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(
          'Rate Us',
          style: AppTextStyles.headline.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTextStyles.primaryBlue,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text(
              'How was your overall \nexperience ?',
              style: AppTextStyles.headline.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTextStyles.primaryBlue,
                fontSize: 22,
              ),
            ),
            SizedBox(height: 15),
            Text(
              'It will help us to serve you better in future. \nPlease rate us.',
              style: AppTextStyles.headline.copyWith(
                fontWeight: FontWeight.normal,
                color: AppTextStyles.primaryBlue,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 15),
            Row(children: List.generate(5, (index) => buildStar(index))),
            SizedBox(height: 15),
            Text(
              'What can we improve ?',
              style: AppTextStyles.headline.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTextStyles.primaryBlue,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Type your feedback here',
                    hintStyle: AppTextStyles.headline.copyWith(
                      fontWeight: FontWeight.normal,
                      color: AppTextStyles.primaryBlue,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
