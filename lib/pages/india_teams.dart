import 'package:flutter/material.dart';
import 'package:wellnesswalkathon/data_constants/stepcount_data.dart';
import 'package:wellnesswalkathon/style/text_style.dart';

class IndiaTeamsDashboard extends StatefulWidget {
  const IndiaTeamsDashboard({super.key});

  @override
  State<IndiaTeamsDashboard> createState() => _IndiaTeamsDashboardState();
}

class _IndiaTeamsDashboardState extends State<IndiaTeamsDashboard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'GE Appliances India Teams - [MARCH - JUNE] 2025 Step Count',
          style: AppTextStyles.headline.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTextStyles.primaryBlue,
            fontSize: 22,
          ),
        ),
      ),
      body: SafeArea(
        child: Expanded(
          child: SingleChildScrollView(
            child: FutureBuilder(
              builder: (context, snapshot) {
                final data = snapshot.data;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final data = snapshot.data![index];
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        child: Card(
                          elevation: 8,
                          color:
                              index % 2 == 0
                                  ? Colors.blue.shade200
                                  : Colors.green.shade200,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 15,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${data.name}', // Replace with actual data
                                      style: AppTextStyles.headline.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppTextStyles.primaryBlue,
                                        fontSize: 22,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    IconGeneratorWidget(
                                      iconCount: data.members!.length,
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Divider(
                                    color: Colors.black87,
                                    thickness: 1,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppTextStyles().formatIndianNumber(
                                          int.parse(data.total.toString()),
                                        ), // Replace with actual data
                                        style: AppTextStyles.body.copyWith(
                                          fontSize: 55,
                                          fontWeight: FontWeight.normal,
                                          color: AppTextStyles.black,
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
                    },
                  );
                } else {
                  return Text('No data found');
                }
              },
              future: StepCountData().getTeamData(),
            ),
          ),
        ),
      ),
    );
  }
}

class IconGeneratorWidget extends StatelessWidget {
  final int iconCount;

  IconGeneratorWidget({required this.iconCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(iconCount, (index) {
        return Icon(
          size: 30,
          Icons.account_circle, // Replace with any icon
          color: AppTextStyles.primaryBlue,
        );
      }),
    );
  }
}
