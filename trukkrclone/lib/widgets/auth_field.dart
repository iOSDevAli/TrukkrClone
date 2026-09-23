import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// The icon-circle + label + input row used for Email and Password on
/// the Login screen.
class AuthField extends StatelessWidget {
  final IconData icon;
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool obscureText;
  final Widget? trailing;
  final TextInputType? keyboardType;

  const AuthField({
    super.key,
    required this.icon,
    required this.label,
    required this.hint,
    required this.controller,
    this.obscureText = false,
    this.trailing,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(border: Border.all(color: const Color(0xFFE2E8F0)), borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          CircleAvatar(radius: 18, backgroundColor: const Color(0xFFEAF2FE), child: Icon(icon, color: AppColors.navActiveBlue, size: 18)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 11.5, color: AppColors.textSecondary)),
                TextField(
                  controller: controller,
                  obscureText: obscureText,
                  keyboardType: keyboardType,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.headerNavyDark),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Color(0xFFB6C2D1)),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
