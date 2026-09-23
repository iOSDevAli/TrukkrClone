import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
//import '../widgets/diagonal_pattern_background.dart';
import '../widgets/dashboard_header_banner.dart';
import '../widgets/status_count_card.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({super.key});

  void _stub(BuildContext context, String label) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$label is coming soon')));
  }

  @override
  Widget build(BuildContext context) {
    final counts = [
      (label: 'Total', count: 1, icon: Icons.local_shipping_rounded, color: AppColors.navActiveBlue),
      (label: 'Running', count: 0, icon: Icons.play_arrow_rounded, color: AppColors.running),
      (label: 'Stop', count: 1, icon: Icons.stop_rounded, color: AppColors.stopped),
      (label: 'Idle', count: 0, icon: Icons.schedule_rounded, color: const Color(0xFFF59E0B)),
      (label: 'Offline', count: 0, icon: Icons.wifi_off_rounded, color: const Color(0xFF7C3AED)),
      (label: 'No data', count: 0, icon: Icons.block_rounded, color: const Color(0xFF9CA3AF)),
      (label: 'Expired', count: 0, icon: Icons.error_rounded, color: AppColors.stopped),
    ];
    
    return Scaffold(
      // body: DiagonalPatternBackground(
      //   child: SafeArea(
      //     child: Padding(
      //       padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           const TextField(
      //             decoration: InputDecoration(
      //               hintText: 'Search Vehicle or Group',
      //               hintStyle: TextStyle(color: AppColors.textSecondary),
      //               suffixIcon: Icon(Icons.search, color: AppColors.textSecondary),
      //               border: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFD1D5DB))),
      //               enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFD1D5DB))),
      //             ),
      //           ),
      //           const SizedBox(height: 14),
      //           Row(
      //             children: const [
      //               _CountBadge(label: 'Total', count: 1, color: AppColors.textPrimary),
      //               _CountBadge(label: 'Running', count: 0, color: AppColors.running),
      //               _CountBadge(label: 'Stop', count: 1, color: AppColors.stopped),
      //               _CountBadge(label: 'Idle', count: 0, color: AppColors.idle),
      //               _CountBadge(label: 'Offline', count: 0, color: AppColors.offline),
      //               _CountBadge(label: 'No data', count: 0, color: Color(0xFF9CA3AF)),
      //               _CountBadge(label: 'Expired', count: 0, color: AppColors.expired),
      //             ],
      //           ),
      //           const SizedBox(height: 16),
      //           const _VehicleStatusCard(),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
      backgroundColor: const Color(0xFFF3F6FB),
      body: Column(
        children: [
          DashboardHeaderBanner(
            title: 'Vehicle Status',
            subtitle: 'Live status and current information',
            onLeadingTap: () => _stub(context, 'Menu'),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              children: [
                // Vehicle + group selector row.
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => _stub(context, 'Vehicle switcher'),
                          borderRadius: BorderRadius.circular(12),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircleAvatar(radius: 16, backgroundColor: AppColors.navActiveBlue.withValues(alpha: 0.12), child: const Icon(Icons.local_shipping_rounded, color: AppColors.navActiveBlue, size: 16)),
                                const SizedBox(width: 8),
                                const Text('JF-3632', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: AppColors.headerNavyDark)),
                                const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textSecondary, size: 18),
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => _stub(context, 'Group switcher'),
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(color: AppColors.navActiveBlue.withValues(alpha: 0.10), borderRadius: BorderRadius.circular(20)),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.group_rounded, color: AppColors.navActiveBlue, size: 16),
                              SizedBox(width: 6),
                              Text('Group: Ungrouped', style: TextStyle(color: AppColors.navActiveBlue, fontWeight: FontWeight.w700, fontSize: 12.5)),
                              Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.navActiveBlue, size: 16),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // Status counts.
                SizedBox(
                  height: 96,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: counts.map((c) => StatusCountCard(label: c.label, count: c.count, icon: c.icon, color: c.color, tint: c.color.withValues(alpha: 0.12))).toList(),
                  ),
                ),
                const SizedBox(height: 16),

                // Vehicle detail card.
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(radius: 20, backgroundColor: AppColors.navActiveBlue.withValues(alpha: 0.12), child: const Icon(Icons.local_shipping_rounded, color: AppColors.navActiveBlue, size: 20)),
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(color: AppColors.navActiveBlue, borderRadius: BorderRadius.circular(20)),
                            child: const Text('JF-3632', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 15)),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(color: AppColors.stopped.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(width: 7, height: 7, decoration: const BoxDecoration(color: AppColors.stopped, shape: BoxShape.circle)),
                                const SizedBox(width: 6),
                                const Text('Stopped', style: TextStyle(color: AppColors.stopped, fontWeight: FontWeight.w700, fontSize: 13)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                        decoration: BoxDecoration(color: const Color(0xFFF7F9FC), borderRadius: BorderRadius.circular(16)),
                        child: Row(
                          children: [
                            Expanded(
                              child: _MiniStat(icon: Icons.speed_rounded, label: 'Speed', value: '0 km/h'),
                            ),
                            Expanded(
                              child: _MiniStat(
                                icon: Icons.hub_rounded,
                                label: 'Status',
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(color: AppColors.stopped.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(10)),
                                      child: const Text('Stop', style: TextStyle(color: AppColors.stopped, fontWeight: FontWeight.w800, fontSize: 12.5)),
                                    ),
                                    const SizedBox(width: 6),
                                    const Text('3min 51s', style: TextStyle(fontSize: 11.5, color: AppColors.textSecondary)),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: _MiniStat(icon: Icons.access_time_filled_rounded, label: 'Update', value: '07-09-2026\n05:50:45 PM'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Divider(color: Color(0xFFE5E7EB), height: 1),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(child: _IconStatColumn(icon: Icons.lock_rounded, iconColor: AppColors.running, label: 'Ignition', value: 'Off')),
                          Expanded(child: _IconStatColumn(icon: Icons.wifi_rounded, iconColor: const Color(0xFFF59E0B), label: 'GPS', value: 'Online')),
                          Expanded(child: _IconStatColumn(icon: Icons.vpn_key_rounded, iconColor: AppColors.stopped, label: 'Door', value: 'Closed')),
                          Expanded(child: _IconStatColumn(icon: Icons.battery_charging_full_rounded, iconColor: AppColors.running, label: 'Battery', value: '0 V')),
                          Expanded(child: _IconStatColumn(icon: Icons.local_gas_station_rounded, iconColor: AppColors.running, label: 'Fuel', value: '0%')),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(color: AppColors.navActiveBlue.withValues(alpha: 0.06), borderRadius: BorderRadius.circular(14)),
                        child: Row(
                          children: [
                            const Icon(Icons.location_on_rounded, color: AppColors.navActiveBlue, size: 18),
                            const SizedBox(width: 10),
                            const Expanded(
                              child: Text(
                                'Ghous-e-Azam, واورنگی روڈ, Orangi Sector 11, ضلع اورنگی, کراچي ٹوٙن, سنده, 75840, پاکستان',
                                style: TextStyle(fontSize: 12.5, color: AppColors.headerNavyDark),
                              ),
                            ),
                            const SizedBox(width: 6),
                            CircleAvatar(radius: 14, backgroundColor: AppColors.navActiveBlue.withValues(alpha: 0.12), child: const Icon(Icons.chevron_right, color: AppColors.navActiveBlue, size: 16)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),

                // Decorative footer.
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Column(
                      children: [
                        Text('Track • Monitor • Stay Connected', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textSecondary.withValues(alpha: 0.8))),
                        const SizedBox(height: 4),
                        Text('Your vehicle, always in sight', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: AppColors.textSecondary.withValues(alpha: 0.6))),
                      ],
                    ),
                    Positioned(
                      right: 20,
                      top: -10,
                      child: Icon(Icons.location_on, size: 60, color: AppColors.navActiveBlue.withValues(alpha: 0.35)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class _CountBadge extends StatelessWidget {
//   final String label;
//   final int count;
//   final Color color;
//   const _CountBadge({required this.label, required this.count, required this.color});

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Column(
//         children: [
//           Container(
//             width: 34,
//             height: 34,
//             alignment: Alignment.center,
//             decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(6)),
//             child: Text('$count', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
//           ),
//           const SizedBox(height: 4),
//           Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
//         ],
//       ),
//     );
//   }
// }

// class _VehicleStatusCard extends StatelessWidget {
//   const _VehicleStatusCard();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(color: AppColors.stopped.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(14)),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                 decoration: BoxDecoration(color: AppColors.stopped, borderRadius: BorderRadius.circular(6)),
//                 child: const Text('JF-3632', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
//               ),
//               const Spacer(),
//               const Text('Group: ', style: TextStyle(color: AppColors.textPrimary)),
//               const Text('Ungrouped', style: TextStyle(color: AppColors.stopped, fontWeight: FontWeight.w700)),
//             ],
//           ),
//           const SizedBox(height: 10),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: const [
//                     _InfoLine(icon: Icons.speed, label: 'Speed:', value: '0 km/h'),
//                     SizedBox(height: 6),
//                     _InfoLine(icon: Icons.share_location, label: 'Status:', value: 'Stop  2h 17min 51s', valueColor: AppColors.stopped),
//                     SizedBox(height: 6),
//                     _InfoLine(icon: Icons.access_time, label: 'Update', value: '04-09-2026 12:24:55 AM'),
//                   ],
//                 ),
//               ),
//               const CircleAvatar(
//                 radius: 26,
//                 backgroundColor: Colors.white,
//                 child: Icon(Icons.directions_car, color: Colors.red, size: 26),
//               ),
//             ],
//           ),
//           const SizedBox(height: 10),
//           Row(
//             children: const [
//               Icon(Icons.lock_open, color: AppColors.running, size: 22),
//               SizedBox(width: 14),
//               Icon(Icons.wifi, color: AppColors.brandSecondary, size: 22),
//               SizedBox(width: 14),
//               Icon(Icons.vpn_key, color: AppColors.stopped, size: 22),
//               SizedBox(width: 14),
//               Icon(Icons.bolt, color: AppColors.running, size: 22),
//               SizedBox(width: 14),
//               Icon(Icons.battery_full, color: AppColors.textSecondary, size: 22),
//               SizedBox(width: 4),
//               Text('0 V', style: TextStyle(fontSize: 12)),
//             ],
//           ),
//           const SizedBox(height: 10),
//           const Text(
//             'Qasba Colony Road, Pahar Ganj Colony, Qasba Colony, Site Town, Karachi Division, Sindh, 75760, Pakistan',
//             style: TextStyle(fontSize: 12, color: AppColors.textPrimary),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _InfoLine extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final String value;
//   final Color? valueColor;
//   const _InfoLine({required this.icon, required this.label, required this.value, this.valueColor});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Icon(icon, size: 15, color: AppColors.textSecondary),
//         const SizedBox(width: 6),
//         Text('$label ', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
//         Text(value, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: valueColor ?? AppColors.textPrimary)),
//       ],
//     );
//   }
// }

class _MiniStat extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? value;
  final Widget? child;

  const _MiniStat({required this.icon, required this.label, this.value, this.child});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(radius: 16, backgroundColor: AppColors.navActiveBlue.withValues(alpha: 0.12), child: Icon(icon, color: AppColors.navActiveBlue, size: 16)),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
              const SizedBox(height: 2),
              child ?? Text(value ?? '', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.headerNavyDark)),
            ],
          ),
        ),
      ],
    );
  }
}

class _IconStatColumn extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  const _IconStatColumn({required this.icon, required this.iconColor, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(radius: 18, backgroundColor: iconColor.withValues(alpha: 0.15), child: Icon(icon, color: iconColor, size: 18)),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
        Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.headerNavyDark)),
      ],
    );
  }
}
