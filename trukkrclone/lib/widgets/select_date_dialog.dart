import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

const List<String> _weekdayHeaders = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
const List<String> _monthNames = [
  'January', 'February', 'March', 'April', 'May', 'June',
  'July', 'August', 'September', 'October', 'November', 'December',
];

/// The custom "Select Date" calendar dialog — a styled replacement for
/// Flutter's default [showDatePicker], matching the pastel-header /
/// blue-selected-day design used across Add Maintenance Schedule.
Future<DateTime?> showTrukkrDatePicker({
  required BuildContext context,
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
}) {
  final initial = initialDate ?? DateTime.now();
  return showDialog<DateTime>(
    context: context,
    builder: (ctx) => _SelectDateDialog(initialDate: initial, firstDate: firstDate, lastDate: lastDate),
  );
}

class _SelectDateDialog extends StatefulWidget {
  final DateTime initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;

  const _SelectDateDialog({required this.initialDate, this.firstDate, this.lastDate});

  @override
  State<_SelectDateDialog> createState() => _SelectDateDialogState();
}

class _SelectDateDialogState extends State<_SelectDateDialog> {
  late DateTime _displayedMonth;
  late DateTime _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialDate;
    _displayedMonth = DateTime(widget.initialDate.year, widget.initialDate.month);
  }

  void _changeMonth(int delta) {
    setState(() => _displayedMonth = DateTime(_displayedMonth.year, _displayedMonth.month + delta));
  }

  bool _isSameDay(DateTime a, DateTime b) => a.year == b.year && a.month == b.month && a.day == b.day;

  bool _inRange(DateTime d) {
    if (widget.firstDate != null && d.isBefore(DateTime(widget.firstDate!.year, widget.firstDate!.month, widget.firstDate!.day))) return false;
    if (widget.lastDate != null && d.isAfter(DateTime(widget.lastDate!.year, widget.lastDate!.month, widget.lastDate!.day))) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final daysInMonth = DateTime(_displayedMonth.year, _displayedMonth.month + 1, 0).day;
    final firstWeekday = DateTime(_displayedMonth.year, _displayedMonth.month, 1).weekday % 7; // 0 = Sunday

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
                CircleAvatar(radius: 24, backgroundColor: const Color(0xFFDBEAFE), child: const Icon(Icons.calendar_today_rounded, color: Color(0xFF2563EB), size: 22)),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Select Date', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 19, color: AppColors.headerNavyDark)),
                      Text('Choose a date from calendar', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              decoration: BoxDecoration(color: const Color(0xFFEAF2FE), borderRadius: BorderRadius.circular(16)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _NavCircleButton(icon: Icons.chevron_left, onTap: () => _changeMonth(-1)),
                  Row(
                    children: [
                      Text('${_monthNames[_displayedMonth.month - 1]} ${_displayedMonth.year}',
                          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: AppColors.headerNavyDark)),
                      const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.headerNavyDark, size: 20),
                    ],
                  ),
                  _NavCircleButton(icon: Icons.chevron_right, onTap: () => _changeMonth(1)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: _weekdayHeaders
                  .map((d) => Expanded(child: Center(child: Text(d, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)))))
                  .toList(),
            ),
            const SizedBox(height: 6),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: firstWeekday + daysInMonth,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7, childAspectRatio: 1),
              itemBuilder: (context, index) {
                if (index < firstWeekday) return const SizedBox.shrink();
                final day = index - firstWeekday + 1;
                final date = DateTime(_displayedMonth.year, _displayedMonth.month, day);
                final selected = _isSameDay(date, _selected);
                final enabled = _inRange(date);

                return Center(
                  child: InkWell(
                    onTap: enabled ? () => setState(() => _selected = date) : null,
                    customBorder: const CircleBorder(),
                    child: Container(
                      width: 34,
                      height: 34,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: selected ? const Color(0xFF2563EB) : Colors.transparent, shape: BoxShape.circle),
                      child: Text(
                        '$day',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                          color: !enabled
                              ? AppColors.textSecondary.withValues(alpha: 0.4)
                              : selected
                                  ? Colors.white
                                  : AppColors.headerNavyDark,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFBFDBFE)),
                      foregroundColor: const Color(0xFF2563EB),
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
                      backgroundColor: const Color(0xFF2563EB),
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

class _NavCircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _NavCircleButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 32,
        height: 32,
        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        child: Icon(icon, color: const Color(0xFF2563EB), size: 20),
      ),
    );
  }
}
