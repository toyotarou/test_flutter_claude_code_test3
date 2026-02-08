import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/hourse_race_list.dart';
import '../models/hourse_race_result.dart';
import '../providers/race_provider.dart';

class RaceResultDialog extends ConsumerWidget {
  const RaceResultDialog({super.key, required this.race});

  final HourseRaceList race;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = '${race.year}/${race.month}/${race.day}';

    final asyncResults = ref.watch(
      selectedResultProvider(
        year: race.year ?? '',
        month: race.month ?? '',
        day: race.day ?? '',
        raceName: race.raceName ?? '',
      ),
    );

    return Dialog(
      backgroundColor: const Color(0xFF1A1A2E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
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
              child: Column(
                children: [
                  Text(
                    race.raceName ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        date,
                        style: const TextStyle(
                            color: Color(0xFF53C0F0), fontSize: 13),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        race.place ?? '',
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 13),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '${race.courseKind ?? ''} ${race.courseLength ?? ''}m',
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 13),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${race.ageRate ?? ''} / ${(race.grade ?? '').toUpperCase()}',
                    style:
                        const TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                ],
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
                        'No results',
                        style: TextStyle(color: Colors.white54),
                      ),
                    );
                  }

                  return _buildResultList(results);
                },
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildResultList(List<HourseRaceResult> results) {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final r = results[index];
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
                width: 32,
                child: Text(
                  '$place',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: placeColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      r.hourseName ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${r.age ?? ''}  ${r.jockeyName ?? ''}',
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                r.raceTime ?? '',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                  fontFeatures: [FontFeature.tabularFigures()],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
