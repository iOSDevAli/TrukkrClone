// import 'package:flutter/material.dart';
// import '../models/event_alert.dart';
// import '../theme/app_theme.dart';

// class EventAlertRow extends StatelessWidget {
//   final EventAlert alert;
//   final EventAlertVisuals visuals;

//   const EventAlertRow({super.key, required this.alert, required this.visuals});

//   String _formatTime(DateTime dt) {
//     final h = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
//     final m = dt.minute.toString().padLeft(2, '0');
//     final period = dt.hour >= 12 ? 'PM' : 'AM';
//     return '$h:$m $period';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(14),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.04),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           CircleAvatar(
//             radius: 20,
//             backgroundColor: visuals.color.withValues(alpha: 0.15),
//             child: Icon(visuals.icon, color: visuals.color, size: 20),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   alert.vehicleName,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 14,
//                     color: AppColors.textPrimary,
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   alert.message,
//                   style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
//                 ),
//               ],
//             ),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Text(
//                 alert.type,
//                 style: TextStyle(
//                   fontSize: 11,
//                   fontWeight: FontWeight.w600,
//                   color: visuals.color,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 _formatTime(alert.timestamp),
//                 style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
