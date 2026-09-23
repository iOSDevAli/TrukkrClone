import 'package:flutter/material.dart';

class VehicleListCard extends StatelessWidget {
  final String plate;
  final VoidCallback onTap;
  final void Function(Offset globalPosition) onMenuTap;

  const VehicleListCard({
    super.key,
    required this.plate,
    required this.onTap,
    required this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (details) => onTap(),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 6, offset: const Offset(0, 2)),
          ],
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundColor: Color(0xFFF3F4F6),
              child: Icon(Icons.directions_car, color: Colors.red, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(plate, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
            ),
            Builder(
              builder: (iconContext) => IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  final box = iconContext.findRenderObject() as RenderBox;
                  final pos = box.localToGlobal(Offset(box.size.width / 2, box.size.height / 2));
                  onMenuTap(pos);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
