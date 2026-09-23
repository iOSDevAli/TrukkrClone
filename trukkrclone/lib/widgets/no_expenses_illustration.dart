import 'package:flutter/material.dart';

/// Decorative "no expenses" illustration: a document with a car icon
/// and text-line placeholders, a dollar badge, leaf accents, and a
/// small cloud — built from shapes, matching the style established by
/// NoAlertsIllustration.
class NoExpensesIllustration extends StatelessWidget {
  const NoExpensesIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      height: 220,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 220,
            height: 200,
            decoration: BoxDecoration(color: const Color(0xFF2563EB).withValues(alpha: 0.06), borderRadius: BorderRadius.circular(90)),
          ),
          Positioned(top: 10, left: 30, child: Icon(Icons.cloud, color: const Color(0xFF60A5FA).withValues(alpha: 0.5), size: 22)),
          Positioned(top: 60, right: 30, child: Icon(Icons.cloud, color: const Color(0xFF60A5FA).withValues(alpha: 0.3), size: 16)),
          const Positioned(left: 20, bottom: 30, child: _Leaf(angle: -0.5)),
          Positioned(
            top: 40,
            right: 60,
            child: Column(
              children: List.generate(
                3,
                (i) => Padding(
                  padding: EdgeInsets.only(bottom: 6, left: (2 - i) * 6.0),
                  child: Transform.rotate(
                    angle: -0.5,
                    child: Container(width: 12 + i * 4, height: 3, decoration: BoxDecoration(color: const Color(0xFF60A5FA), borderRadius: BorderRadius.circular(2))),
                  ),
                ),
              ),
            ),
          ),
          // The document card.
          Container(
            width: 130,
            height: 160,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 12, offset: const Offset(0, 6))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.directions_car_rounded, color: Color(0xFF3B82F6), size: 30),
                const SizedBox(height: 14),
                Container(height: 4, width: double.infinity, decoration: BoxDecoration(color: const Color(0xFFDCE7F7), borderRadius: BorderRadius.circular(2))),
                const SizedBox(height: 8),
                Container(height: 4, width: 70, decoration: BoxDecoration(color: const Color(0xFFDCE7F7), borderRadius: BorderRadius.circular(2))),
                const SizedBox(height: 8),
                Container(height: 4, width: 90, decoration: BoxDecoration(color: const Color(0xFFDCE7F7), borderRadius: BorderRadius.circular(2))),
                const SizedBox(height: 8),
                Container(height: 4, width: 60, decoration: BoxDecoration(color: const Color(0xFFDCE7F7), borderRadius: BorderRadius.circular(2))),
              ],
            ),
          ),
          // Dollar badge, overlapping the document's bottom-right corner.
          Positioned(
            right: 55,
            bottom: 45,
            child: Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(color: Color(0xFF2563EB), shape: BoxShape.circle),
              child: const Icon(Icons.attach_money_rounded, color: Colors.white, size: 24),
            ),
          ),
        ],
      ),
    );
  }
}

class _Leaf extends StatelessWidget {
  final double angle;
  const _Leaf({required this.angle});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: Icon(Icons.eco_rounded, color: const Color(0xFF60A5FA).withValues(alpha: 0.6), size: 34),
    );
  }
}
