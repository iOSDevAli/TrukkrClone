import 'package:flutter/material.dart';
import '../models/vehicle_ref.dart';
import '../theme/app_theme.dart';
import '../widgets/diagonal_pattern_background.dart';
import '../widgets/quick_range_menu.dart';
import '../widgets/vehicle_list_card.dart';

/// A search bar + list of vehicles, matching Fuel Report / Vehicle
/// History / Vehicle Reports. Tapping a vehicle (or its 3-dot menu)
/// opens the Today/Yesterday/7 Days/30 Days/Custom Date popup; the
/// selection is handed to [onRangeChosen].
class VehiclePickerScreen extends StatefulWidget {
  final String title;
  final String searchHint;
  final List<VehicleRef> vehicles;
  final void Function(BuildContext context, VehicleRef vehicle, QuickRange range) onRangeChosen;

  const VehiclePickerScreen({
    super.key,
    required this.title,
    required this.onRangeChosen,
    this.searchHint = 'Search Vehicle',
    this.vehicles = demoVehicles,
  });

  @override
  State<VehiclePickerScreen> createState() => _VehiclePickerScreenState();
}

class _VehiclePickerScreenState extends State<VehiclePickerScreen> {
  final _searchController = TextEditingController();
  late List<VehicleRef> _visible;

  @override
  void initState() {
    super.initState();
    _visible = widget.vehicles;
    _searchController.addListener(() {
      final q = _searchController.text.trim().toLowerCase();
      setState(() {
        _visible = q.isEmpty
            ? widget.vehicles
            : widget.vehicles.where((v) => v.plate.toLowerCase().contains(q)).toList();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _openMenu(VehicleRef vehicle, Offset position) async {
    final range = await showQuickRangeMenu(context: context, tapPosition: position);
    if (range != null && mounted) {
      widget.onRangeChosen(context, vehicle, range);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(widget.title,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 19, color: AppColors.textPrimary)),
      ),
      body: DiagonalPatternBackground(
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: widget.searchHint,
                    hintStyle: const TextStyle(color: AppColors.textSecondary),
                    suffixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
                    border: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFD1D5DB))),
                    enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFD1D5DB))),
                    focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.bottomNavActive)),
                  ),
                ),
              ),
              Expanded(
                child: _visible.isEmpty
                    ? const Center(child: Text('No vehicles found', style: TextStyle(color: AppColors.textPrimary)))
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                        itemCount: _visible.length,
                        itemBuilder: (context, i) {
                          final v = _visible[i];
                          return VehicleListCard(
                            plate: v.plate,
                            onTap: () async {
                              // Approximate the popup near the row when tapped directly.
                              final renderBox = context.findRenderObject() as RenderBox?;
                              final pos = renderBox?.localToGlobal(const Offset(60, 40)) ?? Offset.zero;
                              await _openMenu(v, pos);
                            },
                            onMenuTap: (pos) => _openMenu(v, pos),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
