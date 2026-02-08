import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/hourse_race_result.dart';
import '../providers/race_provider.dart';
import 'result_chart_painter.dart';

class HorseSearchResultDialog extends ConsumerWidget {
  const HorseSearchResultDialog({super.key, required this.hourseName});

  final String hourseName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncResults = ref.watch(
      resultByHourseNameProvider(hourseName: hourseName),
    );

    return Dialog(
      backgroundColor: const Color(0xFF1A1A2E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.75,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0F3460), Color(0xFF16213E)],
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Text(
                hourseName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Flexible(
              child: asyncResults.when(
                loading: () => const Padding(
                  padding: EdgeInsets.all(32),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF53C0F0),
                      strokeWidth: 2,
                    ),
                  ),
                ),
                error: (error, _) => Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    'Error: $error',
                    style: const TextStyle(color: Color(0xFFE94560)),
                  ),
                ),
                data: (results) {
                  if (results.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(24),
                      child: Text(
                        '該当する馬が見つかりません',
                        style: TextStyle(color: Colors.white54),
                      ),
                    );
                  }

                  return _buildResultContent(results);
                },
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildResultContent(List<HourseRaceResult> results) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      children: [
        if (results.length >= 2) _buildResultChart(results),
        ...results.map((r) {
          final date = '${r.year}/${r.month}/${r.day}';
          final place = r.result ?? 0;

          Color placeColor;
          if (place == 1) {
            placeColor = const Color(0xFFFFD700);
          } else if (place == 2) {
            placeColor = const Color(0xFFC0C0C0);
          } else if (place == 3) {
            placeColor = const Color(0xFFCD7F32);
          } else {
            placeColor = Colors.white54;
          }

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                SizedBox(
                  width: 28,
                  child: Text(
                    '$place',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: placeColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 80,
                  child: Text(
                    date,
                    style: const TextStyle(
                      color: Color(0xFF53C0F0),
                      fontSize: 12,
                      fontFeatures: [FontFeature.tabularFigures()],
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    r.raceName ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  r.raceTime ?? '',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontFeatures: [FontFeature.tabularFigures()],
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildResultChart(List<HourseRaceResult> results) {
    final data = <int>[];
    for (final r in results) {
      final v = r.result ?? 0;
      if (v > 0) data.add(v);
    }
    if (data.length < 2) return const SizedBox.shrink();

    const maxVal = 20;

    return Container(
      height: 340,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.fromLTRB(28, 12, 12, 24),
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F1A),
        borderRadius: BorderRadius.circular(8),
      ),
      child: CustomPaint(
        size: Size.infinite,
        painter: ResultChartPainter(
          data: data,
          maxVal: maxVal,
          dates: results.map((r) => '${r.month}/${r.day}').toList(),
        ),
      ),
    );
  }
}
