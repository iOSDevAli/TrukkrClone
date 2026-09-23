import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class FuelStatTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color tint;
  final String label;
  final String value;

  const FuelStatTile({super.key, required this.icon, required this.color, required this.tint, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: const Color(0xFFF7F9FC), borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          CircleAvatar(radius: 20, backgroundColor: tint, child: Icon(icon, color: color, size: 20)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 12, color: AppColors.navActiveBlue, fontWeight: FontWeight.w600)),
                const SizedBox(height: 3),
                Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.headerNavyDark)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
