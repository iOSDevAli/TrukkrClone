import 'package:flutter/material.dart';

/// The stylized highway scene at the bottom of the splash screen: soft
/// mountains, a city skyline silhouette, a curving road with guardrails,
/// a location pin, a couple of birds, and a simplified truck — built
/// from shapes since no illustration asset is available.
class SplashRoadScene extends StatelessWidget {
  final double height;
  const SplashRoadScene({super.key, this.height = 260});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: CustomPaint(painter: _RoadScenePainter()),
    );
  }
}

class _RoadScenePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    _drawMountains(canvas, w, h);
    _drawSkyline(canvas, w, h);
    _drawBirds(canvas, w, h);
    _drawRoad(canvas, w, h);
    _drawLocationPin(canvas, w, h);
    _drawTruck(canvas, w, h);
  }

  void _drawMountains(Canvas canvas, double w, double h) {
    final paint = Paint()..color = const Color(0xFFBFD9F2);
    final path = Path()
      ..moveTo(0, h * 0.55)
      ..lineTo(w * 0.10, h * 0.30)
      ..lineTo(w * 0.20, h * 0.48)
      ..lineTo(w * 0.30, h * 0.28)
      ..lineTo(w * 0.42, h * 0.50)
      ..lineTo(0, h * 0.50)
      ..close();
    canvas.drawPath(path, paint);
  }

  void _drawSkyline(Canvas canvas, double w, double h) {
    final paint = Paint()..color = const Color(0xFFA9CCEE);
    final baseY = h * 0.48;
    final buildings = [
      (x: w * 0.60, bw: w * 0.05, bh: h * 0.14),
      (x: w * 0.66, bw: w * 0.06, bh: h * 0.22),
      (x: w * 0.73, bw: w * 0.04, bh: h * 0.10),
      (x: w * 0.80, bw: w * 0.06, bh: h * 0.20),
      (x: w * 0.87, bw: w * 0.05, bh: h * 0.13),
      (x: w * 0.93, bw: w * 0.05, bh: h * 0.17),
    ];
    for (final b in buildings) {
      canvas.drawRect(Rect.fromLTWH(b.x, baseY - b.bh, b.bw, b.bh), paint);
    }
    // Tower with a small ball finial.
    final towerX = w * 0.71;
    canvas.drawRect(Rect.fromLTWH(towerX, baseY - h * 0.34, w * 0.012, h * 0.34), paint);
    canvas.drawCircle(Offset(towerX + w * 0.006, baseY - h * 0.36), 3, paint);
  }

  void _drawBirds(Canvas canvas, double w, double h) {
    final paint = Paint()
      ..color = const Color(0xFF6FA8DC)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..strokeCap = StrokeCap.round;
    void bird(double cx, double cy, double s) {
      final path = Path()
        ..moveTo(cx - s, cy)
        ..quadraticBezierTo(cx - s / 2, cy - s, cx, cy)
        ..quadraticBezierTo(cx + s / 2, cy - s, cx + s, cy);
      canvas.drawPath(path, paint);
    }

    bird(w * 0.28, h * 0.20, 6);
    bird(w * 0.33, h * 0.26, 5);
    bird(w * 0.90, h * 0.10, 6);
  }

  void _drawRoad(Canvas canvas, double w, double h) {
    final roadPaint = Paint()..color = const Color(0xFFD9E7F5);
    final roadPath = Path()
      ..moveTo(0, h * 0.86)
      ..lineTo(w * 0.42, h * 0.62)
      ..lineTo(w * 0.62, h * 0.62)
      ..lineTo(w, h * 0.80)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();
    canvas.drawPath(roadPath, roadPaint);

    // Dashed center line.
    final dashPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    for (double t = 0.05; t < 0.95; t += 0.12) {
      final start = Offset(w * (0.20 + t * 0.35), h * (0.86 - t * 0.20));
      final end = Offset(start.dx + w * 0.03, start.dy - h * 0.01);
      canvas.drawLine(start, end, dashPaint);
    }

    // Guardrails.
    final railPaint = Paint()
      ..color = const Color(0xFF9DBEE0)
      ..strokeWidth = 2;
    canvas.drawLine(Offset(0, h * 0.90), Offset(w * 0.40, h * 0.68), railPaint);
    canvas.drawLine(Offset(w * 0.66, h * 0.66), Offset(w, h * 0.84), railPaint);
  }

  void _drawLocationPin(Canvas canvas, double w, double h) {
    final pinPaint = Paint()..color = const Color(0xFF2563EB);
    final cx = w * 0.10;
    final cy = h * 0.72;
    canvas.drawLine(Offset(cx, cy), Offset(cx, cy + h * 0.12), Paint()..color = const Color(0xFF9DBEE0)..strokeWidth = 2);
    canvas.drawCircle(Offset(cx, cy - 6), 9, pinPaint);
    canvas.drawCircle(Offset(cx, cy - 6), 3.5, Paint()..color = Colors.white);
  }

  void _drawTruck(Canvas canvas, double w, double h) {
    final baseY = h * 0.80;
    final trailerPaint = Paint()..color = const Color(0xFFF3F5F8);
    final cabPaint = Paint()..color = Colors.white;
    final darkPaint = Paint()..color = const Color(0xFF1C1F26);
    final windowPaint = Paint()..color = const Color(0xFF3B5C82);
    final wheelPaint = Paint()..color = const Color(0xFF2B2F38);
    final hubPaint = Paint()..color = const Color(0xFFB9C2CC);

    final trailerLeft = w * 0.44;
    final trailerWidth = w * 0.24;
    final trailerHeight = h * 0.20;
    final trailerRect = Rect.fromLTWH(trailerLeft, baseY - trailerHeight, trailerWidth, trailerHeight);
    canvas.drawRRect(RRect.fromRectAndCorners(trailerRect, topLeft: const Radius.circular(4), topRight: const Radius.circular(2)), trailerPaint);
    canvas.drawRect(Rect.fromLTWH(trailerLeft, baseY - 3, trailerWidth, 3), darkPaint);

    // Cab.
    final cabLeft = trailerLeft + trailerWidth - 2;
    final cabWidth = w * 0.16;
    final cabPath = Path()
      ..moveTo(cabLeft, baseY)
      ..lineTo(cabLeft, baseY - trailerHeight * 0.55)
      ..lineTo(cabLeft + cabWidth * 0.35, baseY - trailerHeight * 0.55)
      ..lineTo(cabLeft + cabWidth * 0.55, baseY - trailerHeight * 0.95)
      ..lineTo(cabLeft + cabWidth, baseY - trailerHeight * 0.95)
      ..lineTo(cabLeft + cabWidth, baseY)
      ..close();
    canvas.drawPath(cabPath, cabPaint);
    canvas.drawPath(cabPath, Paint()..color = const Color(0xFFD8DEE6)..style = PaintingStyle.stroke..strokeWidth = 1);

    // Windshield.
    final windshield = Path()
      ..moveTo(cabLeft + cabWidth * 0.40, baseY - trailerHeight * 0.58)
      ..lineTo(cabLeft + cabWidth * 0.58, baseY - trailerHeight * 0.90)
      ..lineTo(cabLeft + cabWidth * 0.94, baseY - trailerHeight * 0.90)
      ..lineTo(cabLeft + cabWidth * 0.94, baseY - trailerHeight * 0.58)
      ..close();
    canvas.drawPath(windshield, windowPaint);

    // Front bumper / grille accent.
    canvas.drawRect(Rect.fromLTWH(cabLeft + cabWidth - 6, baseY - trailerHeight * 0.30, 6, trailerHeight * 0.30), darkPaint);

    // Wheels.
    final wheelY = baseY + 2;
    for (final wx in [trailerLeft + trailerWidth * 0.22, trailerLeft + trailerWidth * 0.55, cabLeft + cabWidth * 0.62]) {
      canvas.drawCircle(Offset(wx, wheelY), 8, wheelPaint);
      canvas.drawCircle(Offset(wx, wheelY), 3, hubPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
