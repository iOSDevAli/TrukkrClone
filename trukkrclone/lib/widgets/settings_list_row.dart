import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// One row under a Settings section: icon circle, bold title + grey
/// subtitle, and a trailing widget (defaults to a chevron in a light
/// circle, matching the design's "Profile Information" style rows).
class SettingsListRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String subtitle;
  final Color? titleColor;
  final Color? cardTint;
  final Widget? trailing;
  final VoidCallback? onTap;

  const SettingsListRow({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    this.titleColor,
    this.cardTint,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(color: cardTint ?? Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                CircleAvatar(radius: 21, backgroundColor: iconBg, child: Icon(icon, color: iconColor, size: 20)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: titleColor ?? AppColors.headerNavyDark)),
                      const SizedBox(height: 2),
                      Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                trailing ??
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: AppColors.navActiveBlue.withValues(alpha: 0.10),
                      child: const Icon(Icons.chevron_right, color: AppColors.navActiveBlue, size: 18),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
