import 'package:flutter/material.dart';

class BizCard extends StatelessWidget {
  final String businessLogo;
  final String businessName;
  final String businessAddress;
  final String businessNumber;

  const BizCard({
    super.key,
    required this.businessLogo,
    required this.businessName,
    required this.businessAddress,
    required this.businessNumber,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(12),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          businessLogo,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.business,
                size: 30,
                color: Colors.grey,
              ),
            );
          },
        ),
      ),
      title: Text(
        businessName,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(
                Icons.location_on,
                size: 14,
                color: Colors.black54,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  businessAddress,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              const Icon(
                Icons.phone,
                size: 14,
                color: Colors.green,
              ),
              const SizedBox(width: 4),
              Text(
                businessNumber,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
    );
  }
}
