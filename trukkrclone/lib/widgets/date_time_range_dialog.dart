import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class DateTimeRangeResult {
  final DateTime from;
  final DateTime to;
  const DateTimeRangeResult(this.from, this.to);
}

/// The "Select Date and Time range" dialog reached via Custom Date,
/// with separate From/To date and time pickers.
Future<DateTimeRangeResult?> showDateTimeRangeDialog({
  required BuildContext context,
  String confirmLabel = 'View Report',
}) {
  final now = DateTime.now();
  DateTime fromDate = DateTime(now.year, now.month, now.day);
  TimeOfDay fromTime = const TimeOfDay(hour: 0, minute: 1);
  DateTime toDate = DateTime(now.year, now.month, now.day);
  TimeOfDay toTime = const TimeOfDay(hour: 23, minute: 59);

  return showDialog<DateTimeRangeResult>(
    context: context,
    builder: (ctx) {
      return StatefulBuilder(
        builder: (ctx, setState) {
          Future<void> pickDate(bool isFrom) async {
            final picked = await showDatePicker(
              context: ctx,
              initialDate: isFrom ? fromDate : toDate,
              firstDate: DateTime(now.year - 2),
              lastDate: DateTime(now.year + 1),
            );
            if (picked != null) {
              setState(() => isFrom ? fromDate = picked : toDate = picked);
            }
          }

          Future<void> pickTime(bool isFrom) async {
            final picked = await showTimePicker(
              context: ctx,
              initialTime: isFrom ? fromTime : toTime,
            );
            if (picked != null) {
              setState(() => isFrom ? fromTime = picked : toTime = picked);
            }
          }

          String fmtDate(DateTime d) => '${d.day}/${d.month}/${d.year}';
          String fmtTime(TimeOfDay t) =>
              '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

          Widget dateBox(String label, VoidCallback onTap) => Expanded(
                child: OutlinedButton.icon(
                  onPressed: onTap,
                  icon: const Icon(Icons.calendar_today, size: 16),
                  label: Text(label, style: const TextStyle(fontSize: 13)),
                ),
              );

          Widget timeBox(String label, VoidCallback onTap) => Expanded(
                child: OutlinedButton.icon(
                  onPressed: onTap,
                  icon: const Icon(Icons.access_time, size: 16),
                  label: Text(label, style: const TextStyle(fontSize: 13)),
                ),
              );

          return AlertDialog(
            title: const Text('Select Date and Time range', style: TextStyle(fontSize: 16)),
            content: SizedBox(
              width: 320,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('From:', style: TextStyle(color: AppColors.textSecondary)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      dateBox(fmtDate(fromDate), () => pickDate(true)),
                      const SizedBox(width: 8),
                      timeBox(fmtTime(fromTime), () => pickTime(true)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text('To:', style: TextStyle(color: AppColors.textSecondary)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      dateBox(fmtDate(toDate), () => pickDate(false)),
                      const SizedBox(width: 8),
                      timeBox(fmtTime(toTime), () => pickTime(false)),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Close'),
              ),
              TextButton(
                onPressed: () {
                  final from = DateTime(fromDate.year, fromDate.month, fromDate.day, fromTime.hour, fromTime.minute);
                  final to = DateTime(toDate.year, toDate.month, toDate.day, toTime.hour, toTime.minute);
                  Navigator.pop(ctx, DateTimeRangeResult(from, to));
                },
                child: Text(confirmLabel),
              ),
            ],
          );
        },
      );
    },
  );
}
