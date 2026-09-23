import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class TrukkrBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const TrukkrBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const _items = [
    (icon: Icons.dashboard_rounded, label: 'Dashboard'),

    (icon: Icons.location_on_outlined, label: 'Map'),
    //(icon: Icons.map_outlined, label: 'Map'),
    //(icon: Icons.location_on_outlined, label: 'Live Tracking'),    
    
    (icon: Icons.map_outlined, label: 'Status'),
    //(icon: Icons.location_on_rounded, label: 'Status'),
    // (icon: Icons.location_on_outlined, label: 'Track'),
    
    (icon: Icons.notifications_none_rounded, label: 'Alerts'),
    (icon: Icons.settings_outlined, label: 'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        height: 64,
        //height: 68,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFE5E7EB))),
        ),
        child: Row(
          children: List.generate(_items.length, (index) {
            final item = _items[index];
            final selected = index == currentIndex;
            //AppColors.bottomNavActive
            //AppColors.navActiveBlue
            final color = selected ? AppColors.navActiveBlue : AppColors.bottomNavInactive;
            return Expanded(
              child: InkWell(
                onTap: () => onTap(index),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icon(item.icon, color: color, size: 24),
                    // if (selected) ...[
                    //   const SizedBox(height: 2),
                    //   Text(
                    //     item.label,
                    //     style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w600),
                    //   ),
                    // ],
                    Icon(item.icon, color: color, size: 22),
                    const SizedBox(height: 3),
                    Text(
                      item.label,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 9.5, color: color, fontWeight: selected ? FontWeight.w700 : FontWeight.w500),
                    ),
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
