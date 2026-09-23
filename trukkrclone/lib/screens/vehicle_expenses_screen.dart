import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
//import '../widgets/diagonal_pattern_background.dart';
import '../widgets/dashboard_header_banner.dart';
import '../widgets/dashboard_section_bottom_nav.dart';
import '../widgets/no_expenses_illustration.dart';

class VehicleExpensesScreen extends StatefulWidget {
  const VehicleExpensesScreen({super.key});

  @override
  State<VehicleExpensesScreen> createState() => _VehicleExpensesScreenState();
}

class _VehicleExpensesScreenState extends State<VehicleExpensesScreen> {
  int _sortIndex = 0; // 0 = Date, 1 = Vehicle, 2 = Amount

  static const _sorts = [
    (label: 'Date', icon: Icons.calendar_today_rounded),
    (label: 'Vehicle', icon: Icons.directions_car_rounded),
    (label: 'Amount', icon: Icons.paid_rounded),
  ];

  void _addExpense() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Add expense form is coming soon')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
      //     onPressed: () => Navigator.pop(context),
      //   ),
      //   title: const Text(
      //     'Vehicle Expenses',
      //     style: TextStyle(fontWeight: FontWeight.w700, fontSize: 19, color: AppColors.textPrimary),
      //   ),
      // ),
      // body: DiagonalPatternBackground(
      //   child: SafeArea(
      //     top: false,
      //     child: Padding(
      //       padding: const EdgeInsets.all(16),
      //       child: Column(
      //         children: [
      //           const Text('Total Amount: PKR 0.0',
      //               style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: AppColors.textPrimary)),
      //           const SizedBox(height: 12),
      //           Container(
      //             decoration: BoxDecoration(border: Border.all(color: const Color(0xFF9CA3AF))),
      //             child: const Row(
      //               children: [
      //                 Expanded(child: _HeaderCell('Date')),
      //                 Expanded(child: _HeaderCell('Vehicle')),
      //                 Expanded(child: _HeaderCell('Amount')),
      //               ],
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
      backgroundColor: const Color(0xFFF3F6FB),
      body: Column(
        children: [
          DashboardHeaderBanner(
            title: 'Vehicle Expenses',
            subtitle: 'Track and manage your vehicle expenses',
            leadingIcon: Icons.arrow_back,
            onLeadingTap: () => Navigator.pop(context),
          ),
          Expanded(
            child: Stack(
              children: [
                ListView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                  children: [
                    // Total amount card.
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            right: -6,
                            top: -6,
                            child: Opacity(
                              opacity: 0.5,
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  const Icon(Icons.account_balance_wallet_rounded, color: Color(0xFF3B82F6), size: 60),
                                  Positioned(
                                    right: -2,
                                    top: -10,
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      decoration: const BoxDecoration(color: Color(0xFFF6B93B), shape: BoxShape.circle),
                                      child: const Icon(Icons.attach_money_rounded, color: Colors.white, size: 14),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              CircleAvatar(radius: 26, backgroundColor: AppColors.navActiveBlue.withValues(alpha: 0.12), child: const Icon(Icons.account_balance_wallet_rounded, color: AppColors.navActiveBlue, size: 24)),
                              const SizedBox(width: 14),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Total Amount', style: TextStyle(fontSize: 13, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                                  const SizedBox(height: 4),
                                  const Text('PKR 0.0', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.headerNavyDark)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Sort-by pills.
                    Row(
                      children: List.generate(_sorts.length, (i) {
                        final sort = _sorts[i];
                        final active = i == _sortIndex;
                        return Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: i == _sorts.length - 1 ? 0 : 8),
                            child: InkWell(
                              onTap: () => setState(() => _sortIndex = i),
                              borderRadius: BorderRadius.circular(24),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: active ? AppColors.navActiveBlue : Colors.white,
                                  borderRadius: BorderRadius.circular(24),
                                  border: active ? null : Border.all(color: const Color(0xFFBFDBFE)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(sort.icon, size: 16, color: active ? Colors.white : AppColors.navActiveBlue),
                                    const SizedBox(width: 6),
                                    Text(sort.label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: active ? Colors.white : AppColors.navActiveBlue)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 40),

                    // Empty state.
                    const Center(child: NoExpensesIllustration()),
                    const SizedBox(height: 12),
                    const Text('No Vehicle Expenses Found', textAlign: TextAlign.center, style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: AppColors.headerNavyDark)),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        "You haven't added any vehicle expenses yet.\nTap the + button to add your first expense.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 13.5, color: AppColors.textSecondary.withValues(alpha: 0.9), height: 1.4),
                      ),
                    ),
                    const SizedBox(height: 60),
                  ],
                ),
                Positioned(
                  right: 16,
                  bottom: 16,
                  child: FloatingActionButton(
                    backgroundColor: AppColors.navActiveBlue,
                    onPressed: _addExpense,
                    child: const Icon(Icons.add, size: 28),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const DashboardSectionBottomNav(activeIndex: 0),
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
