import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wellnesswalkathon/data_constants/stepcount_data.dart';
import 'package:wellnesswalkathon/model/participent_data.dart';
import 'package:wellnesswalkathon/pages/user_detail.dart';
import 'package:wellnesswalkathon/style/text_style.dart';

class DashboardData extends StatefulWidget {
  const DashboardData({
    super.key,
    required this.selectedCode,
    required this.headerName,
    required this.totalWalkathonSteps,
    required this.hydTotalSteps,
    required this.blrTotalSteps,
  });
  final String selectedCode;
  final String headerName;
  final int totalWalkathonSteps;
  final int hydTotalSteps;
  final int blrTotalSteps;

  @override
  State<DashboardData> createState() => _DashboardDataState();
}

class _DashboardDataState extends State<DashboardData> {
  bool isIndiaSelected = true;
  bool isHydSelected = false;
  bool isBlrSelected = false;

  int selectedDataIndex = 0;

  int totalStepCount = 0;
  int hydStepCount = 0;
  int blrStepCount = 0;
  List<ParticipentData> userList = [];
  List<ParticipentData> filteredItems = [];
  List<ParticipentData> originalData = [];

  RxList<String> headersList = <String>[].obs;
  String monthFilterTag = '';

  bool isAllSelected = true;
  bool isMenSelected = false;
  bool isWomenSelected = false;
  String filter = 'A';

  // Use the controller
  final TextEditingController _controller = TextEditingController();

  /// 0 IND 1 HYD 2 BLR

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.headerName} Leaderboard',
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
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: TextField(
              autofocus: false,
              onChanged: filterList,
              controller: _controller,
              style: TextStyle(fontFamily: 'Barlow'),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.blue.shade50.withOpacity(1),
                hintText: 'Search...',
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.blueGrey,
                  size: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear, color: Colors.grey, size: 20),
                  onPressed: () {
                    _controller.clear();
                    FocusScope.of(context).unfocus(); // Dismiss the keyboard
                    setState(() {
                      filteredItems = userList;
                    });
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<ParticipentData>>(
              future: StepCountData().getLeaderStats(
                widget.selectedCode.toString(),
                filter,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No data found.'));
                }
                final data = snapshot.data!;
                if (_controller.text.isNotEmpty) {
                  filteredItems =
                      data
                          .where(
                            (participant) => participant.name!
                                .toLowerCase()
                                .contains(_controller.text.toLowerCase()),
                          )
                          .toList();
                } else {
                  filteredItems = data;
                }
                if (userList.isEmpty) {
                  userList = data;
                  filteredItems = userList;
                }
                // print('Filtered Items - ${filteredItems.length}');

                return ListView.builder(
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    final item = filteredItems[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          Get.to(
                            () => UserDetail(
                              participant: item,
                              totalSteps: widget.totalWalkathonSteps,
                              hyderabadSteps: widget.hydTotalSteps,
                              bangaloreSteps: widget.blrTotalSteps,
                              rank:
                                  item.rank != null ? int.parse(item.rank!) : 0,
                              participants: originalData,
                            ),
                            transition: Transition.rightToLeft,
                            duration: const Duration(milliseconds: 500),
                          );
                        },
                        child: Card(
                          color:
                              item.may!.isNotEmpty && item.may != '0'
                                  ? Colors.white
                                  : Colors.red.shade100,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 5,
                            ),
                            leading: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  widget.selectedCode == 'ALL'
                                      ? '${item.rank}'
                                      : item.avg != null
                                      ? '${item.avg}'
                                      : 'Unknown',
                                  style: AppTextStyles.subtitle.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: AppTextStyles.primaryBlue,
                                  ),
                                ),
                                SizedBox(width: 10),
                                CircleAvatar(
                                  backgroundColor:
                                      item.gender == 'Male'
                                          ? AppTextStyles.primaryBlue
                                          : Colors.red,
                                  child: Text(
                                    item.name != null && item.name!.isNotEmpty
                                        ? item.name![0].toUpperCase()
                                        : '?',
                                    style: TextStyle(
                                      fontFamily: 'Barlow',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            title: Text(
                              item.name != null && item.name!.isNotEmpty
                                  ? item.name!
                                  : 'Unknown',
                              style: AppTextStyles.subtitle.copyWith(
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                                color: AppTextStyles.primaryBlue,
                              ),
                            ),
                            subtitle: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppTextStyles().formatIndianNumber(
                                    int.parse(item.total ?? '0'),
                                  ),
                                  style: AppTextStyles.subtitle.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: AppTextStyles.primaryBlue,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.orange.shade400,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Colors.orange.shade400,
                                    ),
                                  ),
                                  child: Text(
                                    '${item.location}',
                                    style: AppTextStyles.body.copyWith(
                                      fontSize: 11,
                                      color: AppTextStyles.primaryBlue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5),
                              ],
                            ),
                            trailing: getGraphIcon(item),

                            // Text(
                            //   '#${item.rank}',
                            //   style: AppTextStyles.subtitle.copyWith(
                            //     fontWeight: FontWeight.bold,
                            //     fontSize: 14,
                            //     color: AppTextStyles.primaryBlue,
                            //   ),
                            // ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  initState() {
    super.initState();
  }

  void filterList(String query) {
    final results =
        userList.where((participant) {
          return participant.name!.toLowerCase().contains(query.toLowerCase());
        }).toList();

    setState(() {
      filteredItems = results;
    });
  }

  getGraphIcon(ParticipentData data) {
    int val = int.parse(data.up ?? '0');
    String curMonthVal = '';
    switch (DateTime.now().month) {
      case 4:
        curMonthVal = data.steps ?? '0';
        break;
      case 5:
        curMonthVal = data.apr ?? '0';
        break;
      case 6:
        curMonthVal = data.may ?? '0';
        break;
      case 7:
        curMonthVal = data.jun ?? '0';
        break;
      case 8:
        curMonthVal = data.jul ?? '0';
        break;
      case 9:
        curMonthVal = data.aug ?? '0';
        break;
      case 10:
        curMonthVal = data.sep ?? '0';
        break;
      default:
        curMonthVal = data.steps ?? '0';
    }
    if (curMonthVal == data.total.toString()) {
      return Text(
        'DEB',
        style: AppTextStyles.body.copyWith(
          fontSize: 16,
          color: AppTextStyles.secondaryBlue,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      if (val > 0) {
        return Image.asset('assets/images/trend_up.png', height: 25, width: 25);
      } else {
        return Image.asset(
          'assets/images/trend_down.png',
          height: 25,
          width: 25,
        );
      }
    }
  }
}
