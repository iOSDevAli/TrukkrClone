import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AlertsBannerCard extends StatelessWidget {
  final VoidCallback onViewAll;

  const AlertsBannerCard({super.key, required this.onViewAll});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.stopped.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.stopped,
            child: const Icon(Icons.notifications, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Alerts (Today)', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: AppColors.textPrimary)),
                Text('Stay updated with your fleet activities', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
              ],
            ),
          ),
          InkWell(
            onTap: onViewAll,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(color: AppColors.stopped.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(20)),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('View All', style: TextStyle(color: AppColors.stopped, fontWeight: FontWeight.w700, fontSize: 12)),
                  Icon(Icons.chevron_right, color: AppColors.stopped, size: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
