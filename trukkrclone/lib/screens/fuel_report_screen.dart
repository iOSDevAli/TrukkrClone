import 'package:flutter/material.dart';
import '../widgets/date_time_range_dialog.dart';
import '../widgets/quick_range_menu.dart';
import '../widgets/vehicle_picker_screen.dart';
import 'fuel_report_detail_screen.dart';

class FuelReportScreen extends StatelessWidget {
  const FuelReportScreen({super.key});

  DateTime _startOf(QuickRange r) {
    final now = DateTime.now();
    switch (r) {
      case QuickRange.today:
        return DateTime(now.year, now.month, now.day);
      case QuickRange.yesterday:
        return DateTime(now.year, now.month, now.day).subtract(const Duration(days: 1));
      case QuickRange.sevenDays:
        return DateTime(now.year, now.month, now.day).subtract(const Duration(days: 7));
      case QuickRange.thirtyDays:
        return DateTime(now.year, now.month, now.day).subtract(const Duration(days: 30));
      case QuickRange.customDate:
        return DateTime(now.year, now.month, now.day);
    }
  }

  @override
  Widget build(BuildContext context) {
    return VehiclePickerScreen(
      title: 'Fuel Report',
      onRangeChosen: (ctx, vehicle, range) async {
        DateTime from;
        DateTime to;
        if (range == QuickRange.customDate) {
          final result = await showDateTimeRangeDialog(context: ctx, confirmLabel: 'View Report');
          if (result == null) return;
          from = result.from;
          to = result.to;
        } else {
          from = _startOf(range);
          to = DateTime.now();
        }
        if (ctx.mounted) {
          Navigator.push(
            ctx,
            MaterialPageRoute(builder: (_) => FuelReportDetailScreen(vehiclePlate: vehicle.plate, from: from, to: to)));
        }
      },
    );
  }
}
