import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wellnesswalkathon/model/participent_data.dart';

import '../../data_constants/stepcount_data.dart';
import '../../style/text_style.dart';

class StatsDisplay extends StatefulWidget {
  const StatsDisplay({
    super.key,
    required this.title,
    required this.code1,
    required this.code2,
  });

  final String title;
  final String code1;
  final String code2;

  @override
  State<StatsDisplay> createState() => _StatsDisplayState();
}

class _StatsDisplayState extends State<StatsDisplay> {
  bool isMenSelected = false;
  bool isWomenSelected = false;
  bool isAllSelected = true;
  String filter = 'A';
  bool isIndiaSelected = false;

  bool isMenINDSelected = false;
  bool isWomenINDSelected = false;
  bool isAllINDSelected = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTextStyles.white,
      appBar: AppBar(
        title: Text(
          widget.code1 == '6A' || widget.code1 == '6B'
              ? widget.title
              : 'Leaderboard Stats',
          style: AppTextStyles.headline.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTextStyles.primaryBlue,
            fontSize: 20,
          ),
        ),
        actions: [
          isIndiaSelected == true
              ? SizedBox()
              : GestureDetector(
                onTap: () {
                  setState(() {
                    isAllSelected = true;
                    isMenSelected = false;
                    isWomenSelected = false;
                    isIndiaSelected = false;
                    filter = 'A';
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color:
                          isAllSelected
                              ? AppTextStyles.primaryBlue
                              : Colors.grey,
                      width: 1,
                    ),
                    color:
                        isAllSelected
                            ? AppTextStyles.primaryBlue
                            : Colors.white,
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
          isIndiaSelected == true
              ? SizedBox()
              : GestureDetector(
                onTap: () {
                  setState(() {
                    isMenSelected = true;
                    isWomenSelected = false;
                    isAllSelected = false;
                    isIndiaSelected = false;
                    filter = 'M';
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(
                      color:
                          isMenSelected
                              ? AppTextStyles.primaryBlue
                              : Colors.grey,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    color:
                        isMenSelected
                            ? AppTextStyles.primaryBlue
                            : Colors.white,
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
          isIndiaSelected == true
              ? SizedBox()
              : GestureDetector(
                onTap: () {
                  setState(() {
                    isWomenSelected = true;
                    isMenSelected = false;
                    isAllSelected = false;
                    isIndiaSelected = false;
                    filter = 'F';
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color:
                          isWomenSelected
                              ? AppTextStyles.primaryBlue
                              : Colors.grey,
                      width: 1,
                    ),
                    color:
                        isWomenSelected
                            ? AppTextStyles.primaryBlue
                            : Colors.white,
                  ),
                  child: Text(
                    'WOMEN',
                    style: AppTextStyles.headline.copyWith(
                      fontWeight:
                          isWomenSelected ? FontWeight.bold : FontWeight.normal,
                      color:
                          isWomenSelected ? AppTextStyles.white : Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
          SizedBox(width: 8),
          widget.code1 == '6A' || widget.code2 == '6B'
              ? GestureDetector(
                onTap: () {
                  if (isIndiaSelected) {
                    isIndiaSelected = false;
                    isAllSelected = true;
                  } else {
                    isAllSelected = false;
                    isIndiaSelected = true;
                  }
                  setState(() {
                    isWomenSelected = false;
                    isMenSelected = false;
                    filter = 'INDIA';
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppTextStyles.primaryBlue,
                      width: 1,
                    ),
                    color: AppTextStyles.primaryBlue,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'IND',
                        style: AppTextStyles.headline.copyWith(
                          fontWeight:
                              isIndiaSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                          color:
                              isIndiaSelected
                                  ? AppTextStyles.white
                                  : Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        'HYD & BLR ',
                        style: AppTextStyles.headline.copyWith(
                          fontWeight:
                              !isIndiaSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                          color:
                              !isIndiaSelected
                                  ? AppTextStyles.white
                                  : Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              : SizedBox(),
          SizedBox(width: 24),
        ],
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            widget.code1 == '6A' || widget.code1 == '6B'
                ? isIndiaSelected
                    ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 8.0),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 5.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade300,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(2.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Image.asset(
                                  'assets/images/ind.png',
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'INDIA',
                                style: AppTextStyles.subtitle.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppTextStyles.primaryBlue,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isWomenINDSelected = true;
                                    isMenINDSelected = false;
                                    isAllINDSelected = false;
                                    filter = 'F';
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4.0,
                                    horizontal: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color:
                                          isWomenINDSelected
                                              ? AppTextStyles.primaryBlue
                                              : Colors.grey,
                                      width: 1,
                                    ),
                                    color:
                                        isWomenINDSelected
                                            ? AppTextStyles.primaryBlue
                                            : Colors.white,
                                  ),
                                  child: Text(
                                    'WOMEN',
                                    style: AppTextStyles.headline.copyWith(
                                      fontWeight:
                                          isWomenINDSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                      color:
                                          isWomenINDSelected
                                              ? AppTextStyles.white
                                              : Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isWomenINDSelected = false;
                                    isMenINDSelected = true;
                                    isAllINDSelected = false;
                                    filter = 'M';
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4.0,
                                    horizontal: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color:
                                          isMenINDSelected
                                              ? AppTextStyles.primaryBlue
                                              : Colors.grey,
                                      width: 1,
                                    ),
                                    color:
                                        isMenINDSelected
                                            ? AppTextStyles.primaryBlue
                                            : Colors.white,
                                  ),
                                  child: Text(
                                    'MEN',
                                    style: AppTextStyles.headline.copyWith(
                                      fontWeight:
                                          isMenINDSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                      color:
                                          isMenINDSelected
                                              ? AppTextStyles.white
                                              : Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isWomenINDSelected = false;
                                    isMenINDSelected = false;
                                    isAllINDSelected = true;
                                    filter = 'A';
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4.0,
                                    horizontal: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color:
                                          isAllINDSelected
                                              ? AppTextStyles.primaryBlue
                                              : Colors.grey,
                                      width: 1,
                                    ),
                                    color:
                                        isAllINDSelected
                                            ? AppTextStyles.primaryBlue
                                            : Colors.white,
                                  ),
                                  child: Text(
                                    'ALL',
                                    style: AppTextStyles.headline.copyWith(
                                      fontWeight:
                                          isAllINDSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                      color:
                                          isAllINDSelected
                                              ? AppTextStyles.white
                                              : Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Expanded(
                          child: SingleChildScrollView(
                            child: FutureBuilder(
                              future: StepCountData().getLeaderStats(
                                '6C',
                                filter,
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
                                                                    data.jun
                                                                        .toString(),
                                                                  ) >
                                                                  0
                                                              ? AppTextStyles()
                                                                  .formatIndianNumber(
                                                                    int.parse(
                                                                      data.jun
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

                                                    Center(
                                                      child:
                                                          getAvgMonthStepCount(
                                                            data,
                                                            widget.code1,
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
                                                                      data.jun
                                                                          .toString(),
                                                                    ) >
                                                                    0
                                                                ? AppTextStyles()
                                                                    .formatIndianNumber(
                                                                      int.parse(
                                                                        data.jun
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
                                                              widget.code1,
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
                    )
                    : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 8.0),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                  vertical: 5.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.orange.shade300,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(2.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      child: Image.asset(
                                        'assets/images/hyd.png',
                                        height: 30,
                                        width: 30,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'HYDERABAD',
                                      style: AppTextStyles.subtitle.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppTextStyles.primaryBlue,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: FutureBuilder(
                                    future: StepCountData().getLeaderStats(
                                      widget.code1,
                                      filter,
                                    ),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Center(
                                          child: Text(
                                            'Error: ${snapshot.error}',
                                          ),
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
                                                style: AppTextStyles.body
                                                    .copyWith(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color:
                                                          AppTextStyles
                                                              .metallicGrey,
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
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            padding:
                                                                const EdgeInsets.symmetric(
                                                                  vertical: 2.0,
                                                                  horizontal:
                                                                      8.0,
                                                                ),
                                                            decoration: BoxDecoration(
                                                              shape:
                                                                  BoxShape
                                                                      .rectangle,
                                                              color:
                                                                  Colors.white,
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
                                                                    fontSize:
                                                                        24,
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
                                                                  TextAlign
                                                                      .center,
                                                              '${data.name}',
                                                              style: AppTextStyles
                                                                  .subtitle
                                                                  .copyWith(
                                                                    fontSize:
                                                                        18,
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
                                                                    vertical:
                                                                        4.0,
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
                                                                AppTextStyles()
                                                                    .formatIndianNumber(
                                                                      int.parse(
                                                                        data.apr
                                                                            .toString(),
                                                                      ),
                                                                    ),
                                                                style: AppTextStyles
                                                                    .subtitle
                                                                    .copyWith(
                                                                      fontSize:
                                                                          18,
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

                                                          Center(
                                                            child:
                                                                getAvgMonthStepCount(
                                                                  data,
                                                                  widget.code1,
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
                                                                      FontWeight
                                                                          .bold,
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
                                                                    fontSize:
                                                                        18,
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
                                                                      vertical:
                                                                          4.0,
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
                                                                  AppTextStyles()
                                                                      .formatIndianNumber(
                                                                        int.parse(
                                                                          data.jun
                                                                              .toString(),
                                                                        ),
                                                                      ),
                                                                  style: AppTextStyles.subtitle.copyWith(
                                                                    fontSize:
                                                                        18,
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
                                                                    widget
                                                                        .code1,
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
                        Expanded(
                          flex: 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 8.0),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                  vertical: 5.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.orange.shade300,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      child: Image.asset(
                                        'assets/images/blr.png',
                                        height: 25,
                                        width: 25,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'BANGALORE',
                                      style: AppTextStyles.subtitle.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppTextStyles.primaryBlue,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: FutureBuilder(
                                    future: StepCountData().getLeaderStats(
                                      widget.code2,
                                      filter,
                                    ),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Center(
                                          child: Text(
                                            'Error: ${snapshot.error}',
                                          ),
                                        );
                                      } else if (!snapshot.hasData ||
                                          snapshot.data!.isEmpty) {
                                        return Center(
                                          child: Column(
                                            children: [
                                              Text(
                                                'No steps found',
                                                style: AppTextStyles.body
                                                    .copyWith(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color:
                                                          AppTextStyles
                                                              .metallicGrey,
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
                                                    : Colors.green.shade100,
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
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            padding:
                                                                const EdgeInsets.symmetric(
                                                                  vertical: 2.0,
                                                                  horizontal:
                                                                      8.0,
                                                                ),
                                                            decoration: BoxDecoration(
                                                              shape:
                                                                  BoxShape
                                                                      .rectangle,
                                                              color:
                                                                  Colors.white,
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
                                                                    fontSize:
                                                                        24,
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
                                                                  TextAlign
                                                                      .center,
                                                              '${data.name}',
                                                              style: AppTextStyles
                                                                  .subtitle
                                                                  .copyWith(
                                                                    fontSize:
                                                                        18,
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
                                                                    vertical:
                                                                        4.0,
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
                                                                AppTextStyles()
                                                                    .formatIndianNumber(
                                                                      int.parse(
                                                                        data.apr
                                                                            .toString(),
                                                                      ),
                                                                    ),
                                                                style: AppTextStyles
                                                                    .subtitle
                                                                    .copyWith(
                                                                      fontSize:
                                                                          18,
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

                                                          Center(
                                                            child:
                                                                getAvgMonthStepCount(
                                                                  data,
                                                                  widget.code1,
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
                                                            '${index + 1}.',
                                                            style: AppTextStyles
                                                                .subtitle
                                                                .copyWith(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color:
                                                                      AppTextStyles
                                                                          .primaryBlue,
                                                                ),
                                                          ),
                                                          SizedBox(width: 5),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Text(
                                                              '${data.name}',
                                                              style: AppTextStyles
                                                                  .subtitle
                                                                  .copyWith(
                                                                    fontSize:
                                                                        18,
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
                                                                      vertical:
                                                                          4.0,
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
                                                                  AppTextStyles()
                                                                      .formatIndianNumber(
                                                                        int.parse(
                                                                          data.jun
                                                                              .toString(),
                                                                        ),
                                                                      ),
                                                                  style: AppTextStyles.subtitle.copyWith(
                                                                    fontSize:
                                                                        18,
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
                                                                    widget
                                                                        .code1,
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
                      ],
                    )
                : Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget.code1 == '5A' || widget.code1 == '5B'
                            ? Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: Text(
                                'An uptrend is identified when someone walks at least 25,000 more steps in a month compared to the previous month',
                                style: AppTextStyles.headline.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppTextStyles.primaryBlue,
                                  fontSize: 20,
                                ),
                              ),
                            )
                            : widget.code1 == '1A' || widget.code2 == '1B'
                            ? Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                'Consistently Averaged 10K in consecutive months',
                                style: AppTextStyles.headline.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppTextStyles.primaryBlue,
                                  fontSize: 20,
                                ),
                              ),
                            )
                            : widget.code1 == '2A' || widget.code2 == '2B'
                            ? Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                'Consistently Averaged 7K Steps in consecutive months',
                                style: AppTextStyles.headline.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppTextStyles.primaryBlue,
                                  fontSize: 20,
                                ),
                              ),
                            )
                            : widget.code1 == '3A' || widget.code2 == '3B'
                            ? Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                'Consistently Averaged 5K Steps in consecutive months',
                                style: AppTextStyles.headline.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppTextStyles.primaryBlue,
                                  fontSize: 20,
                                ),
                              ),
                            )
                            : SizedBox(height: 0),
                        SizedBox(height: 15),
                        Container(
                          margin: const EdgeInsets.only(left: 8.0),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade300,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(2.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Image.asset(
                                  'assets/images/hyd.png',
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'HYDERABAD',
                                style: AppTextStyles.subtitle.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppTextStyles.primaryBlue,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        FutureBuilder(
                          future: StepCountData().getLeaderStats(
                            widget.code1,
                            filter,
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text('Error: ${snapshot.error}'),
                              );
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return Center(
                                child: Column(
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
                                return GestureDetector(
                                  // onTap: {},
                                  child: Card(
                                    elevation: 2,
                                    shadowColor: Colors.white,
                                    color:
                                        data.gender == 'Female'
                                            ? Colors.pink.shade100
                                            : Colors.blue.shade100,

                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8.0,
                                        horizontal: 16,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: !kIsWeb ? 0 : 4,
                                            child: Text(
                                              '${data.name}  ',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppTextStyles.subtitle
                                                  .copyWith(
                                                    fontSize: !kIsWeb ? 12 : 20,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        AppTextStyles
                                                            .primaryBlue,
                                                  ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: !kIsWeb ? 0 : 2,
                                            child: Center(
                                              child: getAvgSteps(
                                                data,
                                                widget.code1,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: !kIsWeb ? 1 : 2,
                                            child: SizedBox(),
                                          ),
                                          Expanded(
                                            flex: !kIsWeb ? 2 : 1,
                                            child: Center(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      vertical: 4.0,
                                                      horizontal: 16.0,
                                                    ),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  shape: BoxShape.rectangle,
                                                  color: AppTextStyles.white,
                                                ),
                                                child: Text(
                                                  AppTextStyles()
                                                      .formatIndianNumber(
                                                        int.parse(
                                                          data.total.toString(),
                                                        ),
                                                      ),
                                                  style: AppTextStyles.subtitle
                                                      .copyWith(
                                                        fontSize:
                                                            !kIsWeb ? 10 : 13,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            AppTextStyles
                                                                .primaryBlue,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        SizedBox(height: 10),
                        Container(
                          margin: const EdgeInsets.only(left: 8.0),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade300,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Image.asset(
                                  'assets/images/blr.png',
                                  height: 25,
                                  width: 25,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'BANGALORE',
                                style: AppTextStyles.subtitle.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppTextStyles.primaryBlue,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        FutureBuilder(
                          future: StepCountData().getLeaderStats(
                            widget.code2,
                            filter,
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text('Error: ${snapshot.error}'),
                              );
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return Center(
                                child: Column(
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
                                return GestureDetector(
                                  // onTap: {},
                                  child: Card(
                                    elevation: 2,
                                    shadowColor: Colors.white,
                                    color:
                                        data.gender == 'Female'
                                            ? Colors.pink.shade100
                                            : Colors.blue.shade100,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8.0,
                                        horizontal: 16,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: !kIsWeb ? 0 : 4,
                                            child: Text(
                                              '${data.name}  ',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppTextStyles.subtitle
                                                  .copyWith(
                                                    fontSize: !kIsWeb ? 12 : 20,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        AppTextStyles
                                                            .primaryBlue,
                                                  ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: !kIsWeb ? 0 : 2,
                                            child: Center(
                                              child: getAvgSteps(
                                                data,
                                                widget.code1,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: !kIsWeb ? 1 : 2,
                                            child: SizedBox(),
                                          ),
                                          Expanded(
                                            flex: !kIsWeb ? 2 : 1,
                                            child: Center(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      vertical: 4.0,
                                                      horizontal: 16.0,
                                                    ),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  shape: BoxShape.rectangle,
                                                  color: AppTextStyles.white,
                                                ),
                                                child: Text(
                                                  AppTextStyles()
                                                      .formatIndianNumber(
                                                        int.parse(
                                                          data.total.toString(),
                                                        ),
                                                      ),
                                                  style: AppTextStyles.subtitle
                                                      .copyWith(
                                                        fontSize:
                                                            !kIsWeb ? 10 : 13,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            AppTextStyles
                                                                .primaryBlue,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
      ),
    );
  }

  getAvgMonthStepCount(ParticipentData data, String code) {
    int userSteps = int.parse(data.jun.toString());
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

  getAvgSteps(ParticipentData data, String code) {
    int marSteps = int.parse(data.steps.toString());
    final marAyvSteps = marSteps / 31;
    int aprSteps = int.parse(data.apr.toString());
    final aprAyvSteps = aprSteps / 30;
    int maySteps = int.parse(data.may.toString());
    final mayAyvSteps = maySteps / 31;
    int junSteps = int.parse(data.jun.toString());
    final junAvgSteps = junSteps / 30;
    // var value = (marAyvSteps + aprAyvSteps) / 2;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: AppTextStyles.primaryBlue,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTextStyles.primaryBlue, width: 2),
      ),
      child:
          code == '5A' || code == '5B'
              ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    getValue(data),
                    style: AppTextStyles.subtitle.copyWith(
                      fontSize: !kIsWeb ? 14 : 18,
                      fontWeight: FontWeight.bold,
                      color: AppTextStyles.white,
                    ),
                  ),
                  SizedBox(width: 5),
                  Icon(
                    Icons.trending_up_outlined,
                    color: Colors.green,
                    size: 20,
                  ),
                  SizedBox(width: 5),
                ],
              )
              : Text(
                '${AppTextStyles().formatIndianNumber(marAyvSteps.toInt())} - ${AppTextStyles().formatIndianNumber(aprAyvSteps.toInt())} - ${AppTextStyles().formatIndianNumber(mayAyvSteps.toInt())} -${AppTextStyles().formatIndianNumber(junAvgSteps.toInt())}',
                style: AppTextStyles.subtitle.copyWith(
                  fontSize: !kIsWeb ? 12 : 14,
                  fontWeight: FontWeight.bold,
                  color: AppTextStyles.white,
                ),
              ),
    );
  }

  String getValue(ParticipentData data) {
    int maySteps = int.parse(data.may.toString());
    int junSteps = int.parse(data.jun.toString());
    final val = junSteps - maySteps;
    return AppTextStyles().formatIndianNumber(val);
  }
}
