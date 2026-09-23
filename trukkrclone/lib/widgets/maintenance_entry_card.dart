import 'package:flutter/material.dart';
import '../models/maintenance_entry.dart';
import '../theme/app_theme.dart';

class MaintenanceEntryCard extends StatelessWidget {
  final MaintenanceEntry entry;
  final VoidCallback? onTap;

  const MaintenanceEntryCard({super.key, required this.entry, this.onTap});

  String _fmtDate(DateTime d) => '${d.day.toString().padLeft(2, '0')}-${d.month.toString().padLeft(2, '0')}-${d.year}';

  Widget _iconLine(IconData icon, String text, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          Icon(icon, size: 13, color: color ?? AppColors.navActiveBlue),
          const SizedBox(width: 6),
          Text(text, style: TextStyle(fontSize: 12.5, color: color ?? AppColors.textSecondary, fontWeight: color != null ? FontWeight.w700 : FontWeight.w500)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isOverdue = entry.status == MaintenanceStatus.overdue;
    final isCompleted = entry.status == MaintenanceStatus.completed;
    final borderColor = isOverdue ? AppColors.stopped : (isCompleted ? AppColors.running : null);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: borderColor != null ? Border(left: BorderSide(color: borderColor, width: 4)) : null,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(color: entry.thumbnailTint.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(12)),
                  child: Icon(Icons.local_shipping_rounded, color: entry.thumbnailTint, size: 30),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: AppColors.navActiveBlue, borderRadius: BorderRadius.circular(20)),
                        child: Text(entry.truckCode, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700)),
                      ),
                      _iconLine(Icons.directions_car_rounded, entry.plate),
                      _iconLine(Icons.location_on_outlined, entry.location),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _iconLine(Icons.calendar_today_rounded, _fmtDate(entry.date), color: isOverdue ? AppColors.stopped : null),
                        _iconLine(Icons.build_rounded, entry.task),
                        _iconLine(Icons.access_time_rounded, entry.mileage),
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(color: entry.status.color.withValues(alpha: 0.14), borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(width: 7, height: 7, decoration: BoxDecoration(color: entry.status.color, shape: BoxShape.circle)),
                          const SizedBox(width: 5),
                          Text(entry.status.label, style: TextStyle(color: entry.status.color, fontWeight: FontWeight.w700, fontSize: 11.5)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                    const Icon(Icons.chevron_right, color: AppColors.textSecondary, size: 18),
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
