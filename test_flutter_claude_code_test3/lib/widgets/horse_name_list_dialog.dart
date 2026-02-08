import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/hourse_name_stats.dart';
import '../providers/race_provider.dart';
import 'horse_search_result_dialog.dart';

class HorseNameListDialog extends ConsumerWidget {
  const HorseNameListDialog({super.key});

  static const _katakanaRows = {
    'ア行': ['ア', 'イ', 'ウ', 'エ', 'オ'],
    'カ行': ['カ', 'キ', 'ク', 'ケ', 'コ', 'ガ', 'ギ', 'グ', 'ゲ', 'ゴ'],
    'サ行': ['サ', 'シ', 'ス', 'セ', 'ソ', 'ザ', 'ジ', 'ズ', 'ゼ', 'ゾ'],
    'タ行': ['タ', 'チ', 'ツ', 'テ', 'ト', 'ダ', 'ヂ', 'ヅ', 'デ', 'ド'],
    'ナ行': ['ナ', 'ニ', 'ヌ', 'ネ', 'ノ'],
    'ハ行': ['ハ', 'ヒ', 'フ', 'ヘ', 'ホ', 'バ', 'ビ', 'ブ', 'ベ', 'ボ', 'パ', 'ピ', 'プ', 'ペ', 'ポ'],
    'マ行': ['マ', 'ミ', 'ム', 'メ', 'モ'],
    'ヤ行': ['ヤ', 'ユ', 'ヨ'],
    'ラ行': ['ラ', 'リ', 'ル', 'レ', 'ロ'],
    'ワ行': ['ワ', 'ヲ', 'ン'],
  };

  String _getRowKey(String name) {
    if (name.isEmpty) return 'その他';
    final first = name.substring(0, 1);
    for (final entry in _katakanaRows.entries) {
      if (entry.value.contains(first)) return entry.key;
    }
    return 'その他';
  }

  bool _isActive(HourseNameStats stats) {
    final now = DateTime.now();
    final currentYear = now.year;
    final lastYear = int.tryParse(stats.lastYear) ?? 0;
    return lastYear >= currentYear - 1;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncStats = ref.watch(allHourseNamesWithStatsProvider);

    return Dialog(
      backgroundColor: const Color(0xFF1A1A2E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.85),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [Color(0xFF0F3460), Color(0xFF16213E)]),
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: const Text(
                '馬名一覧（あいうえお順）',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Flexible(
              child: asyncStats.when(
                loading: () => const Padding(
                  padding: EdgeInsets.all(32),
                  child: Center(child: CircularProgressIndicator(color: Color(0xFF53C0F0), strokeWidth: 2)),
                ),
                error: (error, _) => Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text('Error: $error', style: const TextStyle(color: Color(0xFFE94560))),
                ),
                data: (statsList) => _buildGroupedList(context, statsList),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupedList(BuildContext context, List<HourseNameStats> statsList) {
    final grouped = <String, List<HourseNameStats>>{};
    for (final s in statsList) {
      final key = _getRowKey(s.hourseName);
      (grouped[key] ??= []).add(s);
    }

    final orderedKeys = [..._katakanaRows.keys, if (grouped.containsKey('その他')) 'その他'];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: orderedKeys.length,
      itemBuilder: (context, index) {
        final key = orderedKeys[index];
        final items = grouped[key];
        if (items == null || items.isEmpty) return const SizedBox.shrink();

        return _buildGroup(context, key, items);
      },
    );
  }

  Widget _buildGroup(BuildContext context, String groupName, List<HourseNameStats> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: const Color(0xFF0F3460).withValues(alpha: 0.5),
          child: Text(
            groupName,
            style: const TextStyle(color: Color(0xFF53C0F0), fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        ...items.map((stats) {
          final active = _isActive(stats);
          return InkWell(
            onTap: () {
              // Navigator.of(context).pop();
              //

              showDialog(
                context: context,
                builder: (context) => HorseSearchResultDialog(hourseName: stats.hourseName),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      stats.hourseName,
                      style: TextStyle(color: active ? Colors.white : Colors.white38, fontSize: 14),
                    ),
                  ),
                  Text(
                    '${stats.raceCount}走',
                    style: TextStyle(color: active ? Colors.white70 : Colors.white24, fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}
