import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// The full-width "Move Duration" / "Stop Duration" rows, with a soft
/// decorative wave in the corner matching the mockup.
class DurationRowCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color tint;
  final Color backgroundTint;
  final String label;
  final String value;
  final VoidCallback? onTap;

  const DurationRowCard({
    super.key,
    required this.icon,
    required this.color,
    required this.tint,
    required this.backgroundTint,
    required this.label,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Material(
        color: backgroundTint,
        child: InkWell(
          onTap: onTap,
          child: Stack(
            children: [
              Positioned(
                right: -10,
                bottom: -18,
                child: Container(
                  width: 140,
                  height: 60,
                  decoration: BoxDecoration(color: color.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(40)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(radius: 20, backgroundColor: tint, child: Icon(icon, color: color, size: 20)),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(label, style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 3),
                          Text(value, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: AppColors.headerNavyDark)),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right, color: color, size: 22),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
