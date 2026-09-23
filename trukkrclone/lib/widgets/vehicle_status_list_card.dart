import 'package:flutter/material.dart';
import '../models/vehicle_status_entry.dart';
import '../theme/app_theme.dart';

class VehicleStatusListCard extends StatelessWidget {
  final VehicleStatusEntry vehicle;
  final VoidCallback? onTap;
  final VoidCallback? onLocationTap;
  final VoidCallback? onDetailsTap;

  const VehicleStatusListCard({super.key, required this.vehicle, this.onTap, this.onLocationTap, this.onDetailsTap});

  Widget _iconLine(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 3),
      child: Row(
        children: [
          Icon(icon, size: 13, color: AppColors.navActiveBlue),
          const SizedBox(width: 6),
          Text(text, style: const TextStyle(fontSize: 12.5, color: AppColors.textSecondary)),
        ],
      ),
    );
  }

  Widget _circleIcon(IconData icon, VoidCallback? onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: CircleAvatar(radius: 15, backgroundColor: const Color(0xFFEAF2FE), child: Icon(icon, size: 15, color: AppColors.navActiveBlue)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = vehicle.status.color;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 66,
                    height: 66,
                    decoration: BoxDecoration(color: vehicle.thumbnailTint.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(14)),
                    child: Icon(Icons.local_shipping_rounded, color: vehicle.thumbnailTint, size: 34),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(vehicle.code, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: AppColors.headerNavyDark)),
                        _iconLine(Icons.badge_outlined, vehicle.plate),
                        _iconLine(Icons.person_outline, vehicle.driver),
                        _iconLine(Icons.location_on_outlined, vehicle.location),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(color: color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(width: 7, height: 7, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
                                const SizedBox(width: 6),
                                Text(vehicle.status.label, style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 12.5)),
                              ],
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(Icons.chevron_right, color: AppColors.textSecondary, size: 18),
                        ],
                      ),
                      const SizedBox(height: 22),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _circleIcon(Icons.location_on_rounded, onLocationTap),
                          Container(height: 16, width: 1, margin: const EdgeInsets.symmetric(horizontal: 8), color: const Color(0xFFE5E7EB)),
                          _circleIcon(Icons.description_outlined, onDetailsTap),
                          const SizedBox(width: 4),
                          GestureDetector(
                            onTap: onDetailsTap,
                            child: const Text('Details', style: TextStyle(fontSize: 11, color: AppColors.navActiveBlue, fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
