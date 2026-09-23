import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/dashboard_header_banner.dart';
import '../widgets/date_time_range_dialog.dart';
import '../widgets/pushed_screen_bottom_nav.dart';

class _ReportType {
  final String title;
  final String subtitle;
  final IconData icon;
  final int colorIndex;
  const _ReportType(this.title, this.subtitle, this.icon, this.colorIndex);
}

// Palette cycled across cards: blue, green, purple, orange, red —
// matching the reference design's rotating category colors.
const List<Color> _iconColors = [Color(0xFF2563EB), Color(0xFF059669), Color(0xFF7C3AED), Color(0xFFEA580C), Color(0xFFE5484D)];
const List<Color> _iconBgs = [Color(0xFFDBEAFE), Color(0xFFD1FAE5), Color(0xFFEDE9FE), Color(0xFFFFEDD5), Color(0xFFFEE2E2)];

const List<_ReportType> _reportTypes = [
  _ReportType('Travel Summary', 'View overall travel details, distance, time and cost information.', Icons.route_rounded, 0),
  _ReportType('Travel Summary Bulk', 'Download multiple travel summaries in bulk.', Icons.folder_copy_rounded, 1),
  _ReportType('Travel Summary Custom', 'Generate custom report with selected filters and fields.', Icons.settings_rounded, 2),
  _ReportType('Travel Summary Custom 1', 'View custom travel summary report - 1.', Icons.description_rounded, 0),
  _ReportType('Travel Summary Custom 2', 'View custom travel summary report - 2.', Icons.description_rounded, 1),
  _ReportType('Travel Summary Custom 3', 'View custom travel summary report - 3.', Icons.description_rounded, 2),
  _ReportType('Stops Move Summary', 'View all stops and move details of the vehicle.', Icons.route_rounded, 3),
  _ReportType('Stop Move with Geofence', 'View stops and moves within geofenced areas.', Icons.gps_fixed_rounded, 4),
  _ReportType('Stop Move with Drivers', 'View stop and move details grouped by driver.', Icons.person_pin_circle_rounded, 0),
  _ReportType('Stops Move Simplified', 'A simplified view of stop and move activity.', Icons.route_rounded, 1),
  _ReportType('Stoppage Summary', 'View a summary of all vehicle stoppages.', Icons.pause_circle_rounded, 2),
  _ReportType('Move Summary', 'View a summary of vehicle movement activity.', Icons.directions_car_rounded, 3),
  _ReportType('Move Summary Detailed', 'View a detailed breakdown of vehicle movement.', Icons.list_alt_rounded, 4),
  _ReportType('Overspeed', 'View instances where the vehicle exceeded the speed limit.', Icons.speed_rounded, 0),
  _ReportType('Overspeed In Geofence', 'View overspeed events within geofenced areas.', Icons.speed_rounded, 1),
  _ReportType('Over speeding summary', 'View a summary of all overspeeding events.', Icons.speed_rounded, 2),
  _ReportType('Underspeed', 'View instances where the vehicle was under the expected speed.', Icons.trending_down_rounded, 3),
  _ReportType('Geofences', 'View and manage configured geofence areas.', Icons.map_rounded, 4),
  _ReportType('Geofence in out', 'View geofence entry and exit events.', Icons.compare_arrows_rounded, 0),
  _ReportType('Geofence in out 24 mode', 'View 24-hour geofence entry and exit activity.', Icons.access_time_filled_rounded, 1),
  _ReportType('Geofence in out (ignition on off)', 'View geofence events tied to ignition status.', Icons.vpn_key_rounded, 2),
  _ReportType('Geofence in out shift', 'View geofence activity grouped by shift.', Icons.schedule_rounded, 3),
  _ReportType('Geofence (Touch all)', 'View all geofence touch events.', Icons.touch_app_rounded, 4),
  _ReportType('Geofence (Touch all) 2', 'An alternate view of all geofence touch events.', Icons.touch_app_rounded, 0),
  _ReportType('Events', 'View all recorded vehicle events.', Icons.event_rounded, 1),
  _ReportType('Fuel level', 'View fuel level readings over time.', Icons.local_gas_station_rounded, 2),
  _ReportType('Fuel fillings', 'View recorded fuel filling events.', Icons.local_gas_station_rounded, 3),
  _ReportType('Fuel thefts', 'View suspected fuel theft incidents.', Icons.warning_amber_rounded, 4),
  _ReportType('Vehicle History', "View the vehicle's full activity history.", Icons.history_rounded, 0),
  _ReportType('Ignition ON OFF', 'View ignition on and off events.', Icons.vpn_key_rounded, 1),
  _ReportType('Speed', 'View recorded vehicle speed data.', Icons.speed_rounded, 2),
  _ReportType('Daily Travel Report', 'View a daily breakdown of travel activity.', Icons.calendar_today_rounded, 3),
  _ReportType('Speed compare GPS ECM report', 'Compare speed readings from GPS and ECM sources.', Icons.compare_rounded, 4),
  _ReportType('Overspeeds Speed ECM', 'View overspeed events based on ECM speed data.', Icons.speed_rounded, 0),
  _ReportType('Geofence in (grouped)', 'View grouped geofence entry events.', Icons.groups_rounded, 1),
];

/// The long list of report types, reached after picking a vehicle and a
/// date range on the Vehicle Reports screen. Tapping an item is a stub —
/// wire each one up to its real report screen as they're built.
class ReportsListScreen extends StatefulWidget {
  final String vehiclePlate;
  final DateTime from;
  final DateTime to;

  const ReportsListScreen({
    super.key,
    required this.vehiclePlate,
    required this.from,
    required this.to,
  });

  @override
  State<ReportsListScreen> createState() => _ReportsListScreenState();
}

  // static const List<String> reportTypes = [
  //   'Travel Summary',
  //   'Travel Summary Bulk',
  //   'Travel Summary Custom',
  //   'Travel Summary Custom 1',
  //   'Travel Summary Custom 2',
  //   'Travel Summary Custom 3',
  //   'Stops Move Summary',
  //   'Stop Move with Geofence',
  //   'Stop Move with Drivers',
  //   'Stops Move Simplified',
  //   'Stoppage Summary',
  //   'Move Summary',
  //   'Move Summary Detailed',
  //   'Overspeed',
  //   'Overspeed In Geofence',
  //   'Over speeding summary',
  //   'Underspeed',
  //   'Geofences',
  //   'Geofence in out',
  //   'Geofence in out 24 mode',
  //   'Geofence in out (ignition on off)',
  //   'Geofence in out shift',
  //   'Geofence (Touch all)',
  //   'Geofence (Touch all) 2',
  //   'Events',
  //   'Fuel level',
  //   'Fuel fillings',
  //   'Fuel thefts',
  //   'Vehicle History',
  //   'Ignition ON OFF',
  //   'Speed',
  //   'Daily Travel Report',
  //   'Speed compare GPS ECM report',
  //   'Overspeeds Speed ECM',
  //   'Geofence in (grouped)',
  // ];

  // String _fmt(DateTime d) => '${d.day}-${d.month.toString().padLeft(2, '0')}-${(d.year % 100).toString().padLeft(2, '0')}';

  class _ReportsListScreenState extends State<ReportsListScreen> {
  late DateTime _from;
  late DateTime _to;

  @override
  void initState() {
    super.initState();
    _from = widget.from;
    _to = widget.to;
  }

  String _fmt(DateTime d) => '${d.day.toString().padLeft(2, '0')}-${d.month.toString().padLeft(2, '0')}-${(d.year % 100).toString().padLeft(2, '0')}';

  Future<void> _editRange() async {
    final result = await showDateTimeRangeDialog(context: context, confirmLabel: 'Apply');
    if (result != null) setState(() {
      _from = result.from;
      _to = result.to;
    });
  }

  Widget _summaryColumn({required IconData icon, required String label, required String value, required VoidCallback onTap}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
          child: Row(
            children: [
              Icon(icon, size: 18, color: AppColors.navActiveBlue),
              const SizedBox(width: 6),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                    Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.headerNavyDark), overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textSecondary, size: 16),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
      //     onPressed: () => Navigator.pop(context),
      //   ),
      //   title: const Text('Reports', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
      //   actions: const [
      //     Padding(
      //       padding: EdgeInsets.only(right: 16),
      //       child: Icon(Icons.calendar_today, color: AppColors.textPrimary),
      //     ),
      //   ],
      // ),
      // body: Column(
      //   children: [
      //     Container(
      //       width: double.infinity,
      //       color: const Color(0xFFE9E9E9),
      //       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      //       child: Row(
      //         children: [
      //           const Icon(Icons.directions_car, size: 16, color: AppColors.textSecondary),
      //           const SizedBox(width: 4),
      //           Text(vehiclePlate, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
      //           const Spacer(),
      //           const Icon(Icons.calendar_today, size: 14, color: AppColors.textSecondary),
      //           const SizedBox(width: 4),
      //           Text('From: ${_fmt(from)}', style: const TextStyle(fontSize: 12)),
      //           const SizedBox(width: 10),
      //           const Icon(Icons.calendar_today, size: 14, color: AppColors.textSecondary),
      //           const SizedBox(width: 4),
      //           Text('To: ${_fmt(to)}', style: const TextStyle(fontSize: 12)),
      //         ],
      //       ),
      //     ),
      //     Expanded(
      //       child: ListView.builder(
      //         padding: const EdgeInsets.all(16),
      //         itemCount: reportTypes.length,
      //         itemBuilder: (context, i) => Container(
      //           margin: const EdgeInsets.only(bottom: 12),
      //           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      //           decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
      //           child: Row(
      //             children: [
      //               Expanded(child: Text(reportTypes[i], style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14))),
      //               const Icon(Icons.arrow_forward, size: 18, color: AppColors.textSecondary),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      backgroundColor: const Color(0xFFF3F6FB),
      body: Column(
        children: [
          DashboardHeaderBanner(
            title: 'Reports',
            subtitle: 'View detailed reports and analytics',
            leadingIcon: Icons.arrow_back,
            onLeadingTap: () => Navigator.pop(context),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
                  child: Row(
                    children: [
                      _summaryColumn(
                        icon: Icons.local_shipping_rounded,
                        label: 'Vehicle',
                        value: widget.vehiclePlate,
                        onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Only one vehicle in this demo'))),
                      ),
                      Container(width: 1, height: 34, color: const Color(0xFFE5E7EB)),
                      _summaryColumn(icon: Icons.calendar_today_rounded, label: 'From', value: _fmt(_from), onTap: _editRange),
                      Container(width: 1, height: 34, color: const Color(0xFFE5E7EB)),
                      _summaryColumn(icon: Icons.calendar_today_rounded, label: 'To', value: _fmt(_to), onTap: _editRange),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                ..._reportTypes.map((r) => _ReportCard(report: r)),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const PushedScreenBottomNav(activeIcon: Icons.description, activeLabel: 'Reports'),
    );
  }
}

class _ReportCard extends StatelessWidget {
  final _ReportType report;
  const _ReportCard({required this.report});

  @override
  Widget build(BuildContext context) {
    final color = _iconColors[report.colorIndex];
    final bg = _iconBgs[report.colorIndex];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(18)),
      child: Stack(
        children: [
          Positioned(
            right: -10,
            bottom: -16,
            child: Container(
              width: 130,
              height: 54,
              decoration: BoxDecoration(color: color.withValues(alpha: 0.06), borderRadius: BorderRadius.circular(30)),
            ),
          ),
          Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(18),
            child: InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${report.title} is coming soon'))),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(radius: 22, backgroundColor: bg, child: Icon(report.icon, color: color, size: 20)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(report.title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: AppColors.headerNavyDark)),
                          const SizedBox(height: 4),
                          Text(report.subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.3)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    CircleAvatar(radius: 15, backgroundColor: color.withValues(alpha: 0.12), child: Icon(Icons.chevron_right, color: color, size: 18)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}