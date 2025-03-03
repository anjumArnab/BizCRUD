class Company {
  final int id;
  final String companyName;
  final String companyAddress;
  final String companyNumber;
  final String companyLogo;

  Company({
    required this.id,
    required this.companyAddress,
    required this.companyLogo,
    required this.companyName,
    required this.companyNumber,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'] ?? 0, // Default to 0 if null
      companyName: json['name'] ?? "Unknown Name", // Default to "Unknown Name" if null
      companyAddress: json['address'] ?? "Unknown Address",
      companyNumber: json['phone'] ?? "No Phone",
      companyLogo: json['logo'] ?? "https://logo.clearbit.com/example.com",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': companyName,
      'address': companyAddress,
      'phone': companyNumber,
      'logo': companyLogo,
    };
  }
}
