import 'package:flutter/material.dart';
import '../state/main_shell_tab_notifier.dart';
import '../theme/app_theme.dart';

/// The standard 5-item bottom nav (Dashboard/Map/Status/Alerts/Settings)
/// for screens that are pushed from *within* the Dashboard section
/// (Vehicle Expenses, etc.) rather than being a distinct section of
/// their own — so Dashboard stays highlighted as "where you are," and
/// every icon (including Dashboard) pops back to MainShell and selects
/// that real tab.
class DashboardSectionBottomNav extends StatelessWidget {
  final int activeIndex;
  const DashboardSectionBottomNav({super.key, this.activeIndex = 0});

  static const _items = [
    (icon: Icons.dashboard_rounded, label: 'Dashboard'),
    (icon: Icons.map_outlined, label: 'Map'),
    (icon: Icons.location_on_rounded, label: 'Status'),
    (icon: Icons.notifications_none_rounded, label: 'Alerts'),
    (icon: Icons.settings_outlined, label: 'Settings'),
  ];

  void _goToTab(BuildContext context, int index) {
    mainShellTabIndex.value = index;
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        height: 68,
        decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Color(0xFFE5E7EB)))),
        child: Row(
          children: List.generate(_items.length, (index) {
            final item = _items[index];
            final selected = index == activeIndex;
            final color = selected ? AppColors.navActiveBlue : AppColors.bottomNavInactive;
            return Expanded(
              child: InkWell(
                onTap: () => _goToTab(context, index),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(item.icon, color: color, size: 22),
                    const SizedBox(height: 3),
                    Text(item.label, style: TextStyle(fontSize: 9.5, color: color, fontWeight: selected ? FontWeight.w700 : FontWeight.w500)),
                    if (selected) Container(margin: const EdgeInsets.only(top: 2), width: 20, height: 2, color: AppColors.navActiveBlue),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
