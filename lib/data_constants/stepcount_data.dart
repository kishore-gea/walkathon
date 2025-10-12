import 'package:wellnesswalkathon/model/participent_data.dart';
import 'package:wellnesswalkathon/model/team_data.dart';

class StepCountData {
  static List<ParticipentData> originalData = [];
  static List<String> headersList = [];
  List<String> monthsForWalk = [
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
    'Jan',
    'Feb',
  ];

  final highestValue = 0;

  int monthlySubmissions(monthCode) {
    int count = 0;
    for (var data in originalData) {
      final monthValues = {
        3: data.steps,
        4: data.apr,
        5: data.may,
        6: data.jun,
        7: data.jul,
        8: data.aug,
        9: data.sep,
      };

      final value = monthValues[monthCode] ?? '0';

      if (int.parse(value) > 0 &&
          (data.location == 'HYD' || data.location == 'BLR')) {
        count++;
      }
    }
    return count;
  }

  int monthlySubmissionsLocationWise(monthCode, String location) {
    int count = 0;
    for (var data in originalData) {
      final monthValues = {
        3: data.steps,
        4: data.apr,
        5: data.may,
        6: data.jun,
        7: data.jul,
        8: data.aug,
        9: data.sep,
      };

      final value = monthValues[monthCode] ?? '0';

      if (int.parse(value) > 0 && data.location == location) {
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
          int marSteps = int.parse(data[i].steps.toString());
          final marAyvSteps = marSteps / 31;
          int aprSteps = int.parse(data[i].apr.toString());
          final aprAyvSteps = aprSteps / 30;
          int maySteps = int.parse(data[i].may.toString());
          final mayAvgSteps = maySteps / 31;
          int junSteps = int.parse(data[i].jun.toString());
          final junAvgSteps = junSteps / 30;
          int julSteps = int.parse(data[i].jul.toString());
          final julAvgSteps = julSteps / 31;
          int augSteps = int.parse(data[i].aug.toString());
          final augAvgSteps = augSteps / 31;
          int sepSteps = int.parse(data[i].sep.toString());
          final sepAvgSteps = sepSteps / 30;
          print(
              'Participant HYD CHECK : ${data[i].name} - $marAyvSteps, $aprAyvSteps, $mayAvgSteps, $junAvgSteps, $julAvgSteps, $augAvgSteps');
          if (marAyvSteps > 10000 &&
              aprAyvSteps > 10000 &&
              mayAvgSteps > 10000 &&
              junAvgSteps > 10000 &&
              julAvgSteps > 10000 &&
              augAvgSteps > 10000 &&
          sepAvgSteps > 10000) {
            participantStepCountData.add(data[i]);
            print('Participant HYD : ${data[i].name}');
          }

        }
      }
    } else if (code == '1B') {
      for (int i = 0; i < data.length; i++) {
        if (data[i].location == "BLR") {
          int marSteps = int.parse(data[i].steps.toString());
          final marAyvSteps = marSteps / 31;
          int aprSteps = int.parse(data[i].apr.toString());
          final aprAyvSteps = aprSteps / 30;
          int maySteps = int.parse(data[i].may.toString());
          final mayAvgSteps = maySteps / 31;
          int junSteps = int.parse(data[i].jun.toString());
          final junAvgSteps = junSteps / 30;
          int julSteps = int.parse(data[i].jul.toString());
          final julAvgSteps = julSteps / 31;
          int augSteps = int.parse(data[i].aug.toString());
          final augAvgSteps = augSteps / 31;
          int sepSteps = int.parse(data[i].sep.toString());
          final sepAvgSteps = sepSteps / 30;
          if (marAyvSteps > 10000 &&
              aprAyvSteps > 10000 &&
              mayAvgSteps > 10000 &&
              junAvgSteps > 10000 &&
              julAvgSteps > 10000 &&
              augAvgSteps > 10000 &&
          sepAvgSteps > 10000) {
            participantStepCountData.add(data[i]);
          }
        }
      }
    } else if (code == '2A') {
      for (int i = 0; i < data.length; i++) {
        if (data[i].location == "HYD") {
          int marSteps = int.parse(data[i].steps.toString());
          final marAyvSteps = marSteps / 31;
          int aprSteps = int.parse(data[i].apr.toString());
          final aprAyvSteps = aprSteps / 30;
          int maySteps = int.parse(data[i].may.toString());
          final mayAvgSteps = maySteps / 31;
          int junSteps = int.parse(data[i].jun.toString());
          final junAvgSteps = junSteps / 30;
          int julSteps = int.parse(data[i].jul.toString());
          final julAvgSteps = julSteps / 31;
          int augSteps = int.parse(data[i].aug.toString());
          final augAvgSteps = augSteps / 31;
          int sepSteps = int.parse(data[i].sep.toString());
          final sepAvgSteps = sepSteps / 30;
          if ((marAyvSteps > 7000 && marAyvSteps < 10000) ||
              (aprAyvSteps > 7000 && aprAyvSteps < 10000) ||
              (mayAvgSteps > 7000 && mayAvgSteps < 10000) ||
              (junAvgSteps > 7000 && junAvgSteps < 10000) ||
              (julAvgSteps > 7000 && julAvgSteps < 10000) ||
              (augAvgSteps > 7000 && augAvgSteps < 10000) ||
          (sepAvgSteps > 7000 && sepAvgSteps < 10000)) {
            if (aprAyvSteps > 7000 &&
                marAyvSteps > 7000 &&
                mayAvgSteps > 7000 &&
                junAvgSteps > 7000 &&
                julAvgSteps > 7000 &&
                augAvgSteps > 7000 &&
            sepAvgSteps > 7000) {
              participantStepCountData.add(data[i]);
            }
          }
        }
      }
    } else if (code == '2B') {
      for (int i = 0; i < data.length; i++) {
        if (data[i].location == "BLR") {
          int marSteps = int.parse(data[i].steps.toString());
          final marAyvSteps = marSteps / 31;
          int aprSteps = int.parse(data[i].apr.toString());
          final aprAyvSteps = aprSteps / 30;
          int maySteps = int.parse(data[i].may.toString());
          final mayAvgSteps = maySteps / 31;
          int junSteps = int.parse(data[i].jun.toString());
          final junAvgSteps = junSteps / 30;
          int julSteps = int.parse(data[i].jul.toString());
          final julAvgSteps = julSteps / 31;
          int augSteps = int.parse(data[i].aug.toString());
          final augAvgSteps = augSteps / 31;
          int sepSteps = int.parse(data[i].sep.toString());
          final sepAvgSteps = sepSteps / 30;
          if ((marAyvSteps > 7000 && marAyvSteps < 10000) ||
              (aprAyvSteps > 7000 && aprAyvSteps < 10000) ||
              (mayAvgSteps > 7000 && mayAvgSteps < 10000) ||
              (junAvgSteps > 7000 && junAvgSteps < 10000) ||
              (julAvgSteps > 7000 && julAvgSteps < 10000) ||
              (augAvgSteps > 7000 && augAvgSteps < 10000  ||
              (sepAvgSteps > 7000 && sepAvgSteps < 10000))) {
            if (aprAyvSteps > 7000 &&
                marAyvSteps > 7000 &&
                mayAvgSteps > 7000 &&
                junAvgSteps > 7000 &&
                julAvgSteps > 7000 &&
                augAvgSteps > 7000 &&
            sepAvgSteps > 7000) {
              participantStepCountData.add(data[i]);
            }
          }
        }
      }
    } else if (code == '3A') {
      for (int i = 0; i < data.length; i++) {
        if (data[i].location == "HYD") {
          int marSteps = int.parse(data[i].steps.toString());
          final marAyvSteps = marSteps / 31;
          int aprSteps = int.parse(data[i].apr.toString());
          final aprAyvSteps = aprSteps / 30;
          int maySteps = int.parse(data[i].may.toString());
          final mayAvgSteps = maySteps / 31;
          int junSteps = int.parse(data[i].jun.toString());
          final junAvgSteps = junSteps / 30;
          int julSteps = int.parse(data[i].jul.toString());
          final julAvgSteps = julSteps / 31;
          int augSteps = int.parse(data[i].aug.toString());
          final augAvgSteps = augSteps / 31;
          int sepSteps = int.parse(data[i].sep.toString());
          final sepAvgSteps = sepSteps / 30;
          if ((marAyvSteps > 5000 && marAyvSteps < 7000) ||
              (aprAyvSteps > 5000 && aprAyvSteps < 7000) ||
              (mayAvgSteps > 5000 && mayAvgSteps < 7000) ||
              (junAvgSteps > 5000 && junAvgSteps < 7000) ||
              (julAvgSteps > 5000 && julAvgSteps < 7000) ||
              (augAvgSteps > 5000 && augAvgSteps < 7000 ||
              (sepAvgSteps > 5000 && sepAvgSteps < 7000))) {
            if (aprAyvSteps > 5000 &&
                marAyvSteps > 5000 &&
                mayAvgSteps > 5000 &&
                junAvgSteps > 5000 &&
                julAvgSteps > 5000 &&
                augAvgSteps > 5000 &&
            sepAvgSteps > 5000) {
              participantStepCountData.add(data[i]);
            }
          }
        }
      }
    } else if (code == '3B') {
      for (int i = 0; i < data.length; i++) {
        if (data[i].location == "BLR") {
          int marSteps = int.parse(data[i].steps.toString());
          final marAyvSteps = marSteps / 31;
          int aprSteps = int.parse(data[i].apr.toString());
          final aprAyvSteps = aprSteps / 30;
          int maySteps = int.parse(data[i].may.toString());
          final mayAvgSteps = maySteps / 31;
          int junSteps = int.parse(data[i].jun.toString());
          final junAvgSteps = junSteps / 30;
          int julSteps = int.parse(data[i].jul.toString());
          final julAvgSteps = julSteps / 31;
          int augSteps = int.parse(data[i].aug.toString());
          final augAvgSteps = augSteps / 31;
          int sepSteps = int.parse(data[i].sep.toString());
          final sepAvgSteps = sepSteps / 30;
          if ((marAyvSteps > 5000 && marAyvSteps < 7000) ||
              (aprAyvSteps > 5000 && aprAyvSteps < 7000) ||
              (mayAvgSteps > 5000 && mayAvgSteps < 7000) ||
              (junAvgSteps > 5000 && junAvgSteps < 7000) ||
              (julAvgSteps > 5000 && julAvgSteps < 7000) ||
              (augAvgSteps > 5000 && augAvgSteps < 7000) ||
          (sepAvgSteps > 5000 && sepAvgSteps < 7000)) {
            if (aprAyvSteps > 5000 &&
                marAyvSteps > 5000 &&
                mayAvgSteps > 5000 &&
                junAvgSteps > 5000 &&
                julAvgSteps > 5000 &&
                augAvgSteps > 5000 &&
            sepAvgSteps > 5000) {
              participantStepCountData.add(data[i]);
            }
          }
        }
      }
    } else if (code == '5A') {
      for (int i = 0; i < data.length; i++) {
        if (data[i].location == "HYD") {
          int augSteps = int.parse(data[i].aug.toString());
          int sepSteps = int.parse(data[i].sep.toString());
          if ((sepSteps - augSteps) > 25000) {
            if (sepSteps > 0 && augSteps > 0) {
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
          int augSteps = int.parse(data[i].aug.toString());
          int sepSteps = int.parse(data[i].sep.toString());
          if ((sepSteps - augSteps) > 25000) {
            if (sepSteps > 0 && augSteps > 0) {
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
      for (int i = 0; i < data.length; i++) {
        var location = data[i].location?.toString().trim().toUpperCase();
        var maySteps = int.tryParse(data[i].sep.toString().trim()) ?? 0;

        if (location == "HYD" && maySteps != 0) {
          participantStepCountData.add(data[i]);
          // print('Adding data: ${data[i].name} with May steps: ${data[i].may}');
        }
      }

      participantStepCountData.sort((a, b) {
        int aVal = int.tryParse(a.sep.toString().trim()) ?? 0;
        int bVal = int.tryParse(b.sep.toString().trim()) ?? 0;
        return bVal.compareTo(aVal);
      });
    } else if (code == '6B') {
      for (int i = 0; i < data.length; i++) {
        if (data[i].location == "BLR") {
          if (data[i].sep != '0') {
            participantStepCountData.add(data[i]);
          }
        }
      }
      //Sort based in apr stepcount
      participantStepCountData.sort((a, b) {
        int aVal = int.parse(a.sep.toString());
        int bVal = int.parse(b.sep.toString());
        return bVal.compareTo(aVal);
      });
    } else if (code == '6C') {
      for (int i = 0; i < data.length; i++) {
        if (data[i].sep != '0') {
          participantStepCountData.add(data[i]);
        }
      }
      //Sort based in apr stepcount
      participantStepCountData.sort((a, b) {
        int aApr = int.parse(a.sep.toString());
        int bApr = int.parse(b.sep.toString());
        return bApr.compareTo(aApr);
      });
    } else if (code == 'RL') {
      for (int i = 0; i < data.length; i++) {
        int stepsAPR = int.parse(data[i].apr.toString());
        int stepsMAR = int.parse(data[i].steps.toString());
        int stepsMAY = int.parse(data[i].may.toString());
        int stepsJUNE = int.parse(data[i].jun.toString());
        int stepsJULY = int.parse(data[i].jul.toString());
        int stepsAUG = int.parse(data[i].aug.toString());
        int stepsSEP = int.parse(data[i].sep.toString());

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
        if(totalSteps == latestMonthSteps){
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
        locationCount += int.parse(originalData[i].total.toString());
      }
    }
    // print('Location Count: $code $locationCount');

    return locationCount;
  }

  int getLatestMonthSteps(ParticipentData data) {
    int currentMonthCode = DateTime.now().month;
    final monthValues = {
      3: data.steps,
      4: data.apr,
      5: data.may,
      6: data.jun,
      7: data.jul,
      8: data.aug,
      9: data.sep,
    };
    /// get current month steps
   return int.parse(monthValues[currentMonthCode - 1] ?? '0');
  }
}
