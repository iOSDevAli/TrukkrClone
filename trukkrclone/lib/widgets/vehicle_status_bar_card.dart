import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../models/dashboard_models.dart';
import '../theme/app_theme.dart';

class VehicleStatusBarCard extends StatelessWidget {
  final List<VehicleStatus> statuses;

  const VehicleStatusBarCard({super.key, required this.statuses});

  int get _total => statuses.fold(0, (sum, s) => sum + s.count);

  @override
  Widget build(BuildContext context) {
    final maxCount = statuses.map((s) => s.count).fold(0, (a, b) => a > b ? a : b);
    final chartMax = (maxCount < 2 ? 2 : maxCount + 1).toDouble();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: AppColors.running.withValues(alpha: 0.15),
                        child: const Icon(Icons.local_shipping_rounded, color: AppColors.running, size: 18),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Vehicle Status', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: AppColors.textPrimary)),
                            Text('Current status of your fleet', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    height: 140,
                    child: BarChart(
                      BarChartData(
                        maxY: chartMax,
                        alignment: BarChartAlignment.spaceAround,
                        gridData: const FlGridData(show: true, drawVerticalLine: false, horizontalInterval: 1),
                        borderData: FlBorderData(show: false),
                        titlesData: FlTitlesData(
                          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 20,
                              interval: 1,
                              getTitlesWidget: (v, meta) => Text('${v.toInt()}', style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                            ),
                          ),
                          bottomTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),
                        barGroups: [
                          for (int i = 0; i < statuses.length; i++)
                            BarChartGroupData(
                              x: i,
                              barRods: [
                                BarChartRodData(
                                  toY: statuses[i].count.toDouble(),
                                  color: statuses[i].color,
                                  width: 20,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 4,
                    children: statuses
                        .map((s) => Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(width: 7, height: 7, decoration: BoxDecoration(color: s.color, shape: BoxShape.circle)),
                                const SizedBox(width: 4),
                                Text(s.label, style: const TextStyle(fontSize: 10, color: AppColors.textPrimary)),
                              ],
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 10),
                decoration: BoxDecoration(color: AppColors.running.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(16)),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.running.withValues(alpha: 0.2),
                      child: const Icon(Icons.local_shipping_rounded, color: AppColors.running, size: 20),
                    ),
                    const SizedBox(height: 14),
                    const Text('Total Vehicles', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                    const SizedBox(height: 8),
                    Text('$_total', style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
