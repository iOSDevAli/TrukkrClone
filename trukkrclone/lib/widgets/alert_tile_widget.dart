import 'package:flutter/material.dart';
import '../models/dashboard_models.dart';

class AlertTileWidget extends StatelessWidget {
  final AlertTile tile;
  final VoidCallback? onTap;

  const AlertTileWidget({super.key, required this.tile, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: tile.gradient,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Row(
            children: [
              Icon(tile.icon, color: Colors.white, size: 22),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  tile.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
              CircleAvatar(
                radius: 14,
                backgroundColor: Colors.white,
                child: Text(
                  '${tile.count}',
                  style: TextStyle(
                    color: tile.gradient.first,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
