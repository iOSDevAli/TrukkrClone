import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SummaryRowCard extends StatelessWidget {
  final IconData leadingIcon;
  final Color leadingColor;
  final String title;
  final String trailingText;
  final bool showAddButton;
  final VoidCallback? onAdd;
  final VoidCallback? onTap;

  const SummaryRowCard({
    super.key,
    required this.leadingIcon,
    required this.leadingColor,
    required this.title,
    required this.trailingText,
    this.showAddButton = false,
    this.onAdd,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: leadingColor,
                child: Icon(leadingIcon, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              Text(
                trailingText,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              if (showAddButton) ...[
                const SizedBox(width: 10),
                InkWell(
                  onTap: onAdd,
                  borderRadius: BorderRadius.circular(20),
                  child: const CircleAvatar(
                    radius: 14,
                    backgroundColor: AppColors.running,
                    child: Icon(Icons.add, color: Colors.white, size: 18),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
