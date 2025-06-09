import 'package:wellnesswalkathon/model/participent_data.dart';

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

  /// Method that helps to show the walkathon stats based on the selected option
  /// 1A - 10k AVG [Location -HYD]
  /// 1B - 10k AVG [Location -BLR]

  Future<List<ParticipentData>> getLeaderStats(
    String code,
    String filter,
  ) async {
    List<ParticipentData> participantStepCountData = [];
    print("Walkathon Stats: ${StepCountData.originalData.length}");
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
          if (marAyvSteps > 10000 &&
              aprAyvSteps > 10000 &&
              mayAvgSteps > 10000) {
            participantStepCountData.add(data[i]);
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
          if (marAyvSteps > 10000 &&
              aprAyvSteps > 10000 &&
              mayAvgSteps > 10000) {
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
          if ((marAyvSteps > 7000 && marAyvSteps < 10000) ||
              (aprAyvSteps > 7000 && aprAyvSteps < 10000) ||
              (mayAvgSteps > 7000 && mayAvgSteps < 10000)) {
            if (aprAyvSteps > 7000 &&
                marAyvSteps > 7000 &&
                mayAvgSteps > 7000) {
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
          if ((marAyvSteps > 7000 && marAyvSteps < 10000) ||
              (aprAyvSteps > 7000 && aprAyvSteps < 10000) ||
              (mayAvgSteps > 7000 && mayAvgSteps < 10000)) {
            if (aprAyvSteps > 7000 &&
                marAyvSteps > 7000 &&
                mayAvgSteps > 7000) {
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
          if ((marAyvSteps > 5000 && marAyvSteps < 7000) ||
              (aprAyvSteps > 5000 && aprAyvSteps < 7000) ||
              (mayAvgSteps > 5000 && mayAvgSteps < 7000)) {
            if (aprAyvSteps > 5000 &&
                marAyvSteps > 5000 &&
                mayAvgSteps > 5000) {
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
          if ((marAyvSteps > 5000 && marAyvSteps < 7000) ||
              (aprAyvSteps > 5000 && aprAyvSteps < 7000) ||
              (mayAvgSteps > 5000 && mayAvgSteps < 7000)) {
            if (aprAyvSteps > 5000 &&
                marAyvSteps > 5000 &&
                mayAvgSteps > 5000) {
              participantStepCountData.add(data[i]);
            }
          }
        }
      }
    } else if (code == '5A') {
      for (int i = 0; i < data.length; i++) {
        if (data[i].location == "HYD") {
          int marSteps = int.parse(data[i].apr.toString());
          int aprSteps = int.parse(data[i].may.toString());
          if ((aprSteps - marSteps) > 25000) {
            if (aprSteps > 25000 && marSteps > 25000) {
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
          int marSteps = int.parse(data[i].apr.toString());
          int aprSteps = int.parse(data[i].may.toString());
          if ((aprSteps - marSteps) > 25000) {
            if (aprSteps > 25000 && marSteps > 25000) {
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
    } else if (code == '6A') {
      for (int i = 0; i < data.length; i++) {
        var location = data[i].location?.toString()?.trim()?.toUpperCase();
        var maySteps = int.tryParse(data[i].may.toString().trim()) ?? 0;

        if (location == "HYD" && maySteps != 0) {
          participantStepCountData.add(data[i]);
          print('Adding data: ${data[i].name} with May steps: ${data[i].may}');
        }
      }

      participantStepCountData.sort((a, b) {
        int aVal = int.tryParse(a.may.toString().trim()) ?? 0;
        int bVal = int.tryParse(b.may.toString().trim()) ?? 0;
        return bVal.compareTo(aVal);
      });
    } else if (code == '6B') {
      for (int i = 0; i < data.length; i++) {
        if (data[i].location == "BLR") {
          if (data[i].may != '0') {
            participantStepCountData.add(data[i]);
          }
        }
      }
      //Sort based in apr stepcount
      participantStepCountData.sort((a, b) {
        int aVal = int.parse(a.may.toString());
        int bVal = int.parse(b.may.toString());
        return bVal.compareTo(aVal);
      });
    } else if (code == '6C') {
      participantStepCountData.addAll(data);
      //Sort based in apr stepcount
      participantStepCountData.sort((a, b) {
        int aApr = int.parse(a.may.toString());
        int bApr = int.parse(b.may.toString());
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
    print('Highest Value: $highestValue');
    return highestValue;
  }

  Future<int> getLocationWiseDataCount(String code) async {
    //HYD- Hyderabad
    //BLR- Bangalore
    int locationCount = 0;

    print('Original Data: ${originalData.length}');
    for (int i = 0; i < originalData.length; i++) {
      print('Location: ${originalData[i].location}');
      if (originalData[i].location == code) {
        locationCount += int.parse(originalData[i].total.toString());
      }
    }
    print('Location Count: $code $locationCount');

    return locationCount;
  }
}
