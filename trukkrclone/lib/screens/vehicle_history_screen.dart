import 'package:flutter/material.dart';
import '../widgets/date_time_range_dialog.dart';
import '../widgets/quick_range_menu.dart';
import '../widgets/vehicle_picker_screen.dart';
import 'vehicle_history_map_screen.dart';

class VehicleHistoryScreen extends StatelessWidget {
  const VehicleHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return VehiclePickerScreen(
      title: 'Vehicle History',
      onRangeChosen: (ctx, vehicle, range) async {
        if (range == QuickRange.customDate) {
          final result = await showDateTimeRangeDialog(context: ctx, confirmLabel: 'View Report');
          if (result == null) return;
        }
        if (ctx.mounted) {
          Navigator.push(
            ctx,
            MaterialPageRoute(builder: (_) => VehicleHistoryMapScreen(vehiclePlate: vehicle.plate)),
          );
        }
      },
    );
  }
}
