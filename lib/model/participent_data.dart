class ParticipentData {
  String? name;
  String? steps;
  String? location;
  String? gender;
  String? rank;
  String? apr;
  String? may;
  String? jun;
  String? jul;
  String? aug;
  String? sep;
  String? total;
  String? avg;
  String? up;
  String? awards;

  ParticipentData({this.name, this.steps, this.location, this.gender});

  ParticipentData.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    steps = json['Mar'] ?? '0';
    apr = json['Apr'] ?? '0';
    may = json['May'] ?? '0';
    jun = json['Jun'] ?? '0';
    jul = json['Jul'] ?? '0';
    aug = json['Aug'] ?? '0';
    sep = json['Sep'] ?? '0';
    total = json['Total'];
    avg = json['AVG'];
    location = json['Location'];
    gender = json['Gender'];
    rank = json['Rank'];
    up = json['UP'];
    awards = json['HIS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Name'] = name;
    data['Mar'] = steps;
    data['Apr'] = apr;
    data['May'] = may;
    data['Jun'] = jun;
    data['Jul'] = jul;
    data['Aug'] = aug;
    data['Sep'] = sep;
    data['Total'] = total;
    data['AVG'] = avg;
    data['Location'] = location;
    data['Gender'] = gender;
    data['Rank'] = rank;
    data['UP'] = up;
    data['HIS'] = awards;
    return data;
  }
}
