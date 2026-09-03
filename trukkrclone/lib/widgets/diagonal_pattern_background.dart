import 'package:flutter/material.dart';

/// The soft diagonal parallelogram pattern that sits behind content on
/// the Dashboard and Events and Alerts screens. Purely decorative —
/// painted once and reused wherever the app needs that same texture.
class DiagonalPatternBackground extends StatelessWidget {
  final Widget child;

  const DiagonalPatternBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: CustomPaint(painter: _DiagonalPatternPainter()),
        ),
        child,
      ],
    );
  }
}

class _DiagonalPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bands = [
      (color: const Color(0xFFEDEBE7), offset: 0.55),
      (color: const Color(0xFFE3DED4), offset: 0.68),
      (color: const Color(0xFFEFEAE1), offset: 0.80),
      (color: const Color(0xFFE0D9CB), offset: 0.92),
    ];

    const bandWidth = 0.09; // fraction of width
    const skew = 0.18; // horizontal shear per band

    for (final band in bands) {
      final path = Path();
      final xTop = size.width * band.offset;
      final xBottom = xTop - size.width * skew;
      final w = size.width * bandWidth;

      path.moveTo(xTop, 0);
      path.lineTo(xTop + w, 0);
      path.lineTo(xBottom + w, size.height);
      path.lineTo(xBottom, size.height);
      path.close();

      canvas.drawPath(path, Paint()..color = band.color);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
