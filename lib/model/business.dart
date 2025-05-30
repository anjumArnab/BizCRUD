class Business {
  final int id;
  final String businessName;
  final String businessAddress;
  final String businessNumber;
  final String businessLogo;

  Business({
    required this.id,
    required this.businessAddress,
    required this.businessLogo,
    required this.businessName,
    required this.businessNumber,
  });

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      id: json['id'] ?? 0,
      businessName: json['businessName'] ?? "Unknown Name",
      businessAddress: json['businessAddress'] ?? "Unknown Address",
      businessNumber: json['businessNumber'] ?? "No Phone",
      businessLogo:
          json['businessLogo'] ?? "https://logo.clearbit.com/example.com",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'businessName': businessName,
      'businessAddress': businessAddress,
      'businessNumber': businessNumber,
      'businessLogo': businessLogo,
    };
  }
}
