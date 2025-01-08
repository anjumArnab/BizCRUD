class Company {
  int? id;
  String? companyName;
  String? companyAddress;
  String? companyNumber;
  String? companyLogo;

  Company(
      {this.companyAddress,
      this.companyLogo,
      this.companyName,
      this.id,
      this.companyNumber});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['name'];
    companyAddress = json['address'];
    companyNumber = json['phone'];
    companyLogo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    data['id'] = id;
    data['name'] = companyName;
    data['address'] = companyAddress;
    data['phone'] = companyNumber;
    data['logo'] = companyLogo;

    return data;
  }
}
