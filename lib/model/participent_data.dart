class ParticipentData {
  String? name;
  String? mar;
  String? location;
  String? gender;
  String? rank;
  String? apr;
  String? may;
  String? jun;
  String? jul;
  String? aug;
  String? sep;
  String? oct;
  String? nov;
  String? dec;
  String? jan26;
  String? feb26;
  String? mar26;
  String? apr26;
  String? may26;
  String? total;
  String? avg;
  String? up;
  String? awards;
  String? teams;
  String? teamName;

  ParticipentData({this.name, this.mar, this.location, this.gender});

  ParticipentData.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    mar = json['Mar'] ?? '0';
    apr = json['Apr'] ?? '0';
    may = json['May'] ?? '0';
    jun = json['Jun'] ?? '0';
    jul = json['Jul'] ?? '0';
    aug = json['Aug'] ?? '0';
    sep = json['Sept'] ?? '0';
    oct = json['Oct'] ?? '0';
    nov = json['Nov'] ?? '0';
    dec = json['Dec'] ?? '0';
    jan26 = json['Jan26'] ?? '0';
    feb26 = json['Feb26'] ?? '0';
    mar26 = json['Mar26'] ?? '0';
    apr26 = json['Apr26'] ?? '0';
    may26 = json['May26'] ?? '0';
    total = json['Total'] ?? '0';
    avg = json['AVG'] ?? '0';
    location = json['Location'];
    gender = json['Gender'];
    rank = json['Rank'];
    up = json['UP'] ?? '0';
    awards = json['HIS'];
    teams = json['Team'] ?? '0';
    teamName = json['TeamName'] ?? '0';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Name'] = name;
    data['Mar'] = mar;
    data['Apr'] = apr;
    data['May'] = may;
    data['Jun'] = jun;
    data['Jul'] = jul;
    data['Aug'] = aug;
    data['Sept'] = sep;
    data['Oct'] = oct;
    data['Nov'] = nov;
    data['Dec'] = dec;
    data['Jan26'] = jan26;
    data['Feb26'] = feb26;
    data['Mar26'] = mar26;
    data['Apr26'] = apr26;
    data['May26'] = may26;
    data['Total'] = total;
    data['AVG'] = avg;
    data['Location'] = location;
    data['Gender'] = gender;
    data['Rank'] = rank;
    data['UP'] = up;
    data['HIS'] = awards;
    data['Team'] = teams;
    data['TeamName'] = teamName;
    return data;
  }
}
