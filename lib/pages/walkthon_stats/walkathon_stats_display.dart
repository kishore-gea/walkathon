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
  int selectedSeason = 1;
  int selectedMonthCode = 13;

  bool isMenINDSelected = false;
  bool isWomenINDSelected = false;
  bool isAllINDSelected = true;

  @override
  void initState() {
    super.initState();
    selectedSeason = StepCountData.currentSeason == 2 ? 2 : 1;
    selectedMonthCode = selectedSeason == 1 ? 13 : 15;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTextStyles.white,
      appBar: AppBar(
        title: SelectableText(
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
          (widget.code1 == '6A' || widget.code1 == '6B')
              ? Row(
                children: [
                  _buildSeasonChip(1, 'S1'),
                  _buildSeasonChip(2, 'S2'),
                  const SizedBox(width: 6),
                  PopupMenuButton<int>(
                    tooltip: 'Select Month',
                    onSelected: (code) {
                      setState(() {
                        selectedMonthCode = code;
                      });
                    },
                    itemBuilder: (context) {
                      return _selectedMonthOptions
                          .map(
                            (m) => PopupMenuItem<int>(
                              value: m['code'] as int,
                              child: Text(m['label'] as String),
                            ),
                          )
                          .toList();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppTextStyles.primaryBlue,
                          width: 1,
                        ),
                        color: Colors.white,
                      ),
                      child: Text(
                        _selectedMonthLabel,
                        style: AppTextStyles.headline.copyWith(
                          fontSize: 11,
                          color: AppTextStyles.primaryBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              )
              : const SizedBox(),
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
                  child: SelectableText(
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
                  child: SelectableText(
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
                  child: SelectableText(
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
                      SelectableText(
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
                      SelectableText(
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
                              SelectableText(
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
                                  child: SelectableText(
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
                                  child: SelectableText(
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
                                  child: SelectableText(
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
                                    child: SelectableText('Error: ${snapshot.error}'),
                                  );
                                } else if (!snapshot.hasData ||
                                    snapshot.data!.isEmpty) {
                                  return Center(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SelectableText(
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
                                final sortedData = _sortBySelectedMonth(
                                  List<ParticipentData>.from(snapshot.data!),
                                );
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: sortedData.length,
                                  itemBuilder: (context, index) {
                                    final data = sortedData[index];
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
                                                      child: SelectableText(
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
                                                      child: SelectableText(
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
                                                        child: SelectableText(
                                                          _selectedMonthSteps(data) > 0
                                                              ? AppTextStyles()
                                                                  .formatIndianNumber(
                                                                    _selectedMonthSteps(data),
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
                                                    SelectableText(
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
                                                      child: SelectableText(
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
                                                          child: SelectableText(
                                                            _selectedMonthSteps(data) > 0
                                                                ? AppTextStyles()
                                                                    .formatIndianNumber(
                                                                      _selectedMonthSteps(data),
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
                                    SelectableText(
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
                                          child: SelectableText(
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
                                              SelectableText(
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
                                      final sortedData = _sortBySelectedMonth(
                                        List<ParticipentData>.from(snapshot.data!),
                                      );
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: sortedData.length,
                                        itemBuilder: (context, index) {
                                          final data = sortedData[index];
                                           return Card(
                                            elevation: 4,
                                            color:
                                                data.awards == '1' ? AppTextStyles.orange :
                                                data.gender == 'Female'
                                                    ? Colors.red.shade100
                                                    : data.awards == '1' ? AppTextStyles.orange :Colors.blue.shade100,
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
                                                            child: SelectableText(
                                                              ' ${index + 1}',
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
                                                            child: SelectableText(
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
                                                              child: SelectableText(
                                                                AppTextStyles()
                                                                    .formatIndianNumber(
                                                                      _selectedMonthSteps(data),
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
                                                          SelectableText(
                                                            '${index + 1}.',
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
                                                            child: SelectableText(
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
                                                          SelectableText(
                                                            '${stepsToKm(_selectedMonthSteps(data)).toStringAsFixed(2)} KM',
                                                            style: AppTextStyles.subtitle.copyWith(
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 18,
                                                              color: AppTextStyles.white,
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
                                                                child: SelectableText(
                                                                  AppTextStyles()
                                                                      .formatIndianNumber(
                                                                        _selectedMonthSteps(data),
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
                                    SelectableText(
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
                                          child: SelectableText(
                                            'Error: ${snapshot.error}',
                                          ),
                                        );
                                      } else if (!snapshot.hasData ||
                                          snapshot.data!.isEmpty) {
                                        return Center(
                                          child: Column(
                                            children: [
                                              SelectableText(
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
                                      final sortedData = _sortBySelectedMonth(
                                        List<ParticipentData>.from(snapshot.data!),
                                      );
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: sortedData.length,
                                        itemBuilder: (context, index) {
                                          final data = sortedData[index];
                                          return Card(
                                            elevation: 4,
                                            color:
                                            data.awards == '1' ? AppTextStyles.orange :
                                            data.gender == 'Female'
                                                ? Colors.red.shade100
                                                : data.awards == '1' ? AppTextStyles.orange :Colors.blue.shade100,
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
                                                            child: SelectableText(
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
                                                            child: SelectableText(
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
                                                              child: SelectableText(
                                                                AppTextStyles()
                                                                    .formatIndianNumber(
                                                                      _selectedMonthSteps(data),
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
                                                          SelectableText(
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
                                                            child: SelectableText(
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
                                                          SelectableText(
                                                            '${stepsToKm(_selectedMonthSteps(data)).toStringAsFixed(2)} KM',
                                                            style: AppTextStyles.subtitle.copyWith(
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 18,
                                                              color: AppTextStyles.white,
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
                                                                child: SelectableText(
                                                                  AppTextStyles()
                                                                      .formatIndianNumber(
                                                                    _selectedMonthSteps(data),
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
                              child: SelectableText(
                                'An uptrend is defined as a month in which the participant logs a minimum of 25,000 additional steps compared with the preceding month',
                                style: AppTextStyles.headline.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppTextStyles.primaryBlue,
                                  fontSize: 20,
                                ),
                              ),
                            )
                            : widget.code1 == '1A' || widget.code2 == '1B'
                            ? Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8,vertical: 10),
                              child: SelectableText(
                                'Maintained a consistent record of walking at least 10,000 steps per month over successive months'.toUpperCase(),
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
                              child: SelectableText(
                                'Maintained a consistent record of walking at least 7,000 steps per month over successive months',
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
                              child: SelectableText(
                                'Maintained a consistent record of walking at least 5,000 steps per month over successive months',
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
                              SelectableText(
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
                                child: Text('Error: ${snapshot.error.toString()}'),
                              );
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return Center(
                                child: Column(
                                  children: [
                                    SelectableText(
                                      'No steps founds',
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
                                            child: SelectableText(
                                              '${data.name}',
                                              maxLines: 1,
                                              // o: TextOverflow.ellipsis,
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
                                            child: Row(
                                              children: [
                                                SelectableText(
                                                  '${StepCountData().getAvgValue(data)}',
                                                  style: AppTextStyles.subtitle.copyWith(fontWeight: FontWeight.bold),

                                                ),


                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: !kIsWeb ? 1 : 2,
                                            child: SizedBox(),
                                          ),
                                          getMonthSubmitted(data),
                                          // Expanded(
                                          //   flex: !kIsWeb ? 2 : 1,
                                          //   child: Center(
                                          //     child: Container(
                                          //       padding:
                                          //           const EdgeInsets.symmetric(
                                          //             vertical: 4.0,
                                          //             horizontal: 16.0,
                                          //           ),
                                          //       decoration: BoxDecoration(
                                          //         borderRadius:
                                          //             BorderRadius.circular(12),
                                          //         shape: BoxShape.rectangle,
                                          //         color: AppTextStyles.white,
                                          //       ),
                                          //       child: SelectableText(
                                          //         AppTextStyles()
                                          //             .formatIndianNumber(
                                          //               int.parse(
                                          //                 data.total.toString(),
                                          //               ),
                                          //             ),
                                          //         style: AppTextStyles.subtitle
                                          //             .copyWith(
                                          //               fontSize:
                                          //                   !kIsWeb ? 10 : 13,
                                          //               fontWeight:
                                          //                   FontWeight.bold,
                                          //               color:
                                          //                   AppTextStyles
                                          //                       .primaryBlue,
                                          //             ),
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
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
                              SelectableText(
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
                                child: SelectableText('Error: ${snapshot.error}'),
                              );
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return Center(
                                child: Column(
                                  children: [
                                    SelectableText(
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
                                            flex: !kIsWeb ? 2 : 4,
                                            child: SelectableText(
                                              '${data.name} ',

                                              maxLines: 1,
                                              // overflow: TextOverflow.ellipsis,
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
                                            child: Row(
                                              children: [
                                                SelectableText(
                                                  AppTextStyles()
                                                      .formatIndianNumber(
                                                    int.parse('${StepCountData().getAvgValue(data)}',),),
                                                  style: AppTextStyles.subtitle.copyWith(fontWeight: FontWeight.bold),

                                                ),
                                                // getMonthSubmitted(data),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: !kIsWeb ? 1 : 2,
                                            child: SizedBox(),
                                          ),
                                          getMonthSubmitted(data),
                                          // Expanded(
                                          //   flex: !kIsWeb ? 2 : 1,
                                          //   child: Center(
                                          //     child: Container(
                                          //       padding:
                                          //           const EdgeInsets.symmetric(
                                          //             vertical: 4.0,
                                          //             horizontal: 16.0,
                                          //           ),
                                          //       decoration: BoxDecoration(
                                          //         borderRadius:
                                          //             BorderRadius.circular(12),
                                          //         shape: BoxShape.rectangle,
                                          //         color: AppTextStyles.white,
                                          //       ),
                                          //       child: SelectableText(
                                          //         AppTextStyles()
                                          //             .formatIndianNumber(
                                          //               int.parse(
                                          //                 data.total.toString(),
                                          //               ),
                                          //             ),
                                          //         style: AppTextStyles.subtitle
                                          //             .copyWith(
                                          //               fontSize:
                                          //                   !kIsWeb ? 10 : 13,
                                          //               fontWeight:
                                          //                   FontWeight.bold,
                                          //               color:
                                          //                   AppTextStyles
                                          //                       .primaryBlue,
                                          //             ),
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
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

  List<Map<String, Object>> get _season1MonthOptions => const [
    {'label': 'Mar', 'code': 3, 'days': 31},
    {'label': 'Apr', 'code': 4, 'days': 30},
    {'label': 'May', 'code': 5, 'days': 31},
    {'label': 'Jun', 'code': 6, 'days': 30},
    {'label': 'Jul', 'code': 7, 'days': 31},
    {'label': 'Aug', 'code': 8, 'days': 31},
    {'label': 'Sep', 'code': 9, 'days': 30},
    {'label': 'Oct', 'code': 10, 'days': 31},
    {'label': 'Nov', 'code': 11, 'days': 30},
    {'label': 'Dec', 'code': 12, 'days': 31},
    {'label': 'Jan26', 'code': 13, 'days': 31},
  ];

  List<Map<String, Object>> get _season2MonthOptions => const [
    {'label': 'Mar26', 'code': 15, 'days': 31},
  ];

  List<Map<String, Object>> get _selectedMonthOptions =>
      selectedSeason == 1 ? _season1MonthOptions : _season2MonthOptions;

  String get _selectedMonthLabel {
    final month = _selectedMonthOptions.firstWhere(
      (m) => m['code'] == selectedMonthCode,
      orElse: () => _selectedMonthOptions.first,
    );
    return month['label'] as String;
  }

  int _selectedMonthDays() {
    final month = _selectedMonthOptions.firstWhere(
      (m) => m['code'] == selectedMonthCode,
      orElse: () => _selectedMonthOptions.first,
    );
    return month['days'] as int;
  }

  int _selectedMonthSteps(ParticipentData data) {
    final raw = StepCountData.getMonthValue(data, selectedMonthCode);
    return int.tryParse(raw) ?? 0;
  }

  List<ParticipentData> _sortBySelectedMonth(List<ParticipentData> input) {
    input.sort((a, b) {
      final bSteps = _selectedMonthSteps(b);
      final aSteps = _selectedMonthSteps(a);
      if (bSteps != aSteps) return bSteps.compareTo(aSteps);
      final aName = a.name ?? '';
      final bName = b.name ?? '';
      return aName.compareTo(bName);
    });
    return input;
  }

  Widget _buildSeasonChip(int season, String label) {
    final isSelected = selectedSeason == season;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSeason = season;
          selectedMonthCode = season == 1 ? 13 : 15;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 4),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppTextStyles.primaryBlue : Colors.grey,
            width: 1,
          ),
          color: isSelected ? AppTextStyles.primaryBlue : Colors.white,
        ),
        child: Text(
          label,
          style: AppTextStyles.headline.copyWith(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? AppTextStyles.white : Colors.grey,
            fontSize: 11,
          ),
        ),
      ),
    );
  }

  getAvgMonthStepCount(ParticipentData data, String code) {
    int userSteps = _selectedMonthSteps(data);
    if (userSteps != 0) {
      final aprAyvSteps = userSteps / _selectedMonthDays();
      return Container(
        margin: const EdgeInsets.only(top: 8.0),
        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.blue.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTextStyles.secondaryBlue, width: 1),
        ),
        child: SelectableText(
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


  Widget getMonthSubmitted(ParticipentData data) {
    List<String> months = [];
    int count = 0;
    if(data.mar!='0'){
      months.add('MAR');
      count++;
    }
    if(data.apr!='0'){
      months.add('APR');
      count++;
    }
    if(data.may!='0'){
      months.add('MAY');
      count++;
    }
    if(data.jun!='0'){
      months.add('JUN');
      count++;
    }
    if(data.jul!='0'){
      months.add('JUL');
      count++;
    }
    if(data.aug!='0'){
      months.add('AUG');
      count++;
    }
    if(data.sep!='0'){
      months.add('SEP');
      count++;
    }
    if(data.oct!='0') {
      months.add('OCT');
      count++;
    }
    if(data.nov!='0') {
      months.add('NOV');
      count++;
    }

    if(data.dec!='0') {
      months.add('DEC');
      count++;
    }

    if(data.jan26!='0') {
      months.add('JAN');
      count++;
    }

    print(' codes are ${widget.code1} and ${widget.code2}');
    return (widget.code1 == '5A' || widget.code2 == '5B') ?
        Container(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 8,vertical: 4),
          decoration: BoxDecoration(
            color: AppTextStyles.orange,
            borderRadius: BorderRadius.circular(8),
          ),
          child: SelectableText(AppTextStyles()
              .formatIndianNumber(getStepUpValueForThisMonth(data)),style: AppTextStyles.subtitle
              .copyWith(
            fontSize:
            !kIsWeb ? 10 : 13,
            fontWeight:
            FontWeight.bold,
            color:
            AppTextStyles
                .white,
          ),),
        ):
    Container(
      margin: EdgeInsetsGeometry.symmetric(horizontal: 20),
      padding: EdgeInsetsGeometry.all(8),
      decoration: BoxDecoration(
        color: AppTextStyles.white,
            borderRadius: BorderRadius.circular(8)
      ),
      child: Center(
        child: SelectableText(
          'Months : $count',
          style: AppTextStyles.subtitle.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppTextStyles.primaryBlue,
          ),
        ),
      ),
    );
  }

  getAvgSteps(ParticipentData data, String code) {
    int marSteps = int.parse(data.mar.toString());
    final marAyvSteps = marSteps / 31;
    int aprSteps = int.parse(data.apr.toString());
    final aprAyvSteps = aprSteps / 30;
    int maySteps = int.parse(data.may.toString());
    final mayAyvSteps = maySteps / 31;
    final junSteps = int.parse(data.jun.toString());
    final junAvgSteps = junSteps / 30;
    int julSteps = int.parse(data.jul.toString());
    final julAvgSteps = julSteps / 31;
    int augSteps = int.parse(data.aug.toString());
    final augAvgSteps = augSteps / 31;
    int septSteps = int.parse(data.sep.toString());
    final septAvgSteps = septSteps / 30;
    int octSteps = int.parse(data.oct.toString());
    final octAvgSteps = octSteps / 31;

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
                  SelectableText(
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
              : SelectableText(
                '${AppTextStyles().formatIndianNumber(marAyvSteps.toInt())} - ${AppTextStyles().formatIndianNumber(aprAyvSteps.toInt())} - ${AppTextStyles().formatIndianNumber(mayAyvSteps.toInt())} -${AppTextStyles().formatIndianNumber(junAvgSteps.toInt())}- ${AppTextStyles().formatIndianNumber(julAvgSteps.toInt())} - ${AppTextStyles().formatIndianNumber(augAvgSteps.toInt())} - ${AppTextStyles().formatIndianNumber(septAvgSteps.toInt())} - ${AppTextStyles().formatIndianNumber(octAvgSteps.toInt())}',
                style: AppTextStyles.subtitle.copyWith(
                  fontSize: !kIsWeb ? 12 : 12,
                  fontWeight: FontWeight.bold,
                  color: AppTextStyles.white,
                ),
              ),
    );
  }

  double stepsToKm(int steps) {
    return steps * 0.0008;
  }

  getStepUpValueForThisMonth(ParticipentData data) {
    int novSteps = int.parse(data.jan26.toString());
    int octSteps = int.parse(data.dec.toString());
    final stepUpValue = novSteps - octSteps;
    return stepUpValue;
  }

  String getValue(ParticipentData data) {
    /// We need to generate average steps for month based on months submitted
    int avgMonthsToCalculate = 0;
    if(data.mar!='0'){
        avgMonthsToCalculate = avgMonthsToCalculate + 31;
    }else if(data.apr!='0'){
        avgMonthsToCalculate = avgMonthsToCalculate + 30;
    }else if(data.may!='0'){
        avgMonthsToCalculate = avgMonthsToCalculate + 31;
    }else if(data.jun!='0'){
        avgMonthsToCalculate = avgMonthsToCalculate + 30;
    }else if(data.jul!='0'){
        avgMonthsToCalculate = avgMonthsToCalculate + 31;
    }else if(data.aug!='0'){
        avgMonthsToCalculate = avgMonthsToCalculate + 31;
    }else if(data.sep!='0'){
        avgMonthsToCalculate = avgMonthsToCalculate + 30;
    }else if(data.oct!='0') {
        avgMonthsToCalculate = avgMonthsToCalculate + 31;
    }else if(data.jan26!='0') {
        avgMonthsToCalculate = avgMonthsToCalculate + 30;
    }else if(data.jan26!='0') {
        avgMonthsToCalculate = avgMonthsToCalculate + 31;
    }
    final avgSteps = int.parse(data.total.toString()) / avgMonthsToCalculate;
    return avgSteps.toInt().toString();
  }
}
