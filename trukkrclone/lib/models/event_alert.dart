import 'package:flutter/material.dart';

/// A single row that will show up in the Events and Alerts list once
/// the backend is wired in. `type` should match one of the Dashboard's
/// alert categories (Geofence, Overspeed, Excess Idle, Excess Driving,
/// Ignition on/off, Parked) so filtering by tile works out of the box.
class EventAlert {
  final String id;
  final String vehicleName;
  final String type;
  final String message;
  final DateTime timestamp;

  const EventAlert({
    required this.id,
    required this.vehicleName,
    required this.type,
    required this.message,
    required this.timestamp,
  });
}

/// Maps an alert type name to the icon/color used for it on the Dashboard,
/// so the same visual language carries over into the list rows here.
class EventAlertVisuals {
  final IconData icon;
  final Color color;
  const EventAlertVisuals(this.icon, this.color);
}
