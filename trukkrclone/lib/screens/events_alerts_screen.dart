import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/event_alert.dart';
import '../theme/app_theme.dart';
// import '../widgets/diagonal_pattern_background.dart';
// import '../widgets/event_alert_row.dart';
import '../widgets/alert_event_row.dart';
import '../widgets/dashboard_header_banner.dart';
import '../widgets/no_alerts_illustration.dart';
import '../widgets/status_count_card.dart';

/// Shown when the user taps Total Alerts, Geofence, Overspeed, Excess Idle,
/// Excess Driving, Ignition on/off, or Parked on the Dashboard.
///
/// [filterType] is the tile that was tapped (e.g. "Geofence"). Pass null
/// or "Total Alerts" to show every alert type. Wire this up to a real
/// data source later — for now [alerts] defaults to an empty list, which
/// reproduces the "No alerts found" empty state from the reference video.
class EventsAlertsScreen extends StatefulWidget {
  final String? filterType;
  final List<EventAlert> alerts;
  final bool showBackButton;

  /// [alerts] defaults to an empty list, which [initState] then fills
  /// with [demoEventAlerts] — kept this way (rather than defaulting the
  /// parameter directly) so this widget stays const-constructible for
  /// MainShell's `static const` tab list. Pass a real list once you
  /// have live data.
  const EventsAlertsScreen({
    super.key,
    this.filterType,
    this.alerts = const [],
    this.showBackButton = true,
  });

  static const Map<String, EventAlertVisuals> visualsByType = {
    // 'Geofence': EventAlertVisuals(FontAwesomeIcons.borderAll, Color(0xFF7B2FF7)),
    // 'Overspeed': EventAlertVisuals(FontAwesomeIcons.gaugeHigh, Color(0xFF7B2FF7)),
    // 'Excess Idle': EventAlertVisuals(FontAwesomeIcons.pause, Color(0xFF3B82F6)),
    // 'Excess Driving': EventAlertVisuals(FontAwesomeIcons.carSide, Color(0xFF2563EB)),
    // 'Ignition on/off': EventAlertVisuals(FontAwesomeIcons.key, Color(0xFFEF4444)),
    // 'Parked': EventAlertVisuals(FontAwesomeIcons.squareParking, Color(0xFFDC2626)),
        'Geofence': EventAlertVisuals(FontAwesomeIcons.borderAll, Color(0xFF0F7A72)),
    'Overspeed': EventAlertVisuals(FontAwesomeIcons.gaugeHigh, Color(0xFFE5484D)),
    'Excess Idle': EventAlertVisuals(FontAwesomeIcons.pause, Color(0xFF5B7083)),
    'Excess Driving': EventAlertVisuals(FontAwesomeIcons.carSide, Color(0xFF1E9E64)),
    'Ignition on/off': EventAlertVisuals(FontAwesomeIcons.key, Color(0xFF1C1F26)),
    'Parked': EventAlertVisuals(FontAwesomeIcons.squareParking, Color(0xFF7A2626)),
  };

  @override
  State<EventsAlertsScreen> createState() => _EventsAlertsScreenState();
}

class _EventsAlertsScreenState extends State<EventsAlertsScreen> {
  final _searchController = TextEditingController();
  late List<EventAlert> _visible;
  late List<EventAlert> _all;

  @override
  void initState() {
    super.initState();
    _all = widget.alerts.isEmpty ? List.of(demoEventAlerts) : List.of(widget.alerts);
    _applyFilter();
    _searchController.addListener(_applyFilter);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _applyFilter() {
    final query = _searchController.text.trim().toLowerCase();
    final byType = (widget.filterType == null || widget.filterType == 'Total Alerts')
        ? _all
        : _all.where((a) => a.type == widget.filterType).toList();

    setState(() {
      _visible = query.isEmpty
          ? byType
          : byType
              .where((a) =>
                  a.plate.toLowerCase().contains(query) ||
                  a.eventTitle.toLowerCase().contains(query) ||
                  a.type.toLowerCase().contains(query))
              .toList();
    });
  }

  Future<void> _confirmClearAll() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        // title: const Text('Are you sure?'),
        // content: const Text('Do you want to delete events'),
        title: const Text('Clear all alerts?'),
        content: const Text('This will remove every alert from this list.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('No')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Yes', style: TextStyle(color: AppColors.stopped)),
          ),
          //TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Yes')),
        ],
      ),
    );
    if (confirmed == true) {
      setState(() {
        _all.clear();
        _applyFilter();
      });
    }
  }

  Widget _circleAction({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.18), shape: BoxShape.circle),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }

  IconData get _leadingIcon => widget.showBackButton ? Icons.arrow_back : Icons.menu;
  VoidCallback get _onLeadingTap => widget.showBackButton
      ? () => Navigator.pop(context)
      : () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Menu is coming soon')));

  @override
  Widget build(BuildContext context) {
    final isEmpty = _visible.isEmpty;

    return Scaffold(
      // appBar: AppBar(
      //   // leading: IconButton(
      //   //   icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
      //   //   onPressed: () => Navigator.pop(context),
      //   // ),
      //   leading: widget.showBackButton
      //       ? IconButton(
      //           icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
      //           onPressed: () => Navigator.pop(context),
      //         )
      //       : null,
      //   automaticallyImplyLeading: widget.showBackButton,
      //   title: const Text(
      //     'Events and Alerts',
      //     style: TextStyle(fontWeight: FontWeight.w700, fontSize: 19, color: AppColors.textPrimary),
      //   ),
      //   actions: [
      //     _circleIconButton(icon: Icons.refresh, onTap: _applyFilter),
      //     const SizedBox(width: 8),
      //     _circleIconButton(icon: Icons.delete_outline, onTap: _confirmClearAll),
      //     const SizedBox(width: 8),
      //   ],
      // ),
      // body: DiagonalPatternBackground(
      //   child: SafeArea(
      //     top: false,
      //     child: Column(
      //       children: [
      //         Padding(
      //           padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      //           child: TextField(
      //             controller: _searchController,
      //             decoration: const InputDecoration(
      //               hintText: 'Search Vehicle or Alert',
      //               hintStyle: TextStyle(color: AppColors.textSecondary),
      //               suffixIcon: Icon(Icons.search, color: AppColors.textSecondary),
      //               border: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFD1D5DB))),
      //               enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFD1D5DB))),
      //               focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.bottomNavActive)),
      //             ),
      //           ),
      //         ),
      //         Expanded(
      //           child: _visible.isEmpty
      //               ? const Center(
      //                   child: Text(
      //                     'No alerts found',
      //                     style: TextStyle(color: AppColors.textPrimary, fontSize: 15),
      //                   ),
      //                 )
      //               : ListView.builder(
      //                   padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      //                   itemCount: _visible.length,
      //                   itemBuilder: (context, i) {
      //                     final alert = _visible[i];
      //                     final visuals = EventsAlertsScreen.visualsByType[alert.type] ??
      //                         const EventAlertVisuals(Icons.notifications, AppColors.totalAlertsIconFallback);
      //                     return EventAlertRow(alert: alert, visuals: visuals);
      //                   },
      //                 ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      backgroundColor: const Color(0xFFF3F6FB),
      body: Column(
        children: [
          isEmpty
              ? DashboardHeaderBanner(
                  title: 'Events and Alerts',
                  inlineTitle: true,
                  showTruckIllustration: false,
                  leadingIcon: _leadingIcon,
                  onLeadingTap: _onLeadingTap,
                  actions: [
                    _circleAction(icon: Icons.refresh, onTap: _applyFilter),
                    _circleAction(icon: Icons.delete_outline, onTap: _confirmClearAll),
                  ],
                )
              : DashboardHeaderBanner(
                  title: 'Events and Alerts',
                  subtitle: 'Fleet Management',
                  leadingIcon: _leadingIcon,
                  onLeadingTap: _onLeadingTap,
                ),
          Expanded(
            child: isEmpty ? _buildEmptyBody() : _buildPopulatedBody(),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyBody() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      children: [
        Container(
          decoration: BoxDecoration(color: const Color(0xFFE9F0FC), borderRadius: BorderRadius.circular(28)),
          child: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: 'Search Vehicle or Alert',
              hintStyle: TextStyle(color: AppColors.textSecondary),
              prefixIcon: Icon(Icons.search, color: AppColors.textSecondary),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 32),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22)),
          child: Column(
            children: [
              const NoAlertsIllustration(),
              const SizedBox(height: 20),
              const Text('No alerts found', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: AppColors.headerNavyDark)),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  "You're all caught up! There are no alerts at the moment.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: AppColors.textSecondary.withValues(alpha: 0.9)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPopulatedBody() {
    // Replace with real vehicle-status counts once wired to live data.
    final counts = [
      (label: 'Total', count: _all.length, icon: Icons.inventory_2_outlined, color: const Color(0xFF57534E), tint: const Color(0xFFF3F1EE)),
      (label: 'Running', count: 1, icon: Icons.play_arrow_rounded, color: AppColors.running, tint: AppColors.running.withValues(alpha: 0.12)),
      (label: 'Stopped', count: 0, icon: Icons.stop_rounded, color: AppColors.stopped, tint: AppColors.stopped.withValues(alpha: 0.12)),
      (label: 'Idle', count: 0, icon: Icons.schedule_rounded, color: const Color(0xFFF59E0B), tint: const Color(0xFFFEF3C7)),
      (label: 'Offline', count: 0, icon: Icons.wifi_off_rounded, color: AppColors.navActiveBlue, tint: AppColors.navActiveBlue.withValues(alpha: 0.10)),
      (label: 'No Data', count: 0, icon: Icons.help_outline_rounded, color: const Color(0xFF9CA3AF), tint: const Color(0xFFF3F4F6)),
      (label: 'Expired', count: 0, icon: Icons.warning_amber_rounded, color: AppColors.stopped, tint: AppColors.stopped.withValues(alpha: 0.10)),
    ];

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(color: const Color(0xFFE9F0FC), borderRadius: BorderRadius.circular(20)),
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search Vehicle or Alert',
                    hintStyle: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                    prefixIcon: Icon(Icons.search, color: AppColors.textSecondary, size: 20),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Filters coming soon'))),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6)]),
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
        SizedBox(
          height: 96,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: counts.map((c) => StatusCountCard(label: c.label, count: c.count, icon: c.icon, color: c.color, tint: c.tint)).toList(),
          ),
        ),
        const SizedBox(height: 16),
        ..._visible.map((alert) => AlertEventRow(alert: alert, onTap: () {})),
      ],
    );
  }
  
  // Widget _circleIconButton({required IconData icon, required VoidCallback onTap}) {
  //   return CircleAvatar(
  //     radius: 18,
  //     backgroundColor: const Color(0xFFE5E7EB),
  //     child: IconButton(
  //       icon: Icon(icon, size: 18, color: AppColors.textSecondary),
  //       onPressed: onTap,
  //       splashRadius: 20,
  //     ),
  //   );
  // }
}
