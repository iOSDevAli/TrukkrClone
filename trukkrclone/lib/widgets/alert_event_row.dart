import 'package:flutter/material.dart';
import '../models/event_alert.dart';
import '../theme/app_theme.dart';

class AlertEventRow extends StatelessWidget {
  final EventAlert alert;
  final VoidCallback? onTap;

  const AlertEventRow({super.key, required this.alert, this.onTap});

  String _fmt(DateTime d) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${d.year}-${two(d.month)}-${two(d.day)} ${two(d.hour)}:${two(d.minute)}:${two(d.second)}';
  }

  @override
  Widget build(BuildContext context) {
    final severityColor = alert.severity.color;
    final isHigh = alert.severity == AlertSeverity.high;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isHigh ? severityColor.withValues(alpha: 0.06) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: severityColor, width: 4)),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: const BorderRadius.horizontal(right: Radius.circular(16)),
        child: InkWell(
          borderRadius: const BorderRadius.horizontal(right: Radius.circular(16)),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(radius: 20, backgroundColor: severityColor.withValues(alpha: 0.15), child: Icon(Icons.notifications, color: severityColor, size: 20)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(color: AppColors.navActiveBlue, borderRadius: BorderRadius.circular(20)),
                        child: Text(alert.plate, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
                      ),
                      const SizedBox(height: 6),
                      Text(alert.eventTitle, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: AppColors.headerNavyDark)),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.local_shipping_outlined, size: 13, color: AppColors.textSecondary),
                          const SizedBox(width: 4),
                          Text(alert.vehicleLabel, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                          const Padding(padding: EdgeInsets.symmetric(horizontal: 6), child: Text('|', style: TextStyle(color: AppColors.textSecondary))),
                          const Icon(Icons.calendar_today_outlined, size: 12, color: AppColors.textSecondary),
                          const SizedBox(width: 4),
                          Text(_fmt(alert.timestamp), style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(color: severityColor.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(width: 7, height: 7, decoration: BoxDecoration(color: severityColor, shape: BoxShape.circle)),
                          const SizedBox(width: 5),
                          Text(alert.severity.label, style: TextStyle(color: severityColor, fontSize: 12, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Icon(Icons.chevron_right, color: AppColors.textSecondary, size: 20),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
