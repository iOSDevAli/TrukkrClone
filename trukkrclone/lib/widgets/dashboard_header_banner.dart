import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// The curved navy hero header used at the top of the Dashboard and
/// other primary screens.
///
/// Two layouts:
/// - Stacked (default): leading icon on its own row, then a large
///   title + subtitle below (Dashboard, Add Maintenance Schedule).
/// - Inline (`inlineTitle: true`): leading icon and title share one
///   row, no subtitle — for screens like Events and Alerts that also
///   need trailing action buttons in that same row.
class DashboardHeaderBanner extends StatelessWidget {
  //final VoidCallback? onMenuTap;
  final String title;
  final String? subtitle;
  final IconData leadingIcon;
  final VoidCallback? onLeadingTap;
  final List<Widget>? actions;
  final bool showTruckIllustration;
  final bool showCloud;
  final bool inlineTitle;

  const DashboardHeaderBanner({
    super.key, 
    // this.onMenuTap
    this.title = 'Dashboard',
    this.subtitle = 'Fleet Management',
    this.leadingIcon = Icons.menu,
    this.onLeadingTap,
    this.actions,
    this.showTruckIllustration = true,
    this.showCloud = true,
    this.inlineTitle = false,
    });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      // clipper: _CurvedBottomClipper(),
      // child: Container(
      //   width: double.infinity,
      //   padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 12, bottom: 44, left: 20, right: 20),
      //   decoration: const BoxDecoration(
      //     gradient: LinearGradient(
      //       begin: Alignment.topLeft,
      //       end: Alignment.bottomRight,
      //       colors: [AppColors.headerNavyDark, AppColors.headerNavyLight],
      //     ),
      //   ),
      //   child: Stack(
      //     clipBehavior: Clip.none,
      //     children: [
      //       // Decorative cloud + truck illustration, right side.
      //       Positioned(
      //         right: -6,
      //         top: 6,
      //         child: Opacity(
      //           opacity: 0.9,
      //           child: Row(
      //             crossAxisAlignment: CrossAxisAlignment.end,
      //             children: [
      //               Padding(
      //                 padding: const EdgeInsets.only(bottom: 26, right: 4),
      //                 child: Icon(Icons.cloud, color: Colors.white.withValues(alpha: 0.35), size: 22),
      //               ),
      //               const Icon(Icons.local_shipping_rounded, color: Colors.white, size: 56),
      //             ],
      //           ),
      //         ),
      //       ),
      //       Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Row(
      //             children: [
      //               InkWell(
      //                 onTap: onMenuTap,
      //                 borderRadius: BorderRadius.circular(8),
      //                 child: const Padding(
      //                   padding: EdgeInsets.all(4),
      //                   child: Icon(Icons.menu, color: Colors.white, size: 26),
      //                 ),
      //               ),
      //             ],
      //           ),
      //           const SizedBox(height: 10),
      //           const Text(
      //             'Dashboard',
      //             style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w700),
      //           ),
      //           const SizedBox(height: 2),
      //           Text(
      //             'Fleet Management',
      //             style: TextStyle(color: Colors.white.withValues(alpha: 0.75), fontSize: 14),
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
    clipper: _CurvedBottomClipper(),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 12,
          bottom: inlineTitle ? 30 : 44,
          left: 20,
          right: 20,
        ),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.headerNavyDark, AppColors.headerNavyLight],
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            if (showTruckIllustration)
              Positioned(
                right: -6,
                top: 6,
                child: Opacity(
                  opacity: 0.9,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (showCloud)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 26, right: 4),
                          child: Icon(Icons.cloud, color: Colors.white.withValues(alpha: 0.35), size: 22),
                        ),
                      const Icon(Icons.local_shipping_rounded, color: Colors.white, size: 56),
                    ],
                  ),
                ),
              )
            else if (showCloud && !inlineTitle)
              Positioned(
                right: 90,
                top: 4,
                child: Icon(Icons.cloud, color: Colors.white.withValues(alpha: 0.3), size: 26),
              ),
            if (inlineTitle)
              Row(
                children: [
                  InkWell(
                    onTap: onLeadingTap,
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(padding: const EdgeInsets.all(4), child: Icon(leadingIcon, color: Colors.white, size: 24)),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700)),
                  ),
                  if (showCloud)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Icon(Icons.cloud, color: Colors.white.withValues(alpha: 0.3), size: 22),
                    ),
                  if (actions != null)
                    Row(
                      children: [
                        for (int i = 0; i < actions!.length; i++) ...[
                          if (i > 0) const SizedBox(width: 10),
                          actions![i],
                        ],
                      ],
                    ),
                ],
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: onLeadingTap,
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(padding: const EdgeInsets.all(4), child: Icon(leadingIcon, color: Colors.white, size: 26)),
                      ),
                      const Spacer(),
                      if (actions != null)
                        Row(
                          children: [
                            for (int i = 0; i < actions!.length; i++) ...[
                              if (i > 0) const SizedBox(width: 10),
                              actions![i],
                            ],
                          ],
                        ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(title, style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w700)),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(subtitle!, style: TextStyle(color: Colors.white.withValues(alpha: 0.75), fontSize: 14)),
                  ],
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _CurvedBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 28);
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height - 28);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
