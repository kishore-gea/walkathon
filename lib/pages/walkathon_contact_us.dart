import 'package:flutter/material.dart';
import 'package:wellnesswalkathon/pages/walkathon_rate_us.dart';

import '../style/text_style.dart';

class WalkathonContactUs extends StatefulWidget {
  const WalkathonContactUs({super.key});

  @override
  State<WalkathonContactUs> createState() => _WalkathonContactUsState();
}

class _WalkathonContactUsState extends State<WalkathonContactUs> {
  List<String> hydSPOCS = [
    'Prashanti Kanugula',
    'Piyush Bhelrao',
    'Babula Nagakshitha',
    'Lehari Thalla',
    'Kishore Prudhivi',
  ];
  List<String> blrSPOCS = [
    'Gaurav Sharma',
    'Arvind Kumar',
    'Suresh Kumar',
    'Preetesh Shetty',
    'Pranjal Tiwari',
    'Shahi Samiksha',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Center(
          child: Text(
            '2025 Team Well-Within ',
            style: AppTextStyles.headline.copyWith(
              fontWeight: FontWeight.normal,
              color: AppTextStyles.primaryBlue,
              fontSize: 12,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WalkathonRateUs(),
                  ),
                );
              },
              child: Icon(Icons.rate_review, color: AppTextStyles.primaryBlue),
            ),
          ),
        ],
        title: Text(
          'Contact US',
          style: AppTextStyles.headline.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTextStyles.primaryBlue,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'For any queries, please reach out to us',
                  style: AppTextStyles.headline.copyWith(
                    fontWeight: FontWeight.normal,
                    color: AppTextStyles.primaryBlue,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'HYDERABAD',
                    style: AppTextStyles.subtitle.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTextStyles.primaryBlue,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 100,
                  child: Expanded(
                    child: ListView.builder(
                      itemCount: hydSPOCS.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: 100,
                          child: Card(
                            color: Colors.blue.shade100,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.account_circle,
                                    color: AppTextStyles.primaryBlue,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    hydSPOCS[index],
                                    style: AppTextStyles.headline.copyWith(
                                      fontWeight: FontWeight.normal,
                                      color: AppTextStyles.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Container(
                                    padding: const EdgeInsets.all(4.0),
                                    decoration: BoxDecoration(
                                      color: Colors.orange.shade100,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      'WS - 097',
                                      style: AppTextStyles.subtitle.copyWith(
                                        fontWeight: FontWeight.normal,
                                        color: AppTextStyles.primaryBlue,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'BANGALORE',
                    style: AppTextStyles.subtitle.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTextStyles.primaryBlue,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 100,
                  child: Expanded(
                    child: ListView.builder(
                      itemCount: blrSPOCS.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          // height: 200,
                          child: Card(
                            color: Colors.blue.shade100,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.account_circle,
                                    color: AppTextStyles.primaryBlue,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    blrSPOCS[index],
                                    style: AppTextStyles.headline.copyWith(
                                      fontWeight: FontWeight.normal,
                                      color: AppTextStyles.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Container(
                                    padding: const EdgeInsets.all(4.0),
                                    decoration: BoxDecoration(
                                      color: Colors.orange.shade100,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      'WS - 097',
                                      style: AppTextStyles.subtitle.copyWith(
                                        fontWeight: FontWeight.normal,
                                        color: AppTextStyles.primaryBlue,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
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
