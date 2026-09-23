import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
//import '../widgets/diagonal_pattern_background.dart';
import '../widgets/dashboard_header_banner.dart';
import '../widgets/settings_list_row.dart';
import 'login_screen.dart';
import 'maintenance_schedule_screen.dart';
import 'add_maintenance_schedule_screen.dart';
import 'vehicle_expenses_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _playAlertsAnnouncement = true;

  Future<void> _confirmLogout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Log out?'),
        content: const Text('You\'ll need to sign in again to access your account.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Log out', style: TextStyle(color: AppColors.stopped, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
    if (confirmed == true && mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  void _stub(String label) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$label is coming soon')));
  }

  Widget _sectionHeader(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 10, top: 4),
      child: Row(
        children: [
          Icon(icon, color: AppColors.navActiveBlue, size: 20),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: AppColors.navActiveBlue)),
        ],
      ),
    );
  }

  Widget _pillChevron(String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(color: AppColors.navActiveBlue.withValues(alpha: 0.10), borderRadius: BorderRadius.circular(20)),
          child: Text(text, style: const TextStyle(color: AppColors.navActiveBlue, fontWeight: FontWeight.w700, fontSize: 12.5)),
        ),
        const SizedBox(width: 6),
        CircleAvatar(radius: 15, backgroundColor: AppColors.navActiveBlue.withValues(alpha: 0.10), child: const Icon(Icons.chevron_right, color: AppColors.navActiveBlue, size: 18)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: const Text('Settings', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26, color: AppColors.textPrimary)),
      // ),
      // body: DiagonalPatternBackground(
      //   child: SafeArea(
      //     top: false,
      //     child: ListView(
      //       padding: const EdgeInsets.only(bottom: 24),
      //       children: [
      //         _SectionHeader(icon: Icons.person, label: 'Profile'),
      //         _SettingsRow(
      //           iconBg: AppColors.textPrimary,
      //           icon: Icons.person,
      //           title: 'softwaredemo@trukkr.pk',
      //           trailing: _pillButton('Logout', () {}),
      //         ),
      //         _SettingsRow(
      //           iconBg: AppColors.running,
      //           icon: Icons.vpn_key,
      //           title: 'Password',
      //           trailing: _pillButton('Change', () {}),
      //         ),
      //         _SectionHeader(icon: Icons.settings, label: 'Tools'),
      //         _SettingsRow(
      //           iconBg: AppColors.iconReports,
      //           icon: Icons.grid_view,
      //           title: 'Geofence Settings',
      //           trailing: const Icon(Icons.arrow_forward, color: AppColors.textSecondary),
      //           onTap: () {},
      //         ),
      //         _SettingsRow(
      //           iconBg: AppColors.brandPrimary,
      //           icon: Icons.notifications,
      //           title: 'Alerts Settings',
      //           trailing: const Icon(Icons.arrow_forward, color: AppColors.textSecondary),
      //           onTap: () {},
      //         ),
      //         _SettingsRow(
      //           iconBg: AppColors.brandPrimary,
      //           icon: Icons.campaign,
      //           title: 'Play Alerts Announcement',
      //           trailing: Checkbox(
      //             value: _playAlertsAnnouncement,
      //             activeColor: AppColors.brandPrimary,
      //             onChanged: (v) => setState(() => _playAlertsAnnouncement = v ?? true),
      //           ),
      //         ),
      //         _SettingsRow(
      //           iconBg: AppColors.iconMoney,
      //           icon: Icons.local_gas_station,
      //           title: 'Fuel Cost : PKR 2.5/l',
      //           trailing: _pillButton('Set Price', () {}),
      //         ),
      //         _SettingsRow(
      //           iconBg: AppColors.iconMoney,
      //           icon: Icons.attach_money,
      //           title: 'Vehicle Expenses',
      //           trailing: const Text('PKR 0.0', style: TextStyle(fontWeight: FontWeight.w600)),
      //           onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const VehicleExpensesScreen())),
      //         ),
      //         _SettingsRow(
      //           iconBg: AppColors.iconMaintenance,
      //           icon: Icons.directions_car,
      //           title: 'Maintenance',
      //           trailing: Row(
      //             mainAxisSize: MainAxisSize.min,
      //             children: [
      //               const CircleAvatar(radius: 12, backgroundColor: Color(0xFFE5E7EB), child: Text('0', style: TextStyle(fontSize: 12))),
      //               const SizedBox(width: 8),
      //               InkWell(
      //                 borderRadius: BorderRadius.circular(20),
      //                 onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MaintenanceScheduleScreen())),
      //                 child: const CircleAvatar(radius: 14, backgroundColor: AppColors.running, child: Icon(Icons.add, color: Colors.white, size: 16)),
      //               ),
      //             ],
      //           ),
      //         ),
      //         _SettingsRow(
      //           iconBg: null,
      //           icon: null,
      //           title: 'Privacy Policy',
      //           trailing: const Icon(Icons.arrow_forward, color: AppColors.textSecondary),
      //           onTap: () {},
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
backgroundColor: const Color(0xFFF3F6FB),
      body: Column(
        children: [
          DashboardHeaderBanner(
            title: 'Settings',
            subtitle: 'Manage your account and app preferences',
            leadingIcon: Icons.arrow_back,
            onLeadingTap: () => Navigator.maybePop(context),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              children: [
                _sectionHeader(Icons.person, 'Profile'),
                SettingsListRow(
                  icon: Icons.person,
                  iconColor: AppColors.navActiveBlue,
                  iconBg: AppColors.navActiveBlue.withValues(alpha: 0.12),
                  title: 'Profile Information',
                  subtitle: 'View and manage your personal details.',
                  onTap: () => _stub('Profile Information'),
                ),
                SettingsListRow(
                  icon: Icons.vpn_key_rounded,
                  iconColor: const Color(0xFF0F9D8C),
                  iconBg: const Color(0xFFD1FAE5),
                  title: 'Change Password',
                  subtitle: 'Update your account password.',
                  onTap: () => _stub('Change Password'),
                ),
                SettingsListRow(
                  icon: Icons.logout_rounded,
                  iconColor: AppColors.stopped,
                  iconBg: AppColors.stopped.withValues(alpha: 0.15),
                  cardTint: AppColors.stopped.withValues(alpha: 0.06),
                  title: 'Logout',
                  titleColor: AppColors.stopped,
                  subtitle: 'Sign out from your account.',
                  onTap: _confirmLogout,
                ),
                const SizedBox(height: 10),
                _sectionHeader(Icons.settings, 'Tools'),
                SettingsListRow(
                  icon: Icons.location_on_rounded,
                  iconColor: AppColors.navActiveBlue,
                  iconBg: AppColors.navActiveBlue.withValues(alpha: 0.12),
                  title: 'Geofence Settings',
                  subtitle: 'Set geofence areas and alerts.',
                  onTap: () => _stub('Geofence Settings'),
                ),
                SettingsListRow(
                  icon: Icons.notifications_rounded,
                  iconColor: const Color(0xFF7C3AED),
                  iconBg: const Color(0xFFEDE9FE),
                  title: 'Alerts Settings',
                  subtitle: 'Manage notification preferences.',
                  onTap: () => _stub('Alerts Settings'),
                ),
                SettingsListRow(
                  icon: Icons.volume_up_rounded,
                  iconColor: const Color(0xFFDB2777),
                  iconBg: const Color(0xFFFCE7F3),
                  title: 'Play Alerts Announcement',
                  subtitle: 'Enable or disable alert sounds.',
                  trailing: Switch(
                    value: _playAlertsAnnouncement,
                    activeThumbColor: Colors.white,
                    activeTrackColor: AppColors.navActiveBlue,
                    onChanged: (v) => setState(() => _playAlertsAnnouncement = v),
                  ),
                ),
                SettingsListRow(
                  icon: Icons.local_gas_station_rounded,
                  iconColor: const Color(0xFFEA580C),
                  iconBg: const Color(0xFFFFEDD5),
                  title: 'Fuel Cost',
                  subtitle: 'Set fuel price per liter.',
                  trailing: _pillChevron('PKR 2.5/L'),
                  onTap: () => _stub('Fuel Cost'),
                ),
                SettingsListRow(
                  icon: Icons.account_balance_wallet_rounded,
                  iconColor: AppColors.navActiveBlue,
                  iconBg: AppColors.navActiveBlue.withValues(alpha: 0.12),
                  title: 'Vehicle Expenses',
                  subtitle: 'Manage vehicle expense settings.',
                  trailing: _pillChevron('PKR 0.0'),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const VehicleExpensesScreen())),
                ),
                SettingsListRow(
                  icon: Icons.build_rounded,
                  iconColor: AppColors.stopped,
                  iconBg: AppColors.stopped.withValues(alpha: 0.15),
                  title: 'Maintenance',
                  subtitle: 'Set maintenance reminders.',
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(color: AppColors.navActiveBlue.withValues(alpha: 0.10), borderRadius: BorderRadius.circular(20)),
                        child: const Text('0', style: TextStyle(color: AppColors.navActiveBlue, fontWeight: FontWeight.w700, fontSize: 12.5)),
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddMaintenanceScheduleScreen())),
                        child: CircleAvatar(radius: 15, backgroundColor: AppColors.navActiveBlue.withValues(alpha: 0.10), child: const Icon(Icons.add, color: AppColors.navActiveBlue, size: 18)),
                      ),
                    ],
                  ),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MaintenanceScheduleScreen())),
                ),
                SettingsListRow(
                  icon: Icons.shield_rounded,
                  iconColor: const Color(0xFF0F9D8C),
                  iconBg: const Color(0xFFD1FAE5),
                  title: 'Privacy Policy',
                  subtitle: 'Read our privacy policy and terms.',
                  onTap: () => _stub('Privacy Policy'),
                ),
              ],
            ),
          ),
        ],
      ),

    );
  }

  // Widget _pillButton(String label, VoidCallback onTap) {
  //   return ElevatedButton(
  //     onPressed: onTap,
  //     style: ElevatedButton.styleFrom(
  //       backgroundColor: AppColors.brandPrimary.withValues(alpha: 0.7),
  //       shape: const StadiumBorder(),
  //       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //     ),
  //     child: Text(label, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
  //   );
  // }
}

// class _SectionHeader extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   const _SectionHeader({required this.icon, required this.label});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       color: AppColors.brandPrimary.withValues(alpha: 0.35),
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       margin: const EdgeInsets.only(top: 4),
//       child: Row(
//         children: [
//           Icon(icon, size: 18, color: AppColors.textPrimary),
//           const SizedBox(width: 8),
//           Text(label, style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
//         ],
//       ),
//     );
//   }
// }

// class _SettingsRow extends StatelessWidget {
//   final Color? iconBg;
//   final IconData? icon;
//   final String title;
//   final Widget trailing;
//   final VoidCallback? onTap;

//   const _SettingsRow({
//     required this.iconBg,
//     required this.icon,
//     required this.title,
//     required this.trailing,
//     this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//         decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(28)),
//         child: Row(
//           children: [
//             if (icon != null) ...[
//               CircleAvatar(radius: 18, backgroundColor: iconBg, child: Icon(icon, color: Colors.white, size: 18)),
//               const SizedBox(width: 14),
//             ],
//             Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15))),
//             trailing,
//           ],
//         ),
//       ),
//     );
//   }
// }
