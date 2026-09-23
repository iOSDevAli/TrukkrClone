import 'package:flutter/material.dart';
import '../models/vehicle_ref.dart';
import '../theme/app_theme.dart';
//import '../widgets/diagonal_pattern_background.dart';
import '../widgets/dashboard_header_banner.dart';
import '../widgets/select_date_dialog.dart';
import '../widgets/select_time_dialog.dart';

class AddMaintenanceScheduleScreen extends StatefulWidget {
  const AddMaintenanceScheduleScreen({super.key});

  @override
  State<AddMaintenanceScheduleScreen> createState() => _AddMaintenanceScheduleScreenState();
}

class _AddMaintenanceScheduleScreenState extends State<AddMaintenanceScheduleScreen> {
  DateTime? _date;
  TimeOfDay? _time;
  String? _option;
  String? _vehicleId;
  final _descriptionController = TextEditingController();

  static const _options = ['Oil Change', 'Tyre Rotation', 'Inspection', 'Other'];

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showTrukkrDatePicker(
      context: context,
      initialDate: _date ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 2),
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTrukkrTimePicker(context: context, initialTime: _time ?? TimeOfDay.now());
    if (picked != null) setState(() => _time = picked);
  }

  Future<void> _pickOption() async {
    final picked = await showModalBottomSheet<String>(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: _options
              .map((o) => ListTile(title: Text(o), onTap: () => Navigator.pop(ctx, o)))
              .toList(),
        ),
      ),
    );
    if (picked != null) setState(() => _option = picked);
  }

  Future<void> _pickVehicle() async {
    final picked = await showModalBottomSheet<String>(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: demoVehicles
              .map((v) => ListTile(title: Text(v.plate), onTap: () => Navigator.pop(ctx, v.plate)))
              .toList(),
        ),
      ),
    );
    if (picked != null) setState(() => _vehicleId = picked);
  }

  // void _save() {
  //   Navigator.pop(context, true);
  // }
  void _save() => Navigator.pop(context, true);

  void _resetForm() {
    setState(() {
      _date = null;
      _time = null;
      _option = null;
      _vehicleId = null;
      _descriptionController.clear();
    });
  }

  Future<void> _confirmClearForm() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('This will clear everything you\'ve entered on this form.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('No')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Yes')),
        ],
      ),
    );
    if (confirmed == true) _resetForm();
  }

  Widget _circleAction({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.18), shape: BoxShape.circle),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }

  String _fmtDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}-${d.month.toString().padLeft(2, '0')}-${d.year}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
      //     onPressed: () => Navigator.pop(context),
      //   ),
      //   title: const Text(
      //     'Add Maintenance Schedule',
      //     style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18, color: AppColors.textPrimary),
      //   ),
      // ),
      // body: DiagonalPatternBackground(
      //   child: SafeArea(
      //     top: false,
      //     child: SingleChildScrollView(
      //       padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.center,
      //         children: [
      //           const Text(
      //             'Add maintenance schedule with reminder',
      //             style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
      //           ),
      //           const SizedBox(height: 20),

      //           _FieldRow(
      //             label: _date == null ? 'Maintenance Date' : '${_date!.day}/${_date!.month}/${_date!.year}',
      //             icon: Icons.calendar_today_outlined,
      //             onTap: _pickDate,
      //           ),
      //           _FieldRow(
      //             label: _time == null ? 'Maintenance Time' : _time!.format(context),
      //             icon: Icons.access_time,
      //             onTap: _pickTime,
      //           ),
      //           _DropdownFieldRow(
      //             label: 'Select an option',
      //             value: _option,
      //             items: _options,
      //             onChanged: (v) => setState(() => _option = v),
      //           ),
      //           Container(
      //             margin: const EdgeInsets.only(bottom: 4),
      //             child: TextField(
      //               controller: _descriptionController,
      //               decoration: const InputDecoration(
      //                 hintText: 'Maintenance Description',
      //                 hintStyle: TextStyle(color: AppColors.textSecondary),
      //                 border: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF9CA3AF))),
      //                 enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF9CA3AF))),
      //               ),
      //             ),
      //           ),
      //           const SizedBox(height: 16),
      //           _DropdownFieldRow(
      //             label: 'Select Vehicle',
      //             value: _vehicleId,
      //             items: demoVehicles.map((v) => v.plate).toList(),
      //             onChanged: (v) => setState(() => _vehicleId = v),
      //           ),
      //           const SizedBox(height: 24),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               ElevatedButton(
      //                 onPressed: _save,
      //                 style: ElevatedButton.styleFrom(backgroundColor: AppColors.brandSecondary),
      //                 child: const Text('Save', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w700)),
      //               ),
      //               const SizedBox(width: 16),
      //               ElevatedButton(
      //                 onPressed: () => Navigator.pop(context),
      //                 style: ElevatedButton.styleFrom(backgroundColor: AppColors.brandSecondary),
      //                 child: const Text('Close', style: TextStyle(color: AppColors.textPrimary)),
      //               ),
      //             ],
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
       backgroundColor: const Color(0xFFF3F6FB),
      body: Column(
        children: [
          DashboardHeaderBanner(
            title: 'Add Maintenance Schedule',
            subtitle: 'Add maintenance schedule with reminder',
            leadingIcon: Icons.arrow_back,
            onLeadingTap: () => Navigator.pop(context),
            actions: [
              _circleAction(icon: Icons.refresh, onTap: _resetForm),
              _circleAction(icon: Icons.delete_outline, onTap: _confirmClearForm),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 16, offset: const Offset(0, 6))],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _FieldGroup(
                      icon: Icons.calendar_today_rounded,
                      iconColor: const Color(0xFF2563EB),
                      iconBg: const Color(0xFFDBEAFE),
                      label: 'Maintenance Date',
                      child: _PickerBox(
                        fieldTint: const Color(0xFFEAF2FE),
                        leadingIcon: Icons.calendar_today_rounded,
                        leadingIconColor: const Color(0xFF2563EB),
                        text: _date == null ? null : _fmtDate(_date!),
                        placeholder: 'Select date',
                        onTap: _pickDate,
                      ),
                    ),
                    const SizedBox(height: 18),
                    _FieldGroup(
                      icon: Icons.access_time_filled_rounded,
                      iconColor: const Color(0xFF7C3AED),
                      iconBg: const Color(0xFFEDE9FE),
                      label: 'Maintenance Time',
                      child: _PickerBox(
                        fieldTint: const Color(0xFFF1EEFE),
                        leadingIcon: Icons.access_time_filled_rounded,
                        leadingIconColor: const Color(0xFF7C3AED),
                        text: _time?.format(context),
                        placeholder: 'Select time',
                        onTap: _pickTime,
                      ),
                    ),
                    const SizedBox(height: 18),
                    _FieldGroup(
                      icon: Icons.format_list_bulleted_rounded,
                      iconColor: const Color(0xFF059669),
                      iconBg: const Color(0xFFD1FAE5),
                      label: 'Select an option',
                      child: _PickerBox(
                        fieldTint: const Color(0xFFEAFBF3),
                        leadingIcon: null,
                        leadingIconColor: const Color(0xFF059669),
                        text: _option,
                        placeholder: 'Select an option',
                        onTap: _pickOption,
                      ),
                    ),
                    const SizedBox(height: 18),
                    _FieldGroup(
                      icon: Icons.description_rounded,
                      iconColor: const Color(0xFF2563EB),
                      iconBg: const Color(0xFFDBEAFE),
                      label: 'Maintenance Description',
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(color: const Color(0xFFEAF2FE), borderRadius: BorderRadius.circular(14)),
                            child: TextField(
                              controller: _descriptionController,
                              maxLines: 4,
                              style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
                              decoration: const InputDecoration(
                                hintText: 'Enter description...',
                                hintStyle: TextStyle(color: AppColors.textSecondary),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(14),
                              ),
                            ),
                          ),
                          const Positioned(
                            right: 8,
                            bottom: 8,
                            child: Icon(Icons.drag_indicator_rounded, size: 14, color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    _FieldGroup(
                      icon: Icons.local_shipping_rounded,
                      iconColor: const Color(0xFF7C3AED),
                      iconBg: const Color(0xFFEDE9FE),
                      label: 'Select Vehicle',
                      child: _PickerBox(
                        fieldTint: const Color(0xFFF1EEFE),
                        leadingIcon: null,
                        leadingIconColor: const Color(0xFF7C3AED),
                        text: _vehicleId,
                        placeholder: 'Select Vehicle',
                        onTap: _pickVehicle,
                      ),
                    ),
                    const SizedBox(height: 22),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _save,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF7EC8F0),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              elevation: 0,
                            ),
                            icon: const Icon(Icons.save_rounded, size: 18),
                            label: const Text('Save', style: TextStyle(fontWeight: FontWeight.w700)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFDCEBFA),
                              foregroundColor: AppColors.headerNavyDark,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              elevation: 0,
                            ),
                            icon: const Icon(Icons.close_rounded, size: 18),
                            label: const Text('Close', style: TextStyle(fontWeight: FontWeight.w700)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class _FieldRow extends StatelessWidget {
//   final String label;
//   final IconData icon;
//   final VoidCallback onTap;

//   const _FieldRow({required this.label, required this.icon, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 14),
//         decoration: const BoxDecoration(
//           border: Border(bottom: BorderSide(color: Color(0xFF9CA3AF))),
//         ),
//         child: Row(
//           children: [
//             Expanded(child: Text(label, style: const TextStyle(fontSize: 16, color: AppColors.textPrimary))),
//             Icon(icon, color: AppColors.textSecondary),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _DropdownFieldRow extends StatelessWidget {
//   final String label;
//   final String? value;
//   final List<String> items;
//   final ValueChanged<String?> onChanged;

//   const _DropdownFieldRow({
//     required this.label,
//     required this.value,
//     required this.items,
//     required this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.only(bottom: 4),
//       decoration: const BoxDecoration(
//         border: Border(bottom: BorderSide(color: Color(0xFF9CA3AF))),
//       ),
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton<String>(
//           value: value,
//           hint: Text(label, style: const TextStyle(fontSize: 16, color: AppColors.textPrimary)),
//           isExpanded: true,
//           items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
//           onChanged: onChanged,
//         ),
//       ),
//     );
//   }
// }

/// Icon circle + bold label above a field, matching the mockup's row shape.
class _FieldGroup extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String label;
  final Widget child;

  const _FieldGroup({required this.icon, required this.iconColor, required this.iconBg, required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(radius: 18, backgroundColor: iconBg, child: Icon(icon, color: iconColor, size: 18)),
            const SizedBox(width: 10),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: AppColors.headerNavyDark)),
          ],
        ),
        const SizedBox(height: 10),
        child,
      ],
    );
  }
}

/// A tappable, tinted rounded field showing either the picked value or a
/// placeholder, with an optional leading icon and a trailing chevron-down —
/// used for date/time/dropdown-style fields.
class _PickerBox extends StatelessWidget {
  final Color fieldTint;
  final IconData? leadingIcon;
  final Color leadingIconColor;
  final String? text;
  final String placeholder;
  final VoidCallback onTap;

  const _PickerBox({
    required this.fieldTint,
    required this.leadingIcon,
    required this.leadingIconColor,
    required this.text,
    required this.placeholder,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(color: fieldTint, borderRadius: BorderRadius.circular(14)),
        child: Row(
          children: [
            if (leadingIcon != null) ...[
              Icon(leadingIcon, size: 18, color: leadingIconColor),
              const SizedBox(width: 10),
            ],
            Expanded(
              child: Text(
                text ?? placeholder,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: text == null ? FontWeight.w400 : FontWeight.w600,
                  color: text == null ? AppColors.textSecondary : AppColors.headerNavyDark,
                ),
              ),
            ),
            const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textSecondary, size: 22),
          ],
        ),
      ),
    );
  }
}