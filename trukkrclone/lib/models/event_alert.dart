import 'package:flutter/material.dart';

enum AlertSeverity { high, medium, low }

extension AlertSeverityStyle on AlertSeverity {
  String get label {
    switch (this) {
      case AlertSeverity.high:
        return 'High';
      case AlertSeverity.medium:
        return 'Medium';
      case AlertSeverity.low:
        return 'Low';
    }
  }

  Color get color {
    switch (this) {
      case AlertSeverity.high:
        return const Color(0xFFE5484D);
      case AlertSeverity.medium:
        return const Color(0xFFF59E0B);
      case AlertSeverity.low:
        return const Color(0xFF6B7280);
    }
  }
}

/// A single row that will show up in the Events and Alerts list once
/// the backend is wired in. `type` should match one of the Dashboard's
/// alert categories (Geofence, Overspeed, Excess Idle, Excess Driving,
/// Ignition on/off, Parked) so filtering by tile works out of the box.
class EventAlert {
  final String id;
  final String plate; // e.g. 'JF-3632' — shown as the blue pill badge
  final String vehicleLabel; // e.g. 'Truck-3632'
  final String eventTitle; // e.g. 'Ignition ON' — the bold row title
  final String type; // category used for filtering from the Dashboard tiles, e.g. 'Ignition on/off'
  final DateTime timestamp;
  final AlertSeverity severity;

  const EventAlert({
    required this.id,
    required this.plate,
    required this.vehicleLabel,
    required this.eventTitle,
    required this.type,
    required this.timestamp,
    this.severity = AlertSeverity.medium,
  });
}

/// Maps an alert type name to the icon/color used for it on the Dashboard,
/// so the same visual language carries over into the list rows here.
class EventAlertVisuals {
  final IconData icon;
  final Color color;
  const EventAlertVisuals(this.icon, this.color);
}

/// Sample data so the populated Events and Alerts layout is visible
/// without a backend — replace with a real fetch once the API's ready.
final List<EventAlert> demoEventAlerts = [
  EventAlert(id: '1', plate: 'JF-3632', vehicleLabel: 'Truck-3632', eventTitle: 'Ignition ON', type: 'Ignition on/off', timestamp: DateTime(2026, 9, 8, 18, 58, 53), severity: AlertSeverity.high),
  EventAlert(id: '2', plate: 'JF-3632', vehicleLabel: 'Truck-3632', eventTitle: 'Ignition OFF', type: 'Ignition on/off', timestamp: DateTime(2026, 9, 8, 18, 53, 47), severity: AlertSeverity.medium),
  EventAlert(id: '3', plate: 'JF-3632', vehicleLabel: 'Truck-3632', eventTitle: 'Ignition ON', type: 'Ignition on/off', timestamp: DateTime(2026, 9, 8, 18, 35, 06), severity: AlertSeverity.medium),
  EventAlert(id: '4', plate: 'JF-3632', vehicleLabel: 'Truck-3632', eventTitle: 'Ignition OFF', type: 'Ignition on/off', timestamp: DateTime(2026, 9, 8, 17, 40, 59), severity: AlertSeverity.medium),
  EventAlert(id: '5', plate: 'JF-3632', vehicleLabel: 'Truck-3632', eventTitle: 'Ignition ON', type: 'Ignition on/off', timestamp: DateTime(2026, 9, 8, 12, 9, 06), severity: AlertSeverity.medium),
];