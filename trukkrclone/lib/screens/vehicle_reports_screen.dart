import 'package:flutter/material.dart';
import '../models/vehicle_ref.dart';
import '../theme/app_theme.dart';
import '../widgets/dashboard_header_banner.dart';
import '../widgets/date_time_range_dialog.dart';
import '../widgets/pushed_screen_bottom_nav.dart';
import '../widgets/quick_range_menu.dart';
//import '../widgets/vehicle_picker_screen.dart';
import 'reports_list_screen.dart';

class VehicleReportsScreen extends StatefulWidget {
  const VehicleReportsScreen({super.key});

  @override
  State<VehicleReportsScreen> createState() => _VehicleReportsScreenState();
}

class _VehicleReportsScreenState extends State<VehicleReportsScreen> {
  final _searchController = TextEditingController();
  late List<VehicleRef> _visible;

  @override
  void initState() {
    super.initState();
    _visible = demoVehicles;
    _searchController.addListener(() {
      final q = _searchController.text.trim().toLowerCase();
      setState(() {
        _visible = q.isEmpty ? demoVehicles : demoVehicles.where((v) => v.plate.toLowerCase().contains(q)).toList();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  DateTime _startOf(QuickRange r) {
    final now = DateTime.now();
    switch (r) {
      case QuickRange.today:
        return DateTime(now.year, now.month, now.day);
      case QuickRange.yesterday:
        return DateTime(now.year, now.month, now.day).subtract(const Duration(days: 1));
      case QuickRange.sevenDays:
        return DateTime(now.year, now.month, now.day).subtract(const Duration(days: 7));
      case QuickRange.thirtyDays:
        return DateTime(now.year, now.month, now.day).subtract(const Duration(days: 30));
      case QuickRange.customDate:
        return DateTime(now.year, now.month, now.day);
    }
  }

  Future<void> _openVehicle(VehicleRef vehicle, Offset position) async {
    final range = await showQuickRangeMenu(context: context, tapPosition: position);
    if (range == null || !mounted) return;

    if (range == QuickRange.customDate) {
      final result = await showDateTimeRangeDialog(context: context, confirmLabel: 'View Report');
      if (result == null || !mounted) return;
      Navigator.push(context, MaterialPageRoute(builder: (_) => ReportsListScreen(vehiclePlate: vehicle.plate, from: result.from, to: result.to)));
      return;
    }
    final now = DateTime.now();
    Navigator.push(context, MaterialPageRoute(builder: (_) => ReportsListScreen(vehiclePlate: vehicle.plate, from: _startOf(range), to: now)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FB),
      body: Column(
        children: [
          DashboardHeaderBanner(
            title: 'Vehicle Reports',
            subtitle: 'Manage and View vehicle reports',
            leadingIcon: Icons.arrow_back,
            onLeadingTap: () => Navigator.pop(context),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              children: [
                Container(
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search Vehicle',
                      hintStyle: TextStyle(color: AppColors.textSecondary),
                      prefixIcon: Icon(Icons.search, color: AppColors.navActiveBlue),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                if (_visible.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Center(child: Text('No vehicles found', style: TextStyle(color: AppColors.textPrimary))),
                  )
                else
                  ..._visible.map((v) => _VehicleReportCard(vehicle: v, onOpen: _openVehicle)),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const PushedScreenBottomNav(activeIcon: Icons.description, activeLabel: 'Reports'),
    );
  }
}

class _VehicleReportCard extends StatelessWidget {
  final VehicleRef vehicle;
  final void Function(VehicleRef vehicle, Offset position) onOpen;

  const _VehicleReportCard({required this.vehicle, required this.onOpen});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
      child: Stack(
        children: [
          Positioned(
            right: -10,
            bottom: -14,
            child: Container(
              width: 120,
              height: 50,
              decoration: BoxDecoration(color: AppColors.navActiveBlue.withValues(alpha: 0.06), borderRadius: BorderRadius.circular(30)),
            ),
          ),
          Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(18),
            child: InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: () {
                final box = context.findRenderObject() as RenderBox?;
                final pos = box?.localToGlobal(const Offset(60, 40)) ?? Offset.zero;
                onOpen(vehicle, pos);
              },
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(radius: 26, backgroundColor: AppColors.running.withValues(alpha: 0.15), child: const Icon(Icons.directions_car_filled_rounded, color: AppColors.running, size: 26)),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(vehicle.plate, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: AppColors.headerNavyDark)),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(color: AppColors.navActiveBlue.withValues(alpha: 0.10), borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.description_rounded, size: 15, color: AppColors.navActiveBlue),
                                const SizedBox(width: 6),
                                Text('Reports available', style: TextStyle(color: AppColors.navActiveBlue, fontWeight: FontWeight.w600, fontSize: 12.5)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Builder(
                          builder: (iconContext) => IconButton(
                            icon: const Icon(Icons.more_vert, color: AppColors.navActiveBlue),
                            onPressed: () {
                              final box = iconContext.findRenderObject() as RenderBox;
                              final pos = box.localToGlobal(Offset(box.size.width / 2, box.size.height / 2));
                              onOpen(vehicle, pos);
                            },
                          ),
                        ),
                        const SizedBox(height: 18),
                        const Icon(Icons.chevron_right, color: AppColors.navActiveBlue),
                      ],
                    ),
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