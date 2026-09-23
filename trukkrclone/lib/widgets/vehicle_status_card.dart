import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../models/dashboard_models.dart';
import '../theme/app_theme.dart';

class VehicleStatusCard extends StatelessWidget {
  final List<VehicleStatus> statuses;

  const VehicleStatusCard({super.key, required this.statuses});

  int get _total => statuses.fold(0, (sum, s) => sum + s.count);

  @override
  Widget build(BuildContext context) {
    // fl_chart needs non-zero sections to render; fall back to a single
    // full-circle "no data" ring if every count is zero.
    final hasData = _total > 0;

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
        child: Column(
          children: [
            Text('Vehicle Status', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5,
                  child: SizedBox(
                    height: 190,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        PieChart(
                          PieChartData(
                            sectionsSpace: 2,
                            centerSpaceRadius: 62,
                            startDegreeOffset: -90,
                            sections: hasData
                                ? statuses
                                    .where((s) => s.count > 0)
                                    .map(
                                      (s) => PieChartSectionData(
                                        value: s.count.toDouble(),
                                        color: s.color,
                                        radius: 34,
                                        showTitle: false,
                                      ),
                                    )
                                    .toList()
                                : [
                                    PieChartSectionData(
                                      value: 1,
                                      // color: AppColors.noData.withValues(alpha: 0.9),
                                      color: AppColors.noData.withValues(alpha: 0.3),
                                      radius: 34,
                                      showTitle: false,
                                    ),
                                  ],
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '$_total',
                              style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                        // Small count label under the ring, matching the
                        // reference screenshot's "1" beneath the circle.
                        if (hasData)
                          Positioned(
                            bottom: 6,
                            child: Text(
                              '$_total',
                              style: const TextStyle(
                                //fontSize: 14,
                                fontSize: 12,
                                //color: AppColors.textSecondary,
                                color: Colors.black,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: statuses
                        .map((s) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Row(
                                children: [
                                  Icon(Icons.autorenew, size: 16, color: s.color),
                                  const SizedBox(width: 8),
                                  Text(
                                    s.label,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: AppColors.textPrimary, // running,stopped, etc
                                      //color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
