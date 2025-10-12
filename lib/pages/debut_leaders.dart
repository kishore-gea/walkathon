
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../data_constants/stepcount_data.dart';
import '../model/participent_data.dart';
import '../style/text_style.dart';

class DebutLeaders extends StatefulWidget {
  const DebutLeaders({super.key});

  @override
  State<DebutLeaders> createState() => _DebutLeadersState();
}

class _DebutLeadersState extends State<DebutLeaders> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: AppTextStyles.white,
          appBar: AppBar(
              title: Text('Debutant Board',
                style: AppTextStyles.headline.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTextStyles.primaryBlue,
                  fontSize: 20,
                ),
              )
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Every journey starts with a single step — meet our debutants.',style: AppTextStyles.headline.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTextStyles.primaryBlue,
                  fontSize: 20,
                ),),
                Expanded(
                  child: SingleChildScrollView(
                    child: FutureBuilder(
                      future: StepCountData().getLeaderStats(
                        '7A',
                        'ALL',
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Center(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'No steps found',
                                  style: AppTextStyles.body.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: AppTextStyles.metallicGrey,
                                  ),
                                ),
                                Icon(
                                  Icons.do_not_step,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          );
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final data = snapshot.data![index];
                            return Card(
                              elevation: 4,
                              color:
                              data.gender == 'Female'
                                  ? Colors.pink.shade100
                                  : Colors.blue.shade100,
                              child:
                              !kIsWeb
                                  ? Padding(
                                padding:
                                const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 16,
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding:
                                      const EdgeInsets.symmetric(
                                        vertical: 2.0,
                                        horizontal: 8.0,
                                      ),
                                      decoration: BoxDecoration(
                                        shape:
                                        BoxShape.rectangle,
                                        color: Colors.white,
                                        border: Border.all(
                                          color:
                                          AppTextStyles
                                              .primaryBlue,
                                          width: 2,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(
                                          12,
                                        ),
                                      ),
                                      child: Text(
                                        ' ${index + 1} ',
                                        style: AppTextStyles
                                            .subtitle
                                            .copyWith(
                                          fontSize: 24,
                                          fontWeight:
                                          FontWeight
                                              .bold,
                                          color:
                                          AppTextStyles
                                              .primaryBlue,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Center(
                                      child: Text(
                                        textAlign:
                                        TextAlign.center,
                                        '${data.name}',
                                        style: AppTextStyles
                                            .subtitle
                                            .copyWith(
                                          fontSize: 18,
                                          fontWeight:
                                          FontWeight
                                              .bold,
                                          color:
                                          AppTextStyles
                                              .primaryBlue,
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Container(
                                        padding:
                                        const EdgeInsets.symmetric(
                                          vertical: 4.0,
                                          horizontal: 16.0,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(
                                            12,
                                          ),
                                          shape:
                                          BoxShape
                                              .rectangle,
                                          color:
                                          AppTextStyles
                                              .primaryBlue,
                                        ),
                                        child: Text(
                                          int.parse(
                                            data.sep
                                                .toString(),
                                          ) >
                                              0
                                              ? AppTextStyles()
                                              .formatIndianNumber(
                                            int.parse(
                                              data.sep
                                                  .toString(),
                                            ),
                                          )
                                              : 'D.N.S',
                                          style: AppTextStyles
                                              .subtitle
                                              .copyWith(
                                            fontSize: 18,
                                            fontWeight:
                                            FontWeight
                                                .bold,
                                            color:
                                            AppTextStyles
                                                .white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                                  : Padding(
                                padding:
                                const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 16,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text(
                                      '${index + 1}. ',
                                      style: AppTextStyles
                                          .subtitle
                                          .copyWith(
                                        fontSize: 18,
                                        fontWeight:
                                        FontWeight.bold,
                                        color:
                                        AppTextStyles
                                            .primaryBlue,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        '${data.name}',
                                        style: AppTextStyles
                                            .subtitle
                                            .copyWith(
                                          fontSize: 18,
                                          fontWeight:
                                          FontWeight
                                              .bold,
                                          color:
                                          AppTextStyles
                                              .primaryBlue,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: Container(
                                          padding:
                                          const EdgeInsets.symmetric(
                                            vertical: 4.0,
                                            horizontal:
                                            16.0,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(
                                              12,
                                            ),
                                            shape:
                                            BoxShape
                                                .rectangle,
                                            color:
                                            AppTextStyles
                                                .primaryBlue,
                                          ),
                                          child: Text(
                                            int.parse(
                                              data.sep
                                                  .toString(),
                                            ) >
                                                0
                                                ? AppTextStyles()
                                                .formatIndianNumber(
                                              int.parse(
                                                data.sep
                                                    .toString(),
                                              ),
                                            )
                                                : 'D.N.S',

                                            style: AppTextStyles
                                                .subtitle
                                                .copyWith(
                                              fontSize: 18,
                                              fontWeight:
                                              FontWeight
                                                  .bold,
                                              color:
                                              AppTextStyles
                                                  .white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    Expanded(
                                      flex: 1,
                                      child: Center(
                                        child:
                                        getAvgMonthStepCount(
                                          data,
                                        ),
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
              ],

            ),
          ),
        ),
    );
  }

  getAvgMonthStepCount(ParticipentData data) {
    int userSteps = int.parse(data.sep.toString());
    if (userSteps != 0) {
      final monthCode = DateTime.now().month - 1;
      var val = 30;
      if (monthCode == 3) {
        val = 31;
      } else if (monthCode == 4) {
        val = 30;
      } else if (monthCode == 5) {
        val = 31;
      } else if (monthCode == 6) {
        val = 30;
      } else if (monthCode == 7) {
        val = 31;
      } else if (monthCode == 8) {
        val = 31;
      } else if (monthCode == 9) {
        val = 30;
      }
      final aprAyvSteps = userSteps / val;
      return Container(
        margin: const EdgeInsets.only(top: 8.0),
        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.blue.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTextStyles.secondaryBlue, width: 1),
        ),
        child: Text(
          userSteps != 0
              ? AppTextStyles().formatIndianNumber(aprAyvSteps.toInt())
              : '0',
          style: AppTextStyles.subtitle.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
      );
    }
  }

}


