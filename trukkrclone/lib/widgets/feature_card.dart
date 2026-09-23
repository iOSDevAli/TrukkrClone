import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// One reusable card shape covers three looks on the redesigned Dashboard:
/// - compact (Geofence/Overspeed/etc. grid): icon + title + chevron
/// - with a subtitle (Reports/History): icon + title/subtitle + chevron
/// - full width (Fuel/Expenses/Maintenance): icon + title/subtitle + trailing
class FeatureCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final Color? cardTint;
  final VoidCallback? onTap;
  final bool compact;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    this.subtitle,
    this.trailing,
    this.cardTint,
    this.onTap,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final content = compact
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(radius: 18, backgroundColor: iconBg, child: Icon(icon, color: iconColor, size: 18)),
                  const Spacer(),
                  const Icon(Icons.chevron_right, color: AppColors.textSecondary, size: 18),
                ],
              ),
              const SizedBox(height: 10),
              Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: AppColors.textPrimary)),
            ],
          )
        : Row(
            children: [
              CircleAvatar(radius: 20, backgroundColor: iconBg, child: Icon(icon, color: iconColor, size: 20)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: AppColors.textPrimary)),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(subtitle!, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                    ],
                  ],
                ),
              ),
              trailing ?? const Icon(Icons.chevron_right, color: AppColors.textSecondary, size: 20),
            ],
          );

    return Material(
      color: cardTint ?? Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: content,
        ),
      ),
    );
  }
}
