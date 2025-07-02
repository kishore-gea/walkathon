import 'package:wellnesswalkathon/model/participent_data.dart';

class TeamData {
  String? name;
  String? total;
  List<ParticipentData>? members;

  TeamData({this.name, this.total, this.members});

  TeamData.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    total = json['Total'];
    if (json['Members'] != null) {
      members = <ParticipentData>[];
      json['Members'].forEach((v) {
        members!.add(ParticipentData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Name'] = name;
    data['Total'] = total;
    if (members != null) {
      data['Members'] = members!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
