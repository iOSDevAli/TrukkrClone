import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

const Color _accent = Color(0xFF7C3AED);
const Color _accentBg = Color(0xFFEDE9FE);
const Color _wheelTint = Color(0xFFF3F0FE);

/// The custom "Select Time" dialog — a scrolling-wheel time picker
/// styled to match [showTrukkrDatePicker], with a purple accent to
/// mirror the Maintenance Time field's icon color.
Future<TimeOfDay?> showTrukkrTimePicker({required BuildContext context, TimeOfDay? initialTime}) {
  final initial = initialTime ?? TimeOfDay.now();
  return showDialog<TimeOfDay>(
    context: context,
    builder: (ctx) => _SelectTimeDialog(initialTime: initial),
  );
}

class _SelectTimeDialog extends StatefulWidget {
  final TimeOfDay initialTime;
  const _SelectTimeDialog({required this.initialTime});

  @override
  State<_SelectTimeDialog> createState() => _SelectTimeDialogState();
}

class _SelectTimeDialogState extends State<_SelectTimeDialog> {
  static const _itemExtent = 44.0;
  late int _hourIndex; // 0..11 representing 1..12
  late int _minuteIndex; // 0..59
  late int _periodIndex; // 0 = AM, 1 = PM

  late final FixedExtentScrollController _hourController;
  late final FixedExtentScrollController _minuteController;
  late final FixedExtentScrollController _periodController;

  @override
  void initState() {
    super.initState();
    final hour12 = widget.initialTime.hourOfPeriod == 0 ? 12 : widget.initialTime.hourOfPeriod;
    _hourIndex = hour12 - 1;
    _minuteIndex = widget.initialTime.minute;
    _periodIndex = widget.initialTime.period == DayPeriod.am ? 0 : 1;

    _hourController = FixedExtentScrollController(initialItem: _hourIndex);
    _minuteController = FixedExtentScrollController(initialItem: _minuteIndex);
    _periodController = FixedExtentScrollController(initialItem: _periodIndex);
  }

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    _periodController.dispose();
    super.dispose();
  }

  TimeOfDay get _selected {
    final hour24 = _periodIndex == 0 ? (_hourIndex + 1) % 12 : (_hourIndex + 1) % 12 + 12;
    return TimeOfDay(hour: hour24, minute: _minuteIndex);
  }

  Widget _wheel({
    required FixedExtentScrollController controller,
    required int itemCount,
    required String Function(int) labelFor,
    required ValueChanged<int> onChanged,
  }) {
    return SizedBox(
      width: 64,
      height: _itemExtent * 3,
      child: ListWheelScrollView.useDelegate(
        controller: controller,
        itemExtent: _itemExtent,
        diameterRatio: 1.6,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: onChanged,
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: itemCount,
          builder: (context, index) {
            return Center(
              child: Text(
                labelFor(index),
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.headerNavyDark),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(radius: 24, backgroundColor: _accentBg, child: const Icon(Icons.access_time_filled_rounded, color: _accent, size: 22)),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Select Time', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 19, color: AppColors.headerNavyDark)),
                      Text('Choose a time for the reminder', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(color: _wheelTint, borderRadius: BorderRadius.circular(16)),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Selection highlight strip behind the middle row.
                  Container(
                    height: _itemExtent,
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _wheel(
                        controller: _hourController,
                        itemCount: 12,
                        labelFor: (i) => (i + 1).toString().padLeft(2, '0'),
                        onChanged: (i) => setState(() => _hourIndex = i),
                      ),
                      const Text(':', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.headerNavyDark)),
                      _wheel(
                        controller: _minuteController,
                        itemCount: 60,
                        labelFor: (i) => i.toString().padLeft(2, '0'),
                        onChanged: (i) => setState(() => _minuteIndex = i),
                      ),
                      const SizedBox(width: 8),
                      _wheel(
                        controller: _periodController,
                        itemCount: 2,
                        labelFor: (i) => i == 0 ? 'AM' : 'PM',
                        onChanged: (i) => setState(() => _periodIndex = i),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFDDD6FE)),
                      foregroundColor: _accent,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    child: const Text('Cancel', style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context, _selected),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _accent,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    child: const Text('OK', style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
