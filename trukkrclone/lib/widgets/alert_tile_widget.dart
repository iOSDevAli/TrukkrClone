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
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(tile.icon, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  tile.title,
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    //fontSize: 12,
                    fontSize: 13,
                    height: 1.15,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              CircleAvatar(
                radius: 13,
                backgroundColor: Colors.white,
                child: Text(
                  '${tile.count}',
                  style: TextStyle(
                    color: tile.gradient.first,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
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
