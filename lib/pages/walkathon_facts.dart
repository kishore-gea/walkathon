import 'package:flutter/material.dart';

import '../style/text_style.dart';

class WalkathonFacts extends StatefulWidget {
  const WalkathonFacts({super.key});

  @override
  State<WalkathonFacts> createState() => _WalkathonFactsState();
}

class _WalkathonFactsState extends State<WalkathonFacts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Walkathon Facts',
          style: AppTextStyles.headline.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTextStyles.primaryBlue,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppTextStyles.white,
                      ),
                      child: Image.asset(
                        'assets/images/moon.png',
                        height: 50,
                        width: 50,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.visible,
                            'We have walked 2.8% of the way to the Moon.',
                            style: AppTextStyles.subtitle.copyWith(
                              color: AppTextStyles.primaryBlue,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.pink.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppTextStyles.white,
                      ),
                      child: Image.asset(
                        'assets/images/tree.png',
                        height: 50,
                        width: 50,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            softWrap: true,
                            maxLines: 1,
                            overflow: TextOverflow.visible,
                            'For every 10k steps if a tree is planted.',
                            style: AppTextStyles.subtitle.copyWith(
                              color: AppTextStyles.primaryBlue,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.visible,
                            '1,481 tress will be planted in total, absorb 29 tons of CO₂ per year',
                            style: AppTextStyles.subtitle.copyWith(
                              color: AppTextStyles.primaryBlue,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppTextStyles.white,
                      ),
                      child: Image.asset(
                        'assets/images/blr.png',
                        height: 50,
                        width: 50,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            'We are 38% on the way to Louisville from Bangalore',
                            style: AppTextStyles.subtitle.copyWith(
                              color: AppTextStyles.primaryBlue,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppTextStyles.white,
                      ),
                      child: Image.asset(
                        'assets/images/hyd.png',
                        height: 50,
                        width: 50,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.visible,
                            'We are 37% on the way to Louisville from Hyderabad.',
                            style: AppTextStyles.subtitle.copyWith(
                              color: AppTextStyles.primaryBlue,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.pink.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppTextStyles.white,
                      ),
                      child: Image.asset(
                        'assets/images/street_sign.png',
                        height: 30,
                        width: 30,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.visible,
                            'We can travel 22 times from HYD to BLR vice-versa',
                            style: AppTextStyles.subtitle.copyWith(
                              color: AppTextStyles.primaryBlue,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppTextStyles.white,
                      ),
                      child: Image.asset(
                        'assets/images/food.png',
                        height: 50,
                        width: 50,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            softWrap: true,
                            maxLines: 3,
                            overflow: TextOverflow.visible,
                            'Total calories burned: ~8,192,803 kcal(That’s about 15,800 Big Macs worth of calories! ',
                            style: AppTextStyles.subtitle.copyWith(
                              color: AppTextStyles.primaryBlue,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
