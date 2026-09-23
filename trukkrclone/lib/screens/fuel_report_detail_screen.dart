import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
//import '../widgets/diagonal_pattern_background.dart';
import '../widgets/dashboard_header_banner.dart';
import '../widgets/duration_row_card.dart';
import '../widgets/fuel_stat_tile.dart';

/// The Fuel Report result screen, reached after picking a vehicle and a
/// date range. The numeric fields below are demo values matching the
/// reference design — wire them up to real report data once the API
/// for this is ready.
class FuelReportDetailScreen extends StatelessWidget {
  final String vehiclePlate;
  //  final DateTime? from;
  //  final DateTime? to;
  final DateTime from;
  final DateTime to;
  final double distanceKm;
  final double fuelUsedLiters;
  final double fuelCost;
  final double fuelPricePerLiter;
  final double vehicleAverageKmPerLiter;
  final Duration moveDuration;
  final Duration stopDuration;

  // const FuelReportDetailScreen({
  FuelReportDetailScreen({
    super.key, 
    required this.vehiclePlate,
    DateTime? from,
    DateTime? to,
    // this.from,
    // this.to,
    this.distanceKm = 105.07,
    this.fuelUsedLiters = 8.08,
    this.fuelCost = 20.21,
    this.fuelPricePerLiter = 2.5,
    this.vehicleAverageKmPerLiter = 13.0,
    this.moveDuration = const Duration(hours: 3, minutes: 9),
    this.stopDuration = const Duration(hours: 8, minutes: 6, seconds: 40),
  })  : from = from ?? DateTime.now(),
        to = to ?? DateTime.now();

  String _fmtDate(DateTime d) => '${d.day.toString().padLeft(2, '0')}-${d.month.toString().padLeft(2, '0')}-${(d.year % 100).toString().padLeft(2, '0')}';

  String _fmtDuration(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes % 60;
    final s = d.inSeconds % 60;
    return '${h}h ${m}min ${s}s';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
      //     onPressed: () => Navigator.pop(context),
      //   ),
      //   title: const Text('Fuel Report', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
      // ),
      // body: DiagonalPatternBackground(
      //   child: SafeArea(
      //     top: false,
      //     child: Padding(
      //       padding: const EdgeInsets.all(16),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Text(vehiclePlate, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
      //           const SizedBox(height: 12),
      //           Container(
      //             decoration: BoxDecoration(border: Border.all(color: const Color(0xFF9CA3AF))),
      //             child: const Row(
      //               children: [
      //                 Expanded(child: _HeaderCell('Date')),
      //                 Expanded(child: _HeaderCell('Fuel Level')),
      //                 Expanded(child: _HeaderCell('Distance')),
      //               ],
      //             ),
      //           ),
      //           const Expanded(
      //             child: Center(
      //               child: Text('No fuel data found', style: TextStyle(color: AppColors.textPrimary)),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      backgroundColor: const Color(0xFFF3F6FB),
      body: Column(
        children: [
          DashboardHeaderBanner(
            title: 'Fuel Report',
            subtitle: 'View detailed fuel usage and costs',
            leadingIcon: Icons.arrow_back,
            onLeadingTap: () => Navigator.pop(context),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              children: [
                // Vehicle + date range summary card.
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            CircleAvatar(radius: 22, backgroundColor: AppColors.navActiveBlue.withValues(alpha: 0.12), child: const Icon(Icons.local_shipping_rounded, color: AppColors.navActiveBlue, size: 20)),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Vehicle', style: TextStyle(fontSize: 12, color: AppColors.navActiveBlue, fontWeight: FontWeight.w600)),
                                  Text(vehiclePlate, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.headerNavyDark)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          decoration: BoxDecoration(color: const Color(0xFFEAF2FE), borderRadius: BorderRadius.circular(14)),
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_today_rounded, color: AppColors.navActiveBlue, size: 18),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('From - To', style: TextStyle(fontSize: 11, color: AppColors.navActiveBlue, fontWeight: FontWeight.w600)),
                                    //Text('${_fmtDate(from!)}  →  ${_fmtDate(to!)}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.headerNavyDark)),
                                    Text('${_fmtDate(from)}  →  ${_fmtDate(to)}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.headerNavyDark)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // Stats grid.
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: FuelStatTile(icon: Icons.location_on_rounded, color: AppColors.running, tint: AppColors.running.withValues(alpha: 0.15), label: 'Distance', value: '${distanceKm.toStringAsFixed(2)} Km'),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: FuelStatTile(icon: Icons.local_gas_station_rounded, color: AppColors.navActiveBlue, tint: AppColors.navActiveBlue.withValues(alpha: 0.12), label: 'Fuel Used', value: '${fuelUsedLiters.toStringAsFixed(2)} liter'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: FuelStatTile(icon: Icons.currency_rupee_rounded, color: const Color(0xFFEA580C), tint: const Color(0xFFFFEDD5), label: 'Fuel Cost', value: 'PKR ${fuelCost.toStringAsFixed(2)}'),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: FuelStatTile(icon: Icons.water_drop_rounded, color: const Color(0xFF7C3AED), tint: const Color(0xFFEDE9FE), label: 'Fuel Price', value: '$fuelPricePerLiter AED / liter'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: FuelStatTile(icon: Icons.speed_rounded, color: const Color(0xFF0F7A72), tint: const Color(0xFFD1FAE5), label: 'Vehicle Average', value: '${vehicleAverageKmPerLiter.toStringAsFixed(1)} Km/l'),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(child: SizedBox()),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                DurationRowCard(
                  icon: Icons.access_time_filled_rounded,
                  color: AppColors.navActiveBlue,
                  tint: Colors.white,
                  backgroundTint: AppColors.navActiveBlue.withValues(alpha: 0.08),
                  label: 'Move Duration',
                  value: _fmtDuration(moveDuration),
                  onTap: () {},
                ),
                const SizedBox(height: 12),
                DurationRowCard(
                  icon: Icons.do_not_disturb_on_rounded,
                  color: AppColors.stopped,
                  tint: Colors.white,
                  backgroundTint: AppColors.stopped.withValues(alpha: 0.08),
                  label: 'Stop Duration',
                  value: _fmtDuration(stopDuration),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],

      ),
    );
  }
}

// class _HeaderCell extends StatelessWidget {
//   final String text;
//   const _HeaderCell(this.text);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       child: Text(text, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w700)),
//     );
//   }
// }
