/// Minimal vehicle reference used across Fuel Report, Vehicle History,
/// Vehicle Reports, and similar "pick a vehicle" list screens.
class VehicleRef {
  final String id;
  final String plate;

  const VehicleRef({required this.id, required this.plate});
}

/// Replace with real fleet data from your API.
const List<VehicleRef> demoVehicles = [
  VehicleRef(id: '1', plate: 'JF-3632'),
];
