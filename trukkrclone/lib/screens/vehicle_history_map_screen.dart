import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Placeholder map surface. Swap the Container below for a real
/// google_maps_flutter GoogleMap widget once an API key is configured
/// for Android (AndroidManifest.xml) and iOS (AppDelegate/Info.plist).
class VehicleHistoryMapScreen extends StatelessWidget {
  final String vehiclePlate;

  const VehicleHistoryMapScreen({super.key, required this.vehiclePlate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // --- Map placeholder ---
          Positioned.fill(
            child: Container(color: const Color(0xFFBFE3E0)),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(vehiclePlate, style: const TextStyle(fontWeight: FontWeight.w700)),
                ],
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            top: 140,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1F2937),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Icon(Icons.warning_amber_rounded, color: Colors.amber, size: 28),
                  const SizedBox(height: 8),
                  const Text(
                    'No record found for specific date and time range...',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.textPrimary,
                      shape: const StadiumBorder(),
                    ),
                    icon: const Icon(Icons.arrow_back, size: 16),
                    label: const Text('Back'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
