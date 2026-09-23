import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../theme/app_theme.dart';

/// A single hardcoded point the demo vehicle can be moved to.
/// Replace these with real GPS fixes from your backend/socket feed —
/// [MapScreenState.moveCarTo] is the method to call with each new
/// lat/lng as it arrives.
class VehicleWaypoint {
  final String label;
  final LatLng position;
  const VehicleWaypoint(this.label, this.position);
}

/// Hardcoded waypoints around Karachi, Pakistan. Edit freely, or replace
/// the whole list with coordinates pulled from your API.
const List<VehicleWaypoint> demoWaypoints = [
  VehicleWaypoint('Saddar, Karachi', LatLng(24.8607, 67.0011)),
  VehicleWaypoint('Gulshan-e-Iqbal, Karachi', LatLng(24.8735, 67.0298)),
  VehicleWaypoint('Malir, Karachi', LatLng(24.8918, 67.0653)),
  VehicleWaypoint('Korangi, Karachi', LatLng(24.8465, 67.0339)),
];

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  static const _vehicleMarkerId = MarkerId('vehicle-1');

  GoogleMapController? _controller;
  int _waypointIndex = 0;
  Timer? _autoTimer;
  bool _autoPlaying = false;

  late LatLng _carPosition = demoWaypoints.first.position;
  late String _carLabel = demoWaypoints.first.label;

  Set<Marker> get _markers => {
        Marker(
          markerId: _vehicleMarkerId,
          position: _carPosition,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: InfoWindow(title: 'JF-3632', snippet: _carLabel),
        ),
      };

  /// The core "move the car" method — pass any lat/lng (hardcoded or
  /// pulled live from your API/socket) and the marker + camera both
  /// move to it. This is what to call from a timer, a GPS stream
  /// listener, or a push notification handler once you wire in real
  /// vehicle tracking data.
  Future<void> moveCarTo(LatLng newPosition, {String label = 'Vehicle'}) async {
    setState(() {
      _carPosition = newPosition;
      _carLabel = label;
    });
    await _controller?.animateCamera(CameraUpdate.newLatLng(newPosition));
  }

  /// Steps to one of the hardcoded [demoWaypoints] above, purely for
  /// demoing movement without live data.
  void _goToWaypoint(int index) {
    _waypointIndex = index % demoWaypoints.length;
    final wp = demoWaypoints[_waypointIndex];
    moveCarTo(wp.position, label: wp.label);
  }

  void _nextWaypoint() => _goToWaypoint(_waypointIndex + 1);

  void _toggleAutoPlay() {
    if (_autoPlaying) {
      _autoTimer?.cancel();
      setState(() => _autoPlaying = false);
    } else {
      _autoTimer = Timer.periodic(const Duration(seconds: 4), (_) => _nextWaypoint());
      setState(() => _autoPlaying = true);
    }
  }

  @override
  void dispose() {
    _autoTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Map', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
        actions: [
          IconButton(
            icon: Icon(_autoPlaying ? Icons.pause_circle : Icons.play_circle, color: AppColors.brandPrimary),
            tooltip: _autoPlaying ? 'Stop simulating movement' : 'Simulate movement',
            onPressed: _toggleAutoPlay,
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: demoWaypoints.first.position, zoom: 13),
        markers: _markers,
        onMapCreated: (controller) => _controller = controller,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.brandPrimary,
        onPressed: _nextWaypoint,
        icon: const Icon(Icons.navigation, color: Colors.white),
        label: const Text('Next location', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
