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
      businessName: json['name'] ?? "Unknown Name",
      businessAddress: json['address'] ?? "Unknown Address",
      businessNumber: json['phone'] ?? "No Phone",
      businessLogo: json['logo'] ?? "https://logo.clearbit.com/example.com",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': businessName,
      'address': businessAddress,
      'phone': businessNumber,
      'logo': businessLogo,
    };
  }
}
