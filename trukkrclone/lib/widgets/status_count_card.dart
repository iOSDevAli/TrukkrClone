import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class StatusCountCard extends StatelessWidget {
  final String label;
  final int count;
  final IconData icon;
  final Color color;
  final Color tint;

  const StatusCountCard({super.key, required this.label, required this.count, required this.icon, required this.color, required this.tint});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 92,
      padding: const EdgeInsets.symmetric(vertical: 14),
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(color: tint, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          CircleAvatar(radius: 18, backgroundColor: color, child: Icon(icon, color: Colors.white, size: 16)),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w500)),
          const SizedBox(height: 4),
          Text('$count', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.headerNavyDark)),
        ],
      ),
    );
  }
}
