import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/event_alert.dart';
import '../theme/app_theme.dart';
import '../widgets/diagonal_pattern_background.dart';
import '../widgets/event_alert_row.dart';

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

  const EventsAlertsScreen({
    super.key,
    this.filterType,
    this.alerts = const [],
  });

  static const Map<String, EventAlertVisuals> visualsByType = {
    'Geofence': EventAlertVisuals(FontAwesomeIcons.borderAll, Color(0xFF7B2FF7)),
    'Overspeed': EventAlertVisuals(FontAwesomeIcons.gaugeHigh, Color(0xFF7B2FF7)),
    'Excess Idle': EventAlertVisuals(FontAwesomeIcons.pause, Color(0xFF3B82F6)),
    'Excess Driving': EventAlertVisuals(FontAwesomeIcons.carSide, Color(0xFF2563EB)),
    'Ignition on/off': EventAlertVisuals(FontAwesomeIcons.key, Color(0xFFEF4444)),
    'Parked': EventAlertVisuals(FontAwesomeIcons.squareParking, Color(0xFFDC2626)),
  };

  @override
  State<EventsAlertsScreen> createState() => _EventsAlertsScreenState();
}

class _EventsAlertsScreenState extends State<EventsAlertsScreen> {
  final _searchController = TextEditingController();
  late List<EventAlert> _visible;

  @override
  void initState() {
    super.initState();
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
        ? widget.alerts
        : widget.alerts.where((a) => a.type == widget.filterType).toList();

    setState(() {
      _visible = query.isEmpty
          ? byType
          : byType
              .where((a) =>
                  a.vehicleName.toLowerCase().contains(query) ||
                  a.type.toLowerCase().contains(query))
              .toList();
    });
  }

  Future<void> _confirmClearAll() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear all alerts?'),
        content: const Text('This will remove every alert from this list.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Clear', style: TextStyle(color: AppColors.stopped)),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      setState(() {
        widget.alerts.clear();
        _applyFilter();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Events and Alerts',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 19, color: AppColors.textPrimary),
        ),
        actions: [
          _circleIconButton(icon: Icons.refresh, onTap: _applyFilter),
          const SizedBox(width: 8),
          _circleIconButton(icon: Icons.delete_outline, onTap: _confirmClearAll),
          const SizedBox(width: 8),
        ],
      ),
      body: DiagonalPatternBackground(
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search Vehicle or Alert',
                    hintStyle: TextStyle(color: AppColors.textSecondary),
                    suffixIcon: Icon(Icons.search, color: AppColors.textSecondary),
                    border: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFD1D5DB))),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFD1D5DB))),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.bottomNavActive)),
                  ),
                ),
              ),
              Expanded(
                child: _visible.isEmpty
                    ? const Center(
                        child: Text(
                          'No alerts found',
                          style: TextStyle(color: AppColors.textPrimary, fontSize: 15),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                        itemCount: _visible.length,
                        itemBuilder: (context, i) {
                          final alert = _visible[i];
                          final visuals = EventsAlertsScreen.visualsByType[alert.type] ??
                              const EventAlertVisuals(Icons.notifications, AppColors.totalAlertsIconFallback);
                          return EventAlertRow(alert: alert, visuals: visuals);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _circleIconButton({required IconData icon, required VoidCallback onTap}) {
    return CircleAvatar(
      radius: 18,
      backgroundColor: const Color(0xFFE5E7EB),
      child: IconButton(
        icon: Icon(icon, size: 18, color: AppColors.textSecondary),
        onPressed: onTap,
        splashRadius: 20,
      ),
    );
  }
}
