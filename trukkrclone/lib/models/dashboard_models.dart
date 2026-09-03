import 'package:flutter/material.dart';

/// One slice of the "Vehicle Status" donut chart.
class VehicleStatus {
  final String label;
  final int count;
  final Color color;

  const VehicleStatus({
    required this.label,
    required this.count,
    required this.color,
  });
}

/// One of the colored gradient tiles under "Alerts (Today)".
class AlertTile {
  final String title;
  final int count;
  final IconData icon;
  final List<Color> gradient;

  const AlertTile({
    required this.title,
    required this.count,
    required this.icon,
    required this.gradient,
  });
}

/// One of the white grid tiles (Reports / History / Vehicles / Fuel).
class MenuTile {
  final String title;
  final String assetOrEmoji;
  final VoidCallback? onTap;

  const MenuTile({
    required this.title,
    required this.assetOrEmoji,
    this.onTap,
  });
}
