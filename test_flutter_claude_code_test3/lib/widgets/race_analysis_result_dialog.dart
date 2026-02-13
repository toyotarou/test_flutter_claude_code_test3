import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/hourse_race_result.dart';
import '../providers/race_provider.dart';
import 'horse_search_result_dialog.dart';

class RaceAnalysisResultDialog extends ConsumerWidget {
  const RaceAnalysisResultDialog({super.key, required this.horseNames});

  final List<String> horseNames;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncAllResults = ref.watch(allRaceResultsProvider);

    return Dialog(
      backgroundColor: const Color(0xFF1A1A2E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
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
              'レース分析（${horseNames.length}頭）',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Flexible(
            child: asyncAllResults.when(
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
                child: Text('Error: $error', style: const TextStyle(color: Color(0xFFE94560))),
              ),
              data: (allResults) {
                final sorted = _sortByAvgPoints(allResults);
                return ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  itemCount: sorted.length,
                  separatorBuilder: (_, __) => const Divider(
                    color: Color(0xFF0F3460),
                    height: 1,
                  ),
                  itemBuilder: (context, index) {
                    final entry = sorted[index];
                    return _HorseResultItem(
                      index: index,
                      horseName: entry.name,
                      results: entry.results,
                      avgPoints: entry.avgPoints,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<_SortedEntry> _sortByAvgPoints(List<HourseRaceResult> allResults) {
    final entries = <_SortedEntry>[];
    for (final name in horseNames) {
      final results = allResults.where((r) => r.hourseName == name).toList();
      double? avg;
      if (results.isNotEmpty) {
        final total = results.fold<int>(0, (sum, r) => sum + (21 - (r.result ?? 0)));
        avg = total / results.length;
      }
      entries.add(_SortedEntry(name: name, results: results, avgPoints: avg));
    }
    entries.sort((a, b) {
      if (a.avgPoints == null && b.avgPoints == null) return a.name.compareTo(b.name);
      if (a.avgPoints == null) return 1;
      if (b.avgPoints == null) return -1;
      final cmp = b.avgPoints!.compareTo(a.avgPoints!);
      if (cmp != 0) return cmp;
      return a.name.compareTo(b.name);
    });
    return entries;
  }
}

class _SortedEntry {
  final String name;
  final List<HourseRaceResult> results;
  final double? avgPoints;
  _SortedEntry({required this.name, required this.results, this.avgPoints});
}

class _HorseResultItem extends StatelessWidget {
  const _HorseResultItem({
    required this.index,
    required this.horseName,
    required this.results,
    required this.avgPoints,
  });

  final int index;
  final String horseName;
  final List<HourseRaceResult> results;
  final double? avgPoints;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: const Color(0xFF0F3460),
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(
                    color: Color(0xFF53C0F0),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  horseName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => HorseSearchResultDialog(hourseName: horseName),
                  );
                },
                child: const Icon(
                  Icons.info_outline,
                  color: Color(0xFF53C0F0),
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          if (results.isEmpty)
            const Text(
              'データなし',
              style: TextStyle(color: Colors.white38, fontSize: 12),
            )
          else ...[
            SizedBox(
              height: 22,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: results.length,
                separatorBuilder: (_, __) => const SizedBox(width: 3),
                itemBuilder: (context, i) {
                  final pos = results[i].result ?? 0;
                  return CircleAvatar(
                    radius: 10,
                    backgroundColor: _posColor(pos),
                    child: Text(
                      '$pos',
                      style: const TextStyle(
                        fontSize: 9,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '獲得ポイント平均: ${avgPoints!.toStringAsFixed(2)}',
              style: const TextStyle(color: Colors.white54, fontSize: 12),
            ),
          ],
        ],
      ),
    );
  }

  Color _posColor(int pos) {
    switch (pos) {
      case 1:
        return const Color(0xFFFFD700);
      case 2:
        return const Color(0xFFC0C0C0);
      case 3:
        return const Color(0xFFCD7F32);
      default:
        return const Color(0xFF555555);
    }
  }
}
