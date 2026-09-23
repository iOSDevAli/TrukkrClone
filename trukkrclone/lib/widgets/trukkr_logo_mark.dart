import 'package:flutter/material.dart';

/// The small truck-shaped logo mark used on the splash screen —
/// a simplified geometric truck silhouette (red flag/roof accent,
/// blue cab body, yellow wheel arc), built from shapes rather than
/// an image asset.
class TrukkrLogoMark extends StatelessWidget {
  final double size;
  const TrukkrLogoMark({super.key, this.size = 64});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _LogoMarkPainter()),
    );
  }
}

class _LogoMarkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Yellow wheel arc, bottom-left.
    final yellowPaint = Paint()..color = const Color(0xFFF6B93B);
    canvas.drawArc(Rect.fromLTWH(0, h * 0.55, w * 0.62, h * 0.62), 3.14159, 3.14159, true, yellowPaint);

    // Blue cab body (rounded rect).
    final bluePaint = Paint()..color = const Color(0xFF2563EB);
    final bodyRect = RRect.fromRectAndRadius(Rect.fromLTWH(w * 0.28, h * 0.20, w * 0.44, h * 0.62), Radius.circular(w * 0.08));
    canvas.drawRRect(bodyRect, bluePaint);

    // White window.
    final windowPaint = Paint()..color = Colors.white;
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(w * 0.38, h * 0.30, w * 0.16, h * 0.18), Radius.circular(w * 0.02)), windowPaint);

    // Red flag/roof accent, top-left, pointing right.
    final redPaint = Paint()..color = const Color(0xFFE5484D);
    final flagPath = Path()
      ..moveTo(w * 0.22, h * 0.22)
      ..lineTo(w * 0.62, h * 0.06)
      ..lineTo(w * 0.62, h * 0.24)
      ..lineTo(w * 0.28, h * 0.24)
      ..close();
    canvas.drawPath(flagPath, redPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
