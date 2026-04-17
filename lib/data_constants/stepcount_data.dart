import 'package:wellnesswalkathon/model/participent_data.dart';
import 'package:wellnesswalkathon/model/team_data.dart';

class StepCountData {
  static List<ParticipentData> originalData = [];
  static List<String> headersList = [];

  /// Season 1: Mar'25(3) → Feb'26(14)
  /// Season 2: Mar'26(15) → May'26(17)
  static const List<Map<String, Object>> season1Months = [
    {'name': 'Mar', 'label': 'MAR 2025', 'code': 3,  'days': 31},
    {'name': 'Apr', 'label': 'APR 2025', 'code': 4,  'days': 30},
    {'name': 'May', 'label': 'MAY 2025', 'code': 5,  'days': 31},
    {'name': 'Jun', 'label': 'JUN 2025', 'code': 6,  'days': 30},
    {'name': 'Jul', 'label': 'JUL 2025', 'code': 7,  'days': 31},
    {'name': 'Aug', 'label': 'AUG 2025', 'code': 8,  'days': 31},
    {'name': 'Sep', 'label': 'SEP 2025', 'code': 9,  'days': 30},
    {'name': 'Oct', 'label': 'OCT 2025', 'code': 10, 'days': 31},
    {'name': 'Nov', 'label': 'NOV 2025', 'code': 11, 'days': 30},
    {'name': 'Dec', 'label': 'DEC 2025', 'code': 12, 'days': 31},
    {'name': 'Jan', 'label': 'JAN 2026', 'code': 13, 'days': 31},
    {'name': 'Feb', 'label': 'FEB 2026', 'code': 14, 'days': 28},
  ];

  static const List<Map<String, Object>> season2Months = [
    {'name': 'Mar26', 'label': 'MAR 2026', 'code': 15, 'days': 31},
    {'name': 'Apr26', 'label': 'APR 2026', 'code': 16, 'days': 30},
    {'name': 'May26', 'label': 'MAY 2026', 'code': 17, 'days': 31},
  ];

  /// Returns all months for a given season (1 or 2)
  static List<Map<String, Object>> getSeasonMonths(int season) =>
      season == 1 ? season1Months : season2Months;

  /// Determines the current season based on date
  static int get currentSeason {
    final now = DateTime.now();
    if (now.year == 2026 && now.month >= 3) return 2;
    return 1;
  }

  /// Returns the current month code
  static int get currentMonthCode {
    final now = DateTime.now();
    if (now.year == 2026) {
      if (now.month == 1) return 13;
      if (now.month == 2) return 14;
      if (now.month == 3) return 15;
      if (now.month == 4) return 16;
      if (now.month == 5) return 17;
    }
    return now.month; // 3–12 for 2025
  }

  /// Get field value from a participant by month code
  static String getMonthValue(ParticipentData data, int code) {
    switch (code) {
      case 3:  return data.mar  ?? '0';
      case 4:  return data.apr    ?? '0';
      case 5:  return data.may    ?? '0';
      case 6:  return data.jun    ?? '0';
      case 7:  return data.jul    ?? '0';
      case 8:  return data.aug    ?? '0';
      case 9:  return data.sep    ?? '0';
      case 10: return data.oct    ?? '0';
      case 11: return data.nov    ?? '0';
      case 12: return data.dec    ?? '0';
      case 13: return data.jan26  ?? '0';
      case 14: return data.feb26  ?? '0';
      case 15: return data.mar26  ?? '0';
      case 16: return data.apr26  ?? '0';
      case 17: return data.may26  ?? '0';
      default: return '0';
    }
  }

  List<String> monthsForWalk = [
    'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep',
    'Oct', 'Nov', 'Dec', 'Jan', 'Feb',
    'Mar26', 'Apr26', 'May26',
  ];

  final highestValue = 0;

  int monthlySubmissions(int monthCode) {
    int count = 0;
    for (var data in originalData) {
      final value = getMonthValue(data, monthCode);
      if (int.tryParse(value) != null &&
          int.parse(value) > 0 &&
          (data.location == 'HYD' || data.location == 'BLR')) {
        count++;
      }
    }
    return count;
  }

  int monthlySubmissionsLocationWise(int monthCode, String location) {
    print('monthCode : $monthCode, location: $location');
    int count = 0;
    for (var data in originalData) {
      final value = getMonthValue(data, monthCode);
      if (int.tryParse(value) != null &&
          int.parse(value) > 0 &&
          data.location == location) {
        count++;
      }
    }
    return count;
  }

  /// Method that helps to show the walkathon stats based on the selected option
  /// 1A - 10k AVG [Location -HYD]
  /// 1B - 10k AVG [Location -BLR]

  Future<List<TeamData>> getTeamData() async {
    var data = StepCountData.originalData;
    // Extract team names
    Set<String> teamNames =
    data
        .map((entry) => entry.teams.toString().split('-').last.trim())
        .toSet();

    List<TeamData> teamData = [];

    for (int t = 0; t <= teamNames.length - 1; t++) {
      int count = 0;
      List<ParticipentData> teamMembers = [];
      for (int i = 0; i < data.length; i++) {
        if (data[i].teams == teamNames.elementAt(t)) {
          count += int.parse(data[i].total.toString());
          teamMembers.add(data[i]);
          // data.removeAt(i);
        }
      }
      if (teamMembers.isNotEmpty) {
        teamData.add(
          TeamData(
            name: teamNames.elementAt(t),
            total: count.toString(),
            members: teamMembers,
          ),
        );
      }
    }


    // Sort teams based on total steps in descending order
    teamData.sort((a, b) => int.parse(b.total.toString())
        .compareTo(int.parse(a.total.toString())));

    return teamData;
  }

  Future<List<ParticipentData>> getLeaderStats(
      String code,
      String filter,
      ) async {
    print('Code : $code, Filter: $filter');
    List<ParticipentData> participantStepCountData = [];
    // print("Walkathon Stats: ${StepCountData.originalData.length}");
    var data = StepCountData.originalData;
    if (code == 'HYD') {
      data =
          StepCountData.originalData
              .where((element) => element.location == 'HYD')
              .toList();
      participantStepCountData.addAll(data);
      for (int i = 0; i < data.length; i++) {
        participantStepCountData[i].avg = '${i + 1}';
      }
    } else if (code == 'BLR') {
      data =
          StepCountData.originalData
              .where((element) => element.location == 'BLR')
              .toList();
      participantStepCountData.addAll(data);
      for (int i = 0; i < data.length; i++) {
        participantStepCountData[i].avg = '${i + 1}';
      }
    } else if (code == 'ALL') {
      data = StepCountData.originalData;
      participantStepCountData.addAll(data);
    } else if (code == '1A') {
      for (int i = 0; i < data.length; i++) {
        if (data[i].location == "HYD") {
          // int marSteps = int.parse(data[i].mar.toString());
          // final marAyvSteps = marSteps / 31;
          // int aprSteps = int.parse(data[i].apr.toString());
          // final aprAyvSteps = aprSteps / 30;
          // int maySteps = int.parse(data[i].may.toString());
          // final mayAvgSteps = maySteps / 31;
          // int junSteps = int.parse(data[i].jun.toString());
          // final junAvgSteps = junSteps / 30;
          // int julSteps = int.parse(data[i].jul.toString());
          // final julAvgSteps = julSteps / 31;
          // int augSteps = int.parse(data[i].aug.toString());
          // final augAvgSteps = augSteps / 31;
          // int sepSteps = int.parse(data[i].sep.toString());
          // final sepAvgSteps = sepSteps / 30;
          // int octSteps = int.parse(data[i].oct.toString());
          // final octAvgSteps = octSteps / 31;
          // print(
          //     'Participant HYD CHECK : ${data[i].name} - $marAyvSteps, $aprAyvSteps, $mayAvgSteps, $junAvgSteps, $julAvgSteps, $augAvgSteps');
          // if (marAyvSteps > 10000 &&
          //     aprAyvSteps > 10000 &&
          //     mayAvgSteps > 10000 &&
          //     junAvgSteps > 10000 &&
          //     julAvgSteps > 10000 &&
          //     augAvgSteps > 10000 &&
          //     sepAvgSteps > 10000 &&
          //     octAvgSteps >10000) {
          //   participantStepCountData.add(data[i]);
          //   print('Participant HYD : ${data[i].name}');
          // }
          if(getAvgValue(data[i]) >= 10000) {
            print('DATA HYD CHECK: ${data[i].toJson()} ');
            participantStepCountData.add(data[i]);
          }

        }
      }
    } else if (code == '1B') {
      for (int i = 0; i < data.length; i++) {
        if (data[i].location == "BLR") {
          // int marSteps = int.parse(data[i].mar.toString());
          // final marAyvSteps = marSteps / 31;
          // int aprSteps = int.parse(data[i].apr.toString());
          // final aprAyvSteps = aprSteps / 30;
          // int maySteps = int.parse(data[i].may.toString());
          // final mayAvgSteps = maySteps / 31;
          // int junSteps = int.parse(data[i].jun.toString());
          // final junAvgSteps = junSteps / 30;
          // int julSteps = int.parse(data[i].jul.toString());
          // final julAvgSteps = julSteps / 31;
          // int augSteps = int.parse(data[i].aug.toString());
          // final augAvgSteps = augSteps / 31;
          // int sepSteps = int.parse(data[i].sep.toString());
          // final sepAvgSteps = sepSteps / 30;
          // int octSteps = int.parse(data[i].oct.toString());
          // final octAvgSteps = octSteps / 31;
          // if (marAyvSteps > 10000 &&
          //     aprAyvSteps > 10000 &&
          //     mayAvgSteps > 10000 &&
          //     junAvgSteps > 10000 &&
          //     julAvgSteps > 10000 &&
          //     augAvgSteps > 10000 &&
          //     sepAvgSteps > 10000 &&
          // octAvgSteps >10000) {
          //   participantStepCountData.add(data[i]);
          // }
          if(getAvgValue(data[i]) >= 10000) {
            print('DATA BLR: ${data[i].name} - ${data[i].avg}');
            participantStepCountData.add(data[i]);
          }
        }
      }
    } else if (code == '2A') {
      for (int i = 0; i < data.length; i++) {
        if (data[i].location == "HYD") {
          int avgVal = getAvgValue(data[i]);
          if (avgVal >= 7000 &&
              avgVal < 10000) {
            participantStepCountData.add(data[i]);
          }
        }
      }
    } else if (code == '2B') {
      for (int i = 0; i < data.length; i++) {
        if (data[i].location == "BLR") {
          int avgVal = getAvgValue(data[i]);
          if (avgVal >= 7000 &&
              avgVal < 10000) {
            print('DATA BLR: ${data[i].name} - ${data[i].avg}');
            participantStepCountData.add(data[i]);
          }
        }
      }
    } else if (code == '3A') {
      for (int i = 0; i < data.length; i++) {
        if (data[i].location == "HYD") {
          int avgVal = getAvgValue(data[i]);
          if (avgVal >= 5000 &&
              avgVal < 7000 ) {
            participantStepCountData.add(data[i]);
          }
        }
      }
    } else if (code == '3B') {
      for (int i = 0; i < data.length; i++) {
        if (data[i].location == "BLR") {
          int avgVal = getAvgValue(data[i]);
          if (avgVal >= 5000 && avgVal < 7000 ) {
            participantStepCountData.add(data[i]);
          }
        }
      }
    } else if (code == '5A') {
      for (int i = 0; i < data.length; i++) {
        if (data[i].location == "HYD") {
          int janStep = int.parse(data[i].jan26.toString());
          int decStep = int.parse(data[i].dec.toString());
          if ((janStep - decStep) > 25000) {
            if (decStep > 0 && janStep > 0) {
              print('25K HYD: ${data[i].name} - Jan: ${data[i].jan26}, Dec: ${data[i].dec}');
              participantStepCountData.add(data[i]);
            }
          }
        }
      }
      //Sort based on UP value
      participantStepCountData.sort((a, b) {
        int aUp = int.parse(a.up.toString());
        int bUp = int.parse(b.up.toString());
        return bUp.compareTo(aUp);
      });
    } else if (code == '5B') {
      for (int i = 0; i < data.length; i++) {
        if (data[i].location == "BLR") {
          int octSteps = int.parse(data[i].dec.toString());
          int novSteps = int.parse(data[i].jan26.toString());
          if ((novSteps - octSteps) > 25000) {
            if (novSteps > 0 && octSteps > 0) {
              participantStepCountData.add(data[i]);
            }
          }
        }
      }
      participantStepCountData.sort((a, b) {
        int aUp = int.parse(a.up.toString());
        int bUp = int.parse(b.up.toString());
        return bUp.compareTo(aUp);
      });
    } else if (code == '6AA') {
      for (int i = 0; i < data.length; i++) {
        var location = data[i].location?.toString().trim().toUpperCase();
        var maySteps = int.tryParse(data[i].apr.toString().trim()) ?? 0;

        if (location == "HYD" && maySteps != 0) {
          participantStepCountData.add(data[i]);
          // print('Adding data: ${data[i].name} with May steps: ${data[i].may}');
        }
      }

      participantStepCountData.sort((a, b) {
        int aVal = int.tryParse(a.apr.toString().trim()) ?? 0;
        int bVal = int.tryParse(b.apr.toString().trim()) ?? 0;
        return bVal.compareTo(aVal);
      });
    } else if (code == '6BB') {
      for (int i = 0; i < data.length; i++) {
        var location = data[i].location?.toString().trim().toUpperCase();
        var maySteps = int.tryParse(data[i].apr.toString().trim()) ?? 0;

        if (location == "BLR" && maySteps != 0) {
          participantStepCountData.add(data[i]);
          // print('Adding data: ${data[i].name} with May steps: ${data[i].may}');
        }
      }

      participantStepCountData.sort((a, b) {
        int aVal = int.tryParse(a.apr.toString().trim()) ?? 0;
        int bVal = int.tryParse(b.apr.toString().trim()) ?? 0;
        return bVal.compareTo(aVal);
      });
    } else if (code == '6A') {
      /// Current Month -1 Steps
      for (int i = 0; i < data.length; i++) {
        print('DATA CHECK: ${data[i].name} - Mar26: ${data[i].mar26}, Location: ${data[i].location}');
        var location = data[i].location?.toString().trim().toUpperCase();
        var decSteps = int.tryParse(data[i].mar26.toString().trim()) ?? 0;

        if (location == "HYD" && decSteps != 0) {
          participantStepCountData.add(data[i]);
          // print('Adding data: ${data[i].name} with May steps: ${data[i].may}');
        }
      }

      participantStepCountData.sort((a, b) {
        int aVal = int.tryParse(a.mar26.toString().trim()) ?? 0;
        int bVal = int.tryParse(b.mar26.toString().trim()) ?? 0;
        return bVal.compareTo(aVal);
      });
    } else if (code == '6B') {
      for (int i = 0; i < data.length; i++) {
        var location = data[i].location?.toString().trim().toUpperCase();
        var decSteps = int.tryParse(data[i].mar26.toString().trim()) ?? 0;

        if (location == "BLR" && decSteps != 0) {
          participantStepCountData.add(data[i]);
        }
      }
      print('BLE Participants Count: ${participantStepCountData.length}');
      //Sort based in apr stepcount
      participantStepCountData.sort((a, b) {
        int aVal = int.parse(a.mar26.toString());
        int bVal = int.parse(b.mar26.toString());
        return bVal.compareTo(aVal);
      });
    } else if (code == '6C') {
      for (int i = 0; i < data.length; i++) {
        if (data[i].mar26 != '0') {
          participantStepCountData.add(data[i]);
        }
      }
      //Sort based in apr stepcount
      participantStepCountData.sort((a, b) {
        int aApr = int.parse(a.mar26.toString());
        int bApr = int.parse(b.mar26.toString());
        return bApr.compareTo(aApr);
      });
    } else if (code == 'RL') {
      for (int i = 0; i < data.length; i++) {
        int stepsAPR = int.parse(data[i].apr.toString());
        int stepsMAR = int.parse(data[i].mar.toString());
        int stepsMAY = int.parse(data[i].may.toString());
        int stepsJUNE = int.parse(data[i].jun.toString());
        int stepsJULY = int.parse(data[i].jul.toString());
        int stepsAUG = int.parse(data[i].aug.toString());
        int stepsSEP = int.parse(data[i].sep.toString());
        int stepsOCT = int.parse(data[i].oct.toString());
        int stepsNOV = int.parse(data[i].nov.toString());

        if (DateTime.now().month == 4) {
          participantStepCountData.add(data[i]);
        } else if (DateTime.now().month == 5) {
          if (stepsMAR > 0 && stepsAPR > 0) {
            participantStepCountData.add(data[i]);
          }
          stepsAPR = 0;
        } else if (DateTime.now().month == 6) {
          if (stepsMAR > 0 && stepsAPR > 0 && stepsMAY > 0) {
            participantStepCountData.add(data[i]);
          }
          stepsMAY = 0;
        } else if (DateTime.now().month == 7) {
          if (stepsMAR > 0 && stepsAPR > 0 && stepsMAY > 0 && stepsJUNE > 0) {
            participantStepCountData.add(data[i]);
          }
          stepsJUNE = 0;
        } else if (DateTime.now().month == 8) {
          if (stepsMAR > 0 &&
              stepsAPR > 0 &&
              stepsMAY > 0 &&
              stepsJUNE > 0 &&
              stepsJULY > 0) {
            participantStepCountData.add(data[i]);
          }
          stepsJULY = 0;
        } else if (DateTime.now().month == 9) {
          if (stepsMAR > 0 &&
              stepsAPR > 0 &&
              stepsMAY > 0 &&
              stepsJUNE > 0 &&
              stepsJULY > 0 &&
              stepsAUG > 0) {
            participantStepCountData.add(data[i]);
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
            participantStepCountData.add(data[i]);
          }
          stepsSEP = 0;
        }
        else if (DateTime.now().month == 11) {
          if (stepsMAR > 0 &&
              stepsAPR > 0 &&
              stepsMAY > 0 &&
              stepsJUNE > 0 &&
              stepsJULY > 0 &&
              stepsAUG > 0 &&
              stepsSEP > 0 &&
              stepsOCT > 0) {
            participantStepCountData.add(data[i]);
          }
          stepsOCT = 0;
        }else if (DateTime.now().month == 12) {
          if (stepsMAR > 0 &&
              stepsAPR > 0 &&
              stepsMAY > 0 &&
              stepsJUNE > 0 &&
              stepsJULY > 0 &&
              stepsAUG > 0 &&
              stepsSEP > 0 &&
              stepsOCT > 0 &&
              stepsNOV > 0) {
            participantStepCountData.add(data[i]);
          }
          stepsNOV = 0;
        }
      }
      participantStepCountData.sort((a, b) {
        int aSteps = int.parse(a.total.toString());
        int bSteps = int.parse(b.total.toString());
        return bSteps.compareTo(aSteps);
      });
      // participantStepCountData = participantStepCountData.sublist(0, 35);
    }else if (code == '7A'){
      for (int i = 0; i < data.length; i++) {
        int totalSteps = int.parse(data[i].total.toString());
        int latestMonthSteps = getLatestMonthSteps(data[i]);
        print('latestMonthSteps ${data[i].name} ::: $latestMonthSteps $totalSteps');
        if(totalSteps == latestMonthSteps && totalSteps >0){
          participantStepCountData.add(data[i]);
        }
      }
      print('Debutants - ${participantStepCountData.length}');
    }

    String filterVal = 'A';
    if (filter == 'M') {
      filterVal = 'Male';
    } else if (filter == 'F') {
      filterVal = 'Female';
    }
    List<ParticipentData> filteredData = [];

    /// Filter the data based on the selected filter with gender
    if (filterVal != 'A') {
      for (int i = 0; i < participantStepCountData.length; i++) {
        if (participantStepCountData[i].gender == filterVal) {
          filteredData.add(participantStepCountData[i]);
        }
      }
      participantStepCountData.clear();
      participantStepCountData.addAll(filteredData);
    }

    return participantStepCountData;
  }

  Future<List<ParticipentData>> getTeamWiseData() async {
    var data = StepCountData.originalData;
    List<ParticipentData> teamWiseData = [];
    for (int i = 0; i < data.length; i++) {
      /// sort based on teams
      if (data[i].teams != null && data[i].teams != '0') {
        teamWiseData.add(data[i]);
      }
    }
    /// Sort based on teams data
    teamWiseData = teamWiseData
        .where((item) => int.tryParse(item.teams.toString()) != null && int.parse(item.teams.toString()) > 0)
        .toList();

    print('teamWiseData Length: ${teamWiseData.length}');

    teamWiseData.sort((a, b) {
      return int.parse(a.teams.toString()).compareTo(int.parse(b.teams.toString()));
    });


    return teamWiseData;
  }

  int getHighestValueOfWalkathon() {
    int highestValue = 0;
    for (int i = 0; i < originalData.length; i++) {
      int totalSteps = int.parse(originalData[i].total.toString());
      if (totalSteps > highestValue) {
        highestValue = totalSteps;
      }
    }
    // print('Highest Value: $highestValue');
    return highestValue;
  }

  Future<int> getLocationWiseDataCount(String code) async {
    //HYD- Hyderabad
    //BLR- Bangalore
    int locationCount = 0;

    // print('Original Data: ${originalData.length}');
    for (int i = 0; i < originalData.length; i++) {
      // print('Location: ${originalData[i].location}');
      if (originalData[i].location == code) {
        locationCount += int.parse(originalData[i].total.toString() ?? '0');
      }
    }
    // print('Location Count: $code $locationCount');

    return locationCount;
  }

  int getLatestMonthSteps(ParticipentData data) {
    final code = StepCountData.currentMonthCode;
    print('currentMonthCode : $code');
    final val = StepCountData.getMonthValue(data, code);
    print('Latest Month Steps for ${data.name} : $val');
    return int.tryParse(val) ?? 0;
  }

  bool checkIfAllMonthsSubmitted(ParticipentData data) {
    final endCode = StepCountData.currentMonthCode - 1;
    final startCode = StepCountData.currentSeason == 2 ? 15 : 3;
    for (int code = startCode; code <= endCode; code++) {
      if ((int.tryParse(StepCountData.getMonthValue(data, code)) ?? 0) == 0) {
        return false;
      }
    }
    return true;
  }

  int getAvgValue(ParticipentData data) {
    int avgMonthsToCalculate = 0;
    print('Value :: ${data.name} - ${data.mar}, ${data.apr}, ${data.may}, ${data.jun}, ${data.jul}, ${data.aug}, ${data.sep}, ${data.oct}, ${data.nov}, ${data.dec}');

    // Season 1
    if (data.mar != '0') avgMonthsToCalculate += 31;
    if (data.apr != '0')   avgMonthsToCalculate += 30;
    if (data.may != '0')   avgMonthsToCalculate += 31;
    if (data.jun != '0')   avgMonthsToCalculate += 30;
    if (data.jul != '0')   avgMonthsToCalculate += 31;
    if (data.aug != '0')   avgMonthsToCalculate += 31;
    if (data.sep != '0')   avgMonthsToCalculate += 30;
    if (data.oct != '0')   avgMonthsToCalculate += 31;
    if (data.nov != '0')   avgMonthsToCalculate += 30;
    if (data.dec != '0')   { avgMonthsToCalculate += 31; print('DEC ADDED'); }
    if (data.jan26 != '0') { avgMonthsToCalculate += 31; print('JAN26 ADDED'); }
    if (data.feb26 != '0') { avgMonthsToCalculate += 28; print('FEB26 ADDED'); }
    // Season 2
    if (data.mar26 != '0') { avgMonthsToCalculate += 31; print('MAR26 ADDED'); }
    // if (data.apr26 != '0') { avgMonthsToCalculate += 30; print('APR26 ADDED'); }
    // if (data.may26 != '0') { avgMonthsToCalculate += 31; print('MAY26 ADDED'); }

    int totalVal = int.tryParse(data.total.toString()) ?? 0;
    final avgSteps = (totalVal > 0 && avgMonthsToCalculate > 0)
        ? totalVal / avgMonthsToCalculate
        : 0;
    print('CHECK --> ${data.name} - $avgSteps  ${data.total} $avgMonthsToCalculate');
    return avgSteps.toInt();
  }

  int checkNoOfSubmissions(ParticipentData data, String? name) {
    int count = 0;
    for (var p in originalData) {
      for (int code = 3; code <= 17; code++) {
        final value = StepCountData.getMonthValue(p, code);
        if ((int.tryParse(value) ?? 0) > 0 && p.name == name) {
          count++;
        }
      }
    }
    print('Total Submissions : $count');
    return count;
  }
}
