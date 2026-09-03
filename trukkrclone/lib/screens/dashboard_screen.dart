import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/dashboard_models.dart';
import '../theme/app_theme.dart';
import '../widgets/alert_tile_widget.dart';
import '../widgets/menu_tile_widget.dart';
import '../widgets/summary_row_card.dart';
import '../widgets/trukkr_bottom_nav.dart';
import '../widgets/vehicle_status_card.dart';
import 'events_alerts_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _navIndex = 0;

  // Replace these with live data from your API / state layer.
  final _statuses = const [
    VehicleStatus(label: 'Running', count: 0, color: AppColors.running),
    VehicleStatus(label: 'Stopped', count: 1, color: AppColors.stopped),
    VehicleStatus(label: 'Idle', count: 0, color: AppColors.idle),
    VehicleStatus(label: 'Offline', count: 0, color: AppColors.offline),
    VehicleStatus(label: 'No Data', count: 0, color: AppColors.noData),
    VehicleStatus(label: 'Expired', count: 0, color: AppColors.expired),
  ];

  final _alerts = const [
    AlertTile(
      title: 'Geofence',
      count: 0,
      icon: FontAwesomeIcons.borderAll,
      gradient: AppColors.geofence,
    ),
    AlertTile(
      title: 'Overspeed',
      count: 0,
      icon: FontAwesomeIcons.gaugeHigh,
      gradient: AppColors.overspeed,
    ),
    AlertTile(
      title: 'Excess Idle',
      count: 0,
      icon: FontAwesomeIcons.pause,
      gradient: AppColors.excessIdle,
    ),
    AlertTile(
      title: 'Excess Driving',
      count: 0,
      icon: FontAwesomeIcons.carSide,
      gradient: AppColors.excessDriving,
    ),
    AlertTile(
      title: 'Ignition on/off',
      count: 0,
      icon: FontAwesomeIcons.key,
      gradient: AppColors.ignition,
    ),
    AlertTile(
      title: 'Parked',
      count: 0,
      icon: FontAwesomeIcons.squareParking,
      gradient: AppColors.parked,
    ),
  ];

void _openEventsAlerts(String filterType) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EventsAlertsScreen(filterType: filterType),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Dashboard', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            VehicleStatusCard(statuses: _statuses),
            const SizedBox(height: 20),

            Text('Alerts (Today)', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),

            // Full-width "Total Alerts" banner
            AlertTileWidget(
              tile: const AlertTile(
                title: 'Total Alerts',
                count: 0,
                icon: FontAwesomeIcons.bell,
                gradient: AppColors.totalAlerts,
              ),
              onTap: () => _openEventsAlerts('Total Alerts'),
            ),
            const SizedBox(height: 12),

            // 2-column grid of remaining alert tiles
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 2.6,
              children: _alerts.map((a) => AlertTileWidget(tile: a, onTap: () => _openEventsAlerts(a.title),)).toList(),
            ),
            const SizedBox(height: 20),

            // 2x2 grid of menu tiles: Reports / History / Vehicles / Fuel
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.35,
              children: [
                MenuTileWidget(title: 'Reports', icon: Icons.show_chart_rounded, iconColor: const Color(0xFF3B82F6), onTap: () {}),
                MenuTileWidget(title: 'History', icon: Icons.history_rounded, iconColor: AppColors.running, onTap: () {}),
                MenuTileWidget(title: 'Vehicles', icon: FontAwesomeIcons.carSide, iconColor: AppColors.stopped, onTap: () {}),
                MenuTileWidget(title: 'Fuel', icon: FontAwesomeIcons.gasPump, iconColor: AppColors.idle, onTap: () {}),
              ],
            ),
            const SizedBox(height: 16),

            SummaryRowCard(
              leadingIcon: Icons.attach_money_rounded,
              leadingColor: AppColors.bottomNavActive,
              title: 'All Vehicle Expenses',
              trailingText: 'PKR 0.0',
            ),
            const SizedBox(height: 12),

            SummaryRowCard(
              leadingIcon: FontAwesomeIcons.carSide,
              leadingColor: AppColors.stopped,
              title: 'Upcoming Maintenance',
              trailingText: '0',
              showAddButton: true,
              onAdd: () {},
            ),
          ],
        ),
      ),
      bottomNavigationBar: TrukkrBottomNav(
        currentIndex: _navIndex,
        onTap: (i) => setState(() => _navIndex = i),
      ),
    );
  }
}
