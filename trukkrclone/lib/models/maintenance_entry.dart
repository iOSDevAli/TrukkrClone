import 'package:flutter/material.dart';

enum MaintenanceStatus { upcoming, inProgress, overdue, completed }

extension MaintenanceStatusStyle on MaintenanceStatus {
  String get label {
    switch (this) {
      case MaintenanceStatus.upcoming:
        return 'Upcoming';
      case MaintenanceStatus.inProgress:
        return 'In Progress';
      case MaintenanceStatus.overdue:
        return 'Overdue';
      case MaintenanceStatus.completed:
        return 'Completed';
    }
  }

  Color get color {
    switch (this) {
      case MaintenanceStatus.upcoming:
        return const Color(0xFF2563EB);
      case MaintenanceStatus.inProgress:
        return const Color(0xFFF59E0B);
      case MaintenanceStatus.overdue:
        return const Color(0xFFE5484D);
      case MaintenanceStatus.completed:
        return const Color(0xFF1E9E64);
    }
  }
}

/// One row in the Maintenance Schedule list.
class MaintenanceEntry {
  final String id;
  final String truckCode; // e.g. 'Truck-001'
  final String plate;
  final String location;
  final DateTime date;
  final String task;
  final String mileage;
  final MaintenanceStatus status;
  final Color thumbnailTint;

  const MaintenanceEntry({
    required this.id,
    required this.truckCode,
    required this.plate,
    required this.location,
    required this.date,
    required this.task,
    required this.mileage,
    required this.status,
    this.thumbnailTint = const Color(0xFFE5E7EB),
  });
}

/// Sample schedule so the list is visible without a backend.
final List<MaintenanceEntry> demoMaintenanceEntries = [
  MaintenanceEntry(id: '1', truckCode: 'Truck-001', plate: 'ABC-1234', location: 'Karachi, Pakistan', date: DateTime(2026, 9, 7), task: 'Oil Change', mileage: '5,000 Km', status: MaintenanceStatus.upcoming, thumbnailTint: const Color(0xFFE5E7EB)),
  MaintenanceEntry(id: '2', truckCode: 'Truck-002', plate: 'XYZ-5678', location: 'Lahore, Pakistan', date: DateTime(2026, 9, 9), task: 'Tire Replacement', mileage: '12,000 Km', status: MaintenanceStatus.inProgress, thumbnailTint: const Color(0xFF2563EB)),
  MaintenanceEntry(id: '3', truckCode: 'Truck-003', plate: 'DEF-9012', location: 'Islamabad, Pakistan', date: DateTime(2026, 9, 5), task: 'Brake Inspection', mileage: '15,000 Km', status: MaintenanceStatus.overdue, thumbnailTint: const Color(0xFFE5E7EB)),
  MaintenanceEntry(id: '4', truckCode: 'Truck-004', plate: 'GHI-3456', location: 'Multan, Pakistan', date: DateTime(2026, 9, 12), task: 'AC Service', mileage: '20,000 Km', status: MaintenanceStatus.upcoming, thumbnailTint: const Color(0xFF1E9E64)),
  MaintenanceEntry(id: '5', truckCode: 'Truck-005', plate: 'JKL-7890', location: 'Peshawar, Pakistan', date: DateTime(2026, 9, 1), task: 'General Checkup', mileage: '25,000 Km', status: MaintenanceStatus.completed, thumbnailTint: const Color(0xFFE5E7EB)),
];
