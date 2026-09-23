import 'package:flutter/material.dart';
import '../state/main_shell_tab_notifier.dart';
import '../theme/app_theme.dart';

/// The bottom nav bar shown on pushed/drilled-down screens (Vehicle
/// Reports, Fuel Report, etc.) that aren't themselves a MainShell tab.
/// Dashboard/Map/Alerts/Settings pop back to MainShell and switch it to
/// that real tab; the center item just shows which section you're in
/// and isn't tappable, since there's no matching MainShell tab for it.
class PushedScreenBottomNav extends StatelessWidget {
  final IconData activeIcon;
  final String activeLabel;

  const PushedScreenBottomNav({super.key, required this.activeIcon, required this.activeLabel});

  void _goToTab(BuildContext context, int tabIndex) {
    mainShellTabIndex.value = tabIndex;
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      (icon: Icons.dashboard_rounded, label: 'Dashboard', tabIndex: 0),
      (icon: Icons.map_outlined, label: 'Map', tabIndex: 1),
    ];
    final trailingItems = [
      (icon: Icons.notifications_none_rounded, label: 'Alerts', tabIndex: 3),
      (icon: Icons.settings_outlined, label: 'Settings', tabIndex: 4),
    ];

    Widget navItem(IconData icon, String label, VoidCallback? onTap, {bool active = false}) {
      final color = active ? AppColors.navActiveBlue : AppColors.bottomNavInactive;
      return Expanded(
        child: InkWell(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 22),
              const SizedBox(height: 3),
              Text(label, textAlign: TextAlign.center, style: TextStyle(fontSize: 9.5, color: color, fontWeight: active ? FontWeight.w700 : FontWeight.w500)),
              if (active) Container(margin: const EdgeInsets.only(top: 2), width: 20, height: 2, color: AppColors.navActiveBlue),
            ],
          ),
        ),
      );
    }

    return SafeArea(
      top: false,
      child: Container(
        height: 68,
        decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Color(0xFFE5E7EB)))),
        child: Row(
          children: [
            for (final item in items) navItem(item.icon, item.label, () => _goToTab(context, item.tabIndex)),
            navItem(activeIcon, activeLabel, null, active: true),
            for (final item in trailingItems) navItem(item.icon, item.label, () => _goToTab(context, item.tabIndex)),
          ],
        ),
      ),
    );
  }
}
