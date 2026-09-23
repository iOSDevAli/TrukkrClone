import 'package:flutter/material.dart';

enum QuickRange { today, yesterday, sevenDays, thirtyDays, customDate }

extension QuickRangeLabel on QuickRange {
  String get label {
    switch (this) {
      case QuickRange.today:
        return 'Today';
      case QuickRange.yesterday:
        return 'yesterday';
      case QuickRange.sevenDays:
        return '7 Days';
      case QuickRange.thirtyDays:
        return '30 Days';
      case QuickRange.customDate:
        return 'Custom Date';
    }
  }
}

/// Shows the "Today / yesterday / 7 Days / 30 Days / Custom Date" popup
/// anchored under [tapPosition], matching the menu that appears when a
/// vehicle row (or its 3-dot icon) is tapped on Fuel Report, Vehicle
/// History, and Vehicle Reports.
Future<QuickRange?> showQuickRangeMenu({
  required BuildContext context,
  required Offset tapPosition,
}) {
  final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
  return showMenu<QuickRange>(
    context: context,
    position: RelativeRect.fromRect(
      tapPosition & const Size(40, 40),
      Offset.zero & overlay.size,
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    items: QuickRange.values
        .map((r) => PopupMenuItem(
              value: r,
              child: Text(r.label, style: const TextStyle(fontSize: 15)),
            ))
        .toList(),
  );
}
