import 'package:flutter/material.dart';

class CompanyCard extends StatelessWidget {
  final String companyLogo;
  final String companyName;
  final String companyAddress;
  final String companyNumber;

  const CompanyCard({
    super.key,
    required this.companyLogo,
    required this.companyName,
    required this.companyAddress,
    required this.companyNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black, width: 1.5),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Image.network(
              companyLogo,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 100,
                  width: double.infinity,
                  color: Colors.grey[300], // Placeholder background
                  child: const Icon(Icons.broken_image, size: 50, color: Colors.grey),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  companyName,
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  companyAddress,
                  style: const TextStyle(
                      fontSize: 14, color: Colors.black54),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "📞 $companyNumber",
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
