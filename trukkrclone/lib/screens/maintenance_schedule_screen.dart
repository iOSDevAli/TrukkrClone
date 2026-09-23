import 'package:flutter/material.dart';
import '../models/maintenance_entry.dart';
import '../theme/app_theme.dart';
//import '../widgets/diagonal_pattern_background.dart';
import '../widgets/dashboard_header_banner.dart';
import '../widgets/dashboard_section_bottom_nav.dart';
import '../widgets/date_time_range_dialog.dart';
import '../widgets/maintenance_entry_card.dart';
import 'add_maintenance_schedule_screen.dart';

class MaintenanceScheduleScreen extends StatefulWidget {
  const MaintenanceScheduleScreen({super.key});

  @override
  State<MaintenanceScheduleScreen> createState() => _MaintenanceScheduleScreenState();
}

class _MaintenanceScheduleScreenState extends State<MaintenanceScheduleScreen> {
  DateTime _from = DateTime.now();
  DateTime _to = DateTime.now();

  String _fmtDate(DateTime d) => '${d.day.toString().padLeft(2, '0')}-${d.month.toString().padLeft(2, '0')}-${d.year}';

  Future<void> _editRange() async {
    final result = await showDateTimeRangeDialog(context: context, confirmLabel: 'Apply');
    if (result != null) setState(() {
      _from = result.from;
      _to = result.to;
    });
  }

  void _addMaintenance() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const AddMaintenanceScheduleScreen()));
  }

  int _countFor(MaintenanceStatus status) => demoMaintenanceEntries.where((e) => e.status == status).length;

  @override
  Widget build(BuildContext context) {
    final counts = [
      (label: 'Total', count: demoMaintenanceEntries.length, icon: Icons.build_rounded, color: AppColors.running),
      (label: 'Upcoming', count: _countFor(MaintenanceStatus.upcoming), icon: Icons.calendar_today_rounded, color: AppColors.navActiveBlue),
      (label: 'In Progress', count: _countFor(MaintenanceStatus.inProgress), icon: Icons.access_time_filled_rounded, color: const Color(0xFFF59E0B)),
      (label: 'Overdue', count: _countFor(MaintenanceStatus.overdue), icon: Icons.error_rounded, color: AppColors.stopped),
      (label: 'Completed', count: _countFor(MaintenanceStatus.completed), icon: Icons.check_circle_rounded, color: const Color(0xFF6B7280)),
    ];

    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
      //     onPressed: () => Navigator.pop(context),
      //   ),
      //   title: const Text(
      //     'Maintenance Schedule',
      //     style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18, color: AppColors.textPrimary),
      //   ),
      // ),
      // body: DiagonalPatternBackground(
      //   child: SafeArea(
      //     top: false,
      //     child: const Center(
      //       child: Text('No maintenance schedules found', style: TextStyle(color: AppColors.textPrimary)),
      //     ),
      //   ),
      // ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: AppColors.running,
      //   onPressed: () {
      //     Navigator.push(context, MaterialPageRoute(builder: (_) => const AddMaintenanceScheduleScreen()));
      //   },
      //   child: const Icon(Icons.add),
      // ),

            backgroundColor: const Color(0xFFF3F6FB),
      body: Column(
        children: [
          DashboardHeaderBanner(
            title: 'Maintenance Schedule',
            subtitle: 'Keep your fleet in top condition',
            onLeadingTap: () => Navigator.pop(context),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              children: [
                // Date range + Filter row.
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: _editRange,
                        borderRadius: BorderRadius.circular(18),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_today_rounded, color: AppColors.navActiveBlue, size: 18),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  '${_fmtDate(_from)}   →   ${_fmtDate(_to)}',
                                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: AppColors.headerNavyDark),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textSecondary, size: 18),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      borderRadius: BorderRadius.circular(18),
                      onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Filters coming soon'))),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.tune_rounded, size: 16, color: AppColors.headerNavyDark),
                            SizedBox(width: 6),
                            Text('Filter', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.headerNavyDark, fontSize: 13)),
                            Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: AppColors.headerNavyDark),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Status counts — 5 across, equal width (not scrollable).
                Row(
                  children: counts
                      .map((c) => Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(right: 8),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(color: c.color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(14)),
                              child: Column(
                                children: [
                                  CircleAvatar(radius: 16, backgroundColor: c.color, child: Icon(c.icon, color: Colors.white, size: 15)),
                                  const SizedBox(height: 6),
                                  Text(c.label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 9.5, fontWeight: FontWeight.w600, color: AppColors.headerNavyDark)),
                                  const SizedBox(height: 2),
                                  Text('${c.count}', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: AppColors.headerNavyDark)),
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 14),

                // Section banner + Add Maintenance button.
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
                  child: Row(
                    children: [
                      CircleAvatar(radius: 20, backgroundColor: AppColors.navActiveBlue, child: const Icon(Icons.build_rounded, color: Colors.white, size: 18)),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Maintenance Schedule', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: AppColors.headerNavyDark)),
                            Text('View and manage your vehicle maintenance', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                        onPressed: _addMaintenance,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.navActiveBlue,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                        icon: const Icon(Icons.add, size: 16),
                        label: const Text('Add Maintenance', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                if (demoMaintenanceEntries.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Center(child: Text('No maintenance schedules found', style: TextStyle(color: AppColors.textPrimary))),
                  )
                else
                  ...demoMaintenanceEntries.map((e) => MaintenanceEntryCard(
                        entry: e,
                        onTap: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${e.truckCode} maintenance details coming soon'))),
                      )),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const DashboardSectionBottomNav(activeIndex: 0),
    );
  }
}
