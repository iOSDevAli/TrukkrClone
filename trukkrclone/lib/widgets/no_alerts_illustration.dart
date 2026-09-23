import 'package:flutter/material.dart';

/// Decorative "all caught up" illustration for the Events and Alerts
/// empty state: a soft blob backdrop, a bell with sound-wave dashes,
/// a red "blocked" badge, and two small leaf accents.
class NoAlertsIllustration extends StatelessWidget {
  const NoAlertsIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      height: 170,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Soft blob backdrop.
          Container(
            width: 190,
            height: 150,
            decoration: BoxDecoration(
              color: const Color(0xFF2563EB).withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(70),
            ),
          ),
          // Ground shadow.
          Positioned(
            bottom: 6,
            child: Container(
              width: 150,
              height: 14,
              decoration: BoxDecoration(
                color: const Color(0xFF2563EB).withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          // Leaves.
          const Positioned(left: 18, bottom: 18, child: _Leaf(color: Color(0xFF60A5FA), angle: -0.5)),
          const Positioned(right: 18, bottom: 22, child: _Leaf(color: Color(0xFFA78BFA), angle: 0.5)),
          // Sound dashes.
          Positioned(
            left: 46,
            top: 46,
            child: Column(
              children: List.generate(
                3,
                (i) => Padding(
                  padding: EdgeInsets.only(bottom: 6, left: (2 - i) * 6.0),
                  child: Transform.rotate(
                    angle: -0.5,
                    child: Container(width: 14 + i * 4, height: 3, decoration: BoxDecoration(color: const Color(0xFF60A5FA), borderRadius: BorderRadius.circular(2))),
                  ),
                ),
              ),
            ),
          ),
          // Bell.
          const Icon(Icons.notifications_rounded, size: 84, color: Color(0xFF3B82F6)),
          // Blocked badge.
          Positioned(
            right: 58,
            bottom: 46,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: const Icon(Icons.block_rounded, color: Color(0xFFEF4444), size: 30),
            ),
          ),
        ],
      ),
    );
  }
}

class _Leaf extends StatelessWidget {
  final Color color;
  final double angle;
  const _Leaf({required this.color, required this.angle});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: Icon(Icons.eco_rounded, color: color.withValues(alpha: 0.7), size: 30),
    );
  }
}
