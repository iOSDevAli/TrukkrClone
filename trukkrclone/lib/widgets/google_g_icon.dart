import 'package:flutter/material.dart';

/// A small "G" logo mark in Google's brand colors, built from arcs
/// since no image asset is available — used on the "Continue with
/// Google" button.
class GoogleGIcon extends StatelessWidget {
  final double size;
  const GoogleGIcon({super.key, this.size = 20});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: size, height: size, child: CustomPaint(painter: _GooglePainter()));
  }
}

class _GooglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final r = size.width / 2;
    final center = Offset(r, r);
    final strokeWidth = size.width * 0.22;
    final rect = Rect.fromCircle(center: center, radius: r - strokeWidth / 2);

    void arc(double startDeg, double sweepDeg, Color color) {
      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.butt;
      canvas.drawArc(rect, startDeg * 3.14159 / 180, sweepDeg * 3.14159 / 180, false, paint);
    }

    arc(-45, 100, const Color(0xFF4285F4)); // blue
    arc(55, 80, const Color(0xFF34A853)); // green
    arc(135, 80, const Color(0xFFFBBC05)); // yellow
    arc(215, 80, const Color(0xFFEA4335)); // red

    // Horizontal bar of the G.
    final barPaint = Paint()..color = const Color(0xFF4285F4);
    canvas.drawRect(Rect.fromLTWH(center.dx, center.dy - strokeWidth / 2, r - strokeWidth * 0.3, strokeWidth), barPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
