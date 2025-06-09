import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wellnesswalkathon/model/participent_data.dart';

import '../data_constants/stepcount_data.dart';
import '../style/text_style.dart';

class RollingLeader extends StatefulWidget {
  const RollingLeader({super.key});

  @override
  State<RollingLeader> createState() => _RollingLeaderState();
}

class _RollingLeaderState extends State<RollingLeader> {
  bool isMenSelected = false;
  bool isWomenSelected = false;
  bool isAllSelected = true;
  String filter = 'A';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rolling Leaderboard',
          style: AppTextStyles.headline.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTextStyles.primaryBlue,
            fontSize: 20,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                isAllSelected = true;
                isMenSelected = false;
                isWomenSelected = false;
                filter = 'A';
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color:
                      isAllSelected ? AppTextStyles.primaryBlue : Colors.grey,
                  width: 1,
                ),
                color: isAllSelected ? AppTextStyles.primaryBlue : Colors.white,
              ),
              child: Text(
                'ALL',
                style: AppTextStyles.headline.copyWith(
                  fontWeight:
                      isAllSelected ? FontWeight.bold : FontWeight.normal,
                  color: isAllSelected ? AppTextStyles.white : Colors.grey,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              setState(() {
                isMenSelected = true;
                isWomenSelected = false;
                isAllSelected = false;
                filter = 'M';
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(
                  color:
                      isMenSelected ? AppTextStyles.primaryBlue : Colors.grey,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
                color: isMenSelected ? AppTextStyles.primaryBlue : Colors.white,
              ),
              child: Text(
                'MEN',
                style: AppTextStyles.headline.copyWith(
                  fontWeight:
                      isMenSelected ? FontWeight.bold : FontWeight.normal,
                  color: isMenSelected ? AppTextStyles.white : Colors.grey,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              setState(() {
                isWomenSelected = true;
                isMenSelected = false;
                isAllSelected = false;
                filter = 'F';
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color:
                      isWomenSelected ? AppTextStyles.primaryBlue : Colors.grey,
                  width: 1,
                ),
                color:
                    isWomenSelected ? AppTextStyles.primaryBlue : Colors.white,
              ),
              child: Text(
                'WOMEN',
                style: AppTextStyles.headline.copyWith(
                  fontWeight:
                      isWomenSelected ? FontWeight.bold : FontWeight.normal,
                  color: isWomenSelected ? AppTextStyles.white : Colors.grey,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          SizedBox(width: 24),
        ],
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Expanded(
          child: SingleChildScrollView(
            child: FutureBuilder(
              future: StepCountData().getLeaderStats('RL', filter),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No steps found'));
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final data = snapshot.data![index];
                    return Card(
                      elevation: 2,
                      color: Colors.orange.shade100,
                      child:
                          !kIsWeb
                              ? Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 16,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 2.0,
                                        horizontal: 8.0,
                                      ),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color: Colors.white,
                                        border: Border.all(
                                          color: AppTextStyles.primaryBlue,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        ' ${index + 1} ',
                                        style: AppTextStyles.subtitle.copyWith(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: AppTextStyles.primaryBlue,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Center(
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        '${data.name}',
                                        style: AppTextStyles.subtitle.copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: AppTextStyles.black,
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 4.0,
                                          horizontal: 16.0,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          shape: BoxShape.rectangle,
                                          color: AppTextStyles.primaryBlue,
                                        ),
                                        child: Text(
                                          AppTextStyles().formatIndianNumber(
                                            int.parse(data.apr.toString()),
                                          ),
                                          style: AppTextStyles.subtitle
                                              .copyWith(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: AppTextStyles.white,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              : Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 16,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${index + 1}',
                                      style: AppTextStyles.subtitle.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: AppTextStyles.black,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    CircleAvatar(
                                      backgroundColor:
                                          data.gender == 'Male'
                                              ? AppTextStyles.primaryBlue
                                              : Colors.pink,
                                      child: Text(
                                        data.name != null &&
                                                data.name!.isNotEmpty
                                            ? data.name![0].toUpperCase()
                                            : '?',
                                        style: TextStyle(
                                          fontFamily: 'Barlow',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      flex: 1,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            '${data.name}',
                                            style: AppTextStyles.subtitle
                                                .copyWith(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppTextStyles.black,
                                                ),
                                          ),
                                          SizedBox(width: 15),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 2.0,
                                              horizontal: 8.0,
                                            ),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              color: AppTextStyles.white,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color:
                                                    AppTextStyles.primaryBlue,
                                                width: 2,
                                              ),
                                            ),
                                            child: Text(
                                              '${data.location}',
                                              style: AppTextStyles.subtitle
                                                  .copyWith(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        AppTextStyles
                                                            .secondaryBlue,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 4.0,
                                            horizontal: 16.0,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            shape: BoxShape.rectangle,
                                            color: AppTextStyles.primaryBlue,
                                          ),
                                          child: Text(
                                            AppTextStyles().formatIndianNumber(
                                              int.parse(data.total.toString()),
                                            ),
                                            style: AppTextStyles.subtitle
                                                .copyWith(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppTextStyles.white,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 4.0,
                                          horizontal: 16.0,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          shape: BoxShape.rectangle,
                                          color: AppTextStyles.white,
                                        ),
                                        child: getMonthlyCount(data),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  getMonthlyCount(ParticipentData data) {
    var monthsCount = '';

    int stepsAPR = int.parse(data.apr.toString());
    int stepsMAR = int.parse(data.steps.toString());
    int stepsMAY = int.parse(data.may.toString());
    int stepsJUNE = int.parse(data.jun.toString());
    int stepsJULY = int.parse(data.jul.toString());
    int stepsAUG = int.parse(data.aug.toString());
    int stepsSEP = int.parse(data.sep.toString());

    if (DateTime.now().month == 4) {
      monthsCount = stepsMAR.toString();
    } else if (DateTime.now().month == 5) {
      if (stepsMAR > 0 && stepsAPR > 0) {
        monthsCount = '$stepsMAR | $stepsAPR';
      }
      stepsAPR = 0;
    } else if (DateTime.now().month == 6) {
      if (stepsMAR > 0 && stepsAPR > 0 && stepsMAY > 0) {
        monthsCount = '$stepsMAR | $stepsAPR | $stepsMAY';
      }
      stepsMAY = 0;
    } else if (DateTime.now().month == 7) {
      if (stepsMAR > 0 && stepsAPR > 0 && stepsMAY > 0 && stepsJUNE > 0) {
        monthsCount = '$stepsMAR | $stepsAPR | $stepsMAY  | $stepsJUNE';
      }
      stepsJUNE = 0;
    } else if (DateTime.now().month == 8) {
      if (stepsMAR > 0 &&
          stepsAPR > 0 &&
          stepsMAY > 0 &&
          stepsJUNE > 0 &&
          stepsJULY > 0) {
        monthsCount =
            '$stepsMAR | $stepsAPR | $stepsMAY  | $stepsJUNE | $stepsJULY';
      }
      stepsJULY = 0;
    } else if (DateTime.now().month == 9) {
      if (stepsMAR > 0 &&
          stepsAPR > 0 &&
          stepsMAY > 0 &&
          stepsJUNE > 0 &&
          stepsJULY > 0 &&
          stepsAUG > 0) {
        monthsCount =
            '$stepsMAR | $stepsAPR | $stepsMAY  | $stepsJUNE | $stepsJULY | $stepsAUG';
      }
      stepsAUG = 0;
    } else if (DateTime.now().month == 10) {
      if (stepsMAR > 0 &&
          stepsAPR > 0 &&
          stepsMAY > 0 &&
          stepsJUNE > 0 &&
          stepsJULY > 0 &&
          stepsAUG > 0 &&
          stepsSEP > 0) {
        monthsCount =
            '$stepsMAR | $stepsAPR | $stepsMAY  | $stepsJUNE | $stepsJULY | $stepsAUG | $stepsSEP';
      }
      stepsSEP = 0;
    }

    return Row(
      children: [
        Text(
          monthsCount,
          style: AppTextStyles.subtitle.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppTextStyles.primaryBlue,
          ),
        ),
        // Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 10),
        //   child: Icon(
        //     size: 15,
        //     Icons.snowshoeing,
        //     color: AppTextStyles.primaryBlue,
        //   ),
        // ),
        // Text(
        //   AppTextStyles().formatIndianNumber(int.parse(data.apr.toString())),
        //   style: AppTextStyles.subtitle.copyWith(
        //     fontSize: 14,
        //     fontWeight: FontWeight.bold,
        //     color: AppTextStyles.primaryBlue,
        //   ),
        // ),
      ],
    );
  }
}
