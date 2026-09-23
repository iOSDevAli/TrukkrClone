import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/dashboard_models.dart';
import '../theme/app_theme.dart';
// import '../widgets/alert_tile_widget.dart';
// import '../widgets/menu_tile_widget.dart';
// import '../widgets/summary_row_card.dart';
// import '../widgets/trukkr_bottom_nav.dart';
// import '../widgets/vehicle_status_card.dart';
// import '../widgets/diagonal_pattern_background.dart';
import 'events_alerts_screen.dart';
import 'vehicle_reports_screen.dart';
import 'vehicle_history_screen.dart';
import 'fuel_report_screen.dart';
import 'vehicle_expenses_screen.dart';
import 'maintenance_schedule_screen.dart';
import 'add_maintenance_schedule_screen.dart';
// import 'status_screen.dart';
// import 'settings_screen.dart';
import '../widgets/dashboard_header_banner.dart';
import '../widgets/vehicle_status_bar_card.dart';
import '../widgets/alerts_banner_card.dart';
import '../widgets/feature_card.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
 
 // int _navIndex = 0;

  // Replace these with live data from your API / state layer.
  final _statuses = const [
    VehicleStatus(label: 'Running', count: 2, color: AppColors.running),
    VehicleStatus(label: 'Stopped', count: 1, color: AppColors.stopped),
    VehicleStatus(label: 'Idle', count: 1, color: AppColors.idle),
    VehicleStatus(label: 'Offline', count: 1, color: AppColors.offline),
    VehicleStatus(label: 'No Data', count: 1, color: AppColors.noData),
    VehicleStatus(label: 'Expired', count: 1, color: AppColors.expired),
  ];

  // final _alerts = const [
  //   AlertTile(
  //     title: 'Geofence',
  //     count: 0,
  //     icon: FontAwesomeIcons.borderAll,
  //     gradient: AppColors.geofence,
  //   ),
  //   AlertTile(
  //     title: 'Overspeed',
  //     count: 0,
  //     icon: FontAwesomeIcons.gaugeHigh,
  //     gradient: AppColors.overspeed,
  //   ),
  //   AlertTile(
  //     title: 'Excess Idle',
  //     count: 0,
  //     icon: FontAwesomeIcons.pause,
  //     gradient: AppColors.excessIdle,
  //   ),
  //   AlertTile(
  //     title: 'Excess Driving',
  //     count: 0,
  //     icon: FontAwesomeIcons.carSide,
  //     gradient: AppColors.excessDriving,
  //   ),
  //   AlertTile(
  //     title: 'Ignition on/off',
  //     count: 0,
  //     icon: FontAwesomeIcons.key,
  //     gradient: AppColors.ignition,
  //   ),
  //   AlertTile(
  //     title: 'Parked',
  //     count: 0,
  //     icon: FontAwesomeIcons.squareParking,
  //     gradient: AppColors.parked,
  //   ),
  // ];

void _openEventsAlerts(String filterType) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EventsAlertsScreen(filterType: filterType),
      ),
    );
  }

  // Future<void> _onNavTap(int index) async {
  //   if (index == _navIndex) return;
  //   switch (index) {
  //     case 0:
  //       setState(() => _navIndex = 0);
  //       return;
  //     case 1:
  //       // ScaffoldMessenger.of(context).showSnackBar(
  //       //   const SnackBar(content: Text('Map is coming soon')),
  //       // );
  //       //return;
  //       //setState(() => _navIndex = 1);
  //       await Navigator.push(context, MaterialPageRoute(builder: (_) => const StatusScreen()));
  //       break;
  //     case 2:
  //       //setState(() => _navIndex = 2);
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text('Map is coming soon')),
  //         );
  //       return;
  //       // await Navigator.push(context, MaterialPageRoute(builder: (_) => const StatusScreen()));
  //       // break;
  //     case 3:
  //       //setState(() => _navIndex = 3);
  //       await Navigator.push(context, MaterialPageRoute(builder: (_) => const EventsAlertsScreen()));
  //       break;
  //     case 4:
  //       //setState(() => _navIndex = 4);
  //       await Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
  //       break;
  //   }
  //   if (mounted) setState(() => _navIndex = 0);
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       automaticallyImplyLeading: false,
  //       title: Text('Dashboard', style: Theme.of(context).textTheme.headlineSmall),
  //     ),
  //     body: DiagonalPatternBackground(
  //       child: SafeArea(
  //       top: false,
  //       child: ListView(
  //         padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
  //         children: [
  //           VehicleStatusCard(statuses: _statuses),
  //           const SizedBox(height: 20),

  //           // Text('Alerts (Today)', style: Theme.of(context).textTheme.titleMedium),
  //           // const SizedBox(height: 12),

  //           // "Alerts (Today)" — title + Total Alerts banner + 2x2 grid,
  //            // all inside one white card, matching the Vehicle Status box.
  //           Card(
  //             child: Padding(
  //               padding: const EdgeInsets.all(16),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.stretch,
  //                 children: [
  //                   Text(
  //                     'Alerts (Today)',
  //                     textAlign: TextAlign.center,
  //                     style: Theme.of(context).textTheme.titleMedium,
  //                   ),
  //                   const Divider(height: 24),

  //           // Full-width "Total Alerts" banner
  //           AlertTileWidget(
  //             tile: const AlertTile(
  //               title: 'Total Alerts',
  //               count: 0,
  //               icon: FontAwesomeIcons.bell,
  //               gradient: AppColors.totalAlerts,
  //             ),
  //             onTap: () => _openEventsAlerts('Total Alerts'),
  //           ),
  //           const SizedBox(height: 12),

  //           // 2-column grid of remaining alert tiles
  //           GridView.count(
  //             crossAxisCount: 2,
  //             shrinkWrap: true,
  //             physics: const NeverScrollableScrollPhysics(),
  //             mainAxisSpacing: 12,
  //             crossAxisSpacing: 12,
  //             //childAspectRatio: 2.6,
  //             childAspectRatio: 1.9,
  //             children: _alerts.map((a) => AlertTileWidget(tile: a, onTap: () => _openEventsAlerts(a.title),)).toList(),
  //           ),
  //               ],
  //               ),
  //             ),
  //           ),
  //           const SizedBox(height: 20),

  //           // 2x2 grid of menu tiles: Reports / History / Vehicles / Fuel
  //           GridView.count(
  //             crossAxisCount: 2,
  //             shrinkWrap: true,
  //             physics: const NeverScrollableScrollPhysics(),
  //             mainAxisSpacing: 12,
  //             crossAxisSpacing: 12,
  //             childAspectRatio: 1.35,
  //             children: [
  //               // AppColors.iconReports -> for reports, AppColors.iconHistory for history, AppColors.iconVehicles for vehicles, AppColors.iconFuel for Fuel
  //               // MenuTileWidget(title: 'Reports', icon: Icons.show_chart_rounded, iconColor: const Color(0xFF3B82F6), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const VehicleReportsScreen())),),
  //               // MenuTileWidget(title: 'History', icon: Icons.history_rounded, iconColor: AppColors.running, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const VehicleHistoryScreen())),),
  //               // MenuTileWidget(title: 'Vehicles', icon: FontAwesomeIcons.carSide, iconColor: AppColors.stopped, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const StatusScreen())),),
  //               // MenuTileWidget(title: 'Fuel', icon: FontAwesomeIcons.gasPump, iconColor: AppColors.idle, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FuelReportScreen())),),

  //               MenuTileWidget(title: 'Reports', icon: Icons.show_chart_rounded, iconColor: AppColors.iconReports, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const VehicleReportsScreen())),),
  //               MenuTileWidget(title: 'History', icon: Icons.history_rounded, iconColor: AppColors.iconHistory, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const VehicleHistoryScreen())),),
  //               MenuTileWidget(title: 'Vehicles', icon: FontAwesomeIcons.carSide, iconColor: AppColors.iconVehicles, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const StatusScreen())),),
  //               MenuTileWidget(title: 'Fuel', icon: FontAwesomeIcons.gasPump, iconColor: AppColors.iconFuel, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FuelReportScreen())),),

  //               //MenuTileWidget(title: 'Fuel', icon: FontAwesomeIcons.gasPump, iconColor: AppColors.idle, onTap: () {}),
  //             ],
  //           ),
  //           const SizedBox(height: 16),

  //           SummaryRowCard(
  //             leadingIcon: Icons.attach_money_rounded,
  //             //leadingColor: AppColors.bottomNavActive,
  //             leadingColor: AppColors.iconMoney,
  //             title: 'All Vehicle Expenses',
  //             trailingText: 'PKR 0.0',
  //             onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const VehicleExpensesScreen())),
  //           ),
  //           const SizedBox(height: 12),

  //           SummaryRowCard(
  //             leadingIcon: FontAwesomeIcons.carSide,
  //             // leadingColor: AppColors.stopped,
  //             leadingColor: AppColors.iconMaintenance,
  //             title: 'Upcoming Maintenance',
  //             trailingText: '0',
  //             showAddButton: true,
  //             //onAdd: () {},
  //             onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MaintenanceScheduleScreen())),
  //             onAdd: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddMaintenanceScheduleScreen())),
  //           ),
  //         ],
  //       ),
  //     ),
  //     ),
  //     bottomNavigationBar: TrukkrBottomNav(
  //       currentIndex: _navIndex,
  //       //onTap: (i) => setState(() => _navIndex = i),
  //       onTap: _onNavTap,
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FB),
      body: Column(
        children: [
          DashboardHeaderBanner(
            // onMenuTap: () => ScaffoldMessenger.of(context).showSnackBar(
            //   const SnackBar(content: Text('Menu is coming soon')),
            // ),
            onLeadingTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Menu is coming soon'))),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              children: [
                const SizedBox(height: 16),
                VehicleStatusBarCard(statuses: _statuses),
                const SizedBox(height: 16),
                AlertsBannerCard(onViewAll: () => _openEventsAlerts('Total Alerts')),
                const SizedBox(height: 16),

                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.55,
                  children: [
                    FeatureCard(
                      compact: true,
                      icon: Icons.person_pin_circle,
                      iconColor: const Color(0xFF7C3AED),
                      iconBg: const Color(0xFFEDE9FE),
                      title: 'Geofence',
                      onTap: () => _openEventsAlerts('Geofence'),
                    ),
                    FeatureCard(
                      compact: true,
                      icon: FontAwesomeIcons.gaugeHigh,
                      iconColor: const Color(0xFF2563EB),
                      iconBg: const Color(0xFFDBEAFE),
                      title: 'Overspeed',
                      onTap: () => _openEventsAlerts('Overspeed'),
                    ),
                    FeatureCard(
                      compact: true,
                      icon: Icons.pause_circle_filled,
                      iconColor: const Color(0xFF059669),
                      iconBg: const Color(0xFFD1FAE5),
                      title: 'Excess Idle',
                      onTap: () => _openEventsAlerts('Excess Idle'),
                    ),
                    FeatureCard(
                      compact: true,
                      icon: FontAwesomeIcons.key,
                      iconColor: const Color(0xFFDC2626),
                      iconBg: const Color(0xFFFEE2E2),
                      title: 'Ignition on/off',
                      onTap: () => _openEventsAlerts('Ignition on/off'),
                    ),
                    FeatureCard(
                      compact: true,
                      icon: FontAwesomeIcons.carSide,
                      iconColor: const Color(0xFF2563EB),
                      iconBg: const Color(0xFFDBEAFE),
                      title: 'Excess Driving',
                      onTap: () => _openEventsAlerts('Excess Driving'),
                    ),
                    FeatureCard(
                      compact: true,
                      icon: Icons.local_parking_rounded,
                      iconColor: const Color(0xFFF97316),
                      iconBg: const Color(0xFFFFEDD5),
                      title: 'Parked',
                      onTap: () => _openEventsAlerts('Parked'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: FeatureCard(
                        icon: Icons.description_rounded,
                        iconColor: const Color(0xFF2563EB),
                        iconBg: const Color(0xFFDBEAFE),
                        cardTint: const Color(0xFFF3F8FF),
                        title: 'Reports',
                        subtitle: 'View detailed reports and analytics',
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const VehicleReportsScreen())),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FeatureCard(
                        icon: Icons.history_rounded,
                        iconColor: AppColors.running,
                        iconBg: AppColors.running.withValues(alpha: 0.15),
                        cardTint: AppColors.running.withValues(alpha: 0.06),
                        title: 'History',
                        subtitle: 'Check vehicle history and logs',
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const VehicleHistoryScreen())),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                FeatureCard(
                  icon: FontAwesomeIcons.gasPump,
                  iconColor: const Color(0xFF7C3AED),
                  iconBg: const Color(0xFFEDE9FE),
                  cardTint: const Color(0xFFF8F6FF),
                  title: 'Fuel',
                  subtitle: 'Track fuel usage and costs',
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FuelReportScreen())),
                ),
                const SizedBox(height: 12),

                FeatureCard(
                  icon: Icons.attach_money_rounded,
                  iconColor: AppColors.stopped,
                  iconBg: AppColors.stopped.withValues(alpha: 0.15),
                  cardTint: AppColors.stopped.withValues(alpha: 0.06),
                  title: 'All Vehicle Expenses',
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const VehicleExpensesScreen())),
                  trailing: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('PKR 0.0', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: AppColors.textPrimary)),
                      Icon(Icons.chevron_right, color: AppColors.textSecondary, size: 20),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                FeatureCard(
                  icon: FontAwesomeIcons.wrench,
                  iconColor: const Color(0xFF7C3AED),
                  iconBg: const Color(0xFFEDE9FE),
                  cardTint: const Color(0xFFF8F6FF),
                  title: 'Upcoming Maintenance',
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MaintenanceScheduleScreen())),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircleAvatar(radius: 11, backgroundColor: Color(0xFFE5E7EB), child: Text('0', style: TextStyle(fontSize: 11))),
                      const SizedBox(width: 8),
                      InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddMaintenanceScheduleScreen())),
                        child: const CircleAvatar(radius: 14, backgroundColor: AppColors.running, child: Icon(Icons.add, color: Colors.white, size: 16)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
