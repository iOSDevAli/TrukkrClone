import 'package:flutter/material.dart';

enum VehicleRunStatus { running, stopped, idle, offline, noData, expired }

extension VehicleRunStatusStyle on VehicleRunStatus {
  String get label {
    switch (this) {
      case VehicleRunStatus.running:
        return 'Running';
      case VehicleRunStatus.stopped:
        return 'Stopped';
      case VehicleRunStatus.idle:
        return 'Idle';
      case VehicleRunStatus.offline:
        return 'Offline';
      case VehicleRunStatus.noData:
        return 'No Data';
      case VehicleRunStatus.expired:
        return 'Expired';
    }
  }

  Color get color {
    switch (this) {
      case VehicleRunStatus.running:
        return const Color(0xFF1E9E64);
      case VehicleRunStatus.stopped:
        return const Color(0xFFE5484D);
      case VehicleRunStatus.idle:
        return const Color(0xFFF59E0B);
      case VehicleRunStatus.offline:
        return const Color(0xFF2563EB);
      case VehicleRunStatus.noData:
        return const Color(0xFF9CA3AF);
      case VehicleRunStatus.expired:
        return const Color(0xFFB91C1C);
    }
  }
}

/// One row in the Vehicle Status list.
class VehicleStatusEntry {
  final String id;
  final String code; // e.g. 'Truck-001'
  final String plate; // e.g. 'ABC-1234'
  final String driver;
  final String location;
  final VehicleRunStatus status;
  final Color thumbnailTint; // stands in for a real vehicle photo

  const VehicleStatusEntry({
    required this.id,
    required this.code,
    required this.plate,
    required this.driver,
    required this.location,
    required this.status,
    this.thumbnailTint = const Color(0xFFE5E7EB),
  });
}

/// Sample fleet so the list is visible without a backend.
final List<VehicleStatusEntry> demoVehicleStatusEntries = [
  const VehicleStatusEntry(id: '1', code: 'Truck-001', plate: 'ABC-1234', driver: 'Ali Raza', location: 'Karachi, Pakistan', status: VehicleRunStatus.running, thumbnailTint: Color(0xFFE5E7EB)),
  const VehicleStatusEntry(id: '2', code: 'Truck-002', plate: 'XYZ-5678', driver: 'Imran Khan', location: 'Lahore, Pakistan', status: VehicleRunStatus.stopped, thumbnailTint: Color(0xFF2563EB)),
  const VehicleStatusEntry(id: '3', code: 'Truck-003', plate: 'DEF-9012', driver: 'Asif Ali', location: 'Islamabad, Pakistan', status: VehicleRunStatus.idle, thumbnailTint: Color(0xFFE5E7EB)),
  const VehicleStatusEntry(id: '4', code: 'Truck-004', plate: 'GHI-3456', driver: 'Sajid Hussain', location: 'Multan, Pakistan', status: VehicleRunStatus.offline, thumbnailTint: Color(0xFF1E9E64)),
  const VehicleStatusEntry(id: '5', code: 'Truck-005', plate: 'JKL-7890', driver: 'Zeeshan Ali', location: 'Peshawar, Pakistan', status: VehicleRunStatus.noData, thumbnailTint: Color(0xFFE5E7EB)),
];
