import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/hourse_name_stats.dart';
import '../providers/race_provider.dart';
import 'horse_search_result_dialog.dart';

class HorseNameListDialog extends ConsumerStatefulWidget {
  const HorseNameListDialog({super.key});

  @override
  ConsumerState<HorseNameListDialog> createState() => _HorseNameListDialogState();
}

class _HorseNameListDialogState extends ConsumerState<HorseNameListDialog> {
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

  static const _navLabels = ['ア', 'カ', 'サ', 'タ', 'ナ', 'ハ', 'マ', 'ヤ', 'ラ', 'ワ'];

  final _groupKeys = <String, GlobalKey>{
    for (final key in const ['ア行', 'カ行', 'サ行', 'タ行', 'ナ行', 'ハ行', 'マ行', 'ヤ行', 'ラ行', 'ワ行'])
      key: GlobalKey(),
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

  void _scrollToGroup(String label) {
    final key = '$label行';
    final globalKey = _groupKeys[key];
    if (globalKey?.currentContext != null) {
      Scrollable.ensureVisible(
        globalKey!.currentContext!,
        alignment: 0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                itemCount: _navLabels.length,
                separatorBuilder: (_, __) => const SizedBox(width: 4),
                itemBuilder: (context, index) {
                  final label = _navLabels[index];
                  return GestureDetector(
                    onTap: () => _scrollToGroup(label),
                    child: Container(
                      width: 32,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F3460),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        label,
                        style: const TextStyle(
                          color: Color(0xFF53C0F0),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
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
          key: _groupKeys[groupName],
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
          if (active) {
            return _ActiveHorseItem(stats: stats);
          }
          return InkWell(
            onTap: () {
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
                      style: const TextStyle(color: Colors.white38, fontSize: 14),
                    ),
                  ),
                  Text(
                    '${stats.raceCount}走',
                    style: const TextStyle(color: Colors.white24, fontSize: 12),
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

class _ActiveHorseItem extends ConsumerWidget {
  final HourseNameStats stats;
  const _ActiveHorseItem({required this.stats});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncResults = ref.watch(
      resultByHourseNameProvider(hourseName: stats.hourseName),
    );

    return InkWell(
      onTap: () => showDialog(
        context: context,
        builder: (context) => HorseSearchResultDialog(hourseName: stats.hourseName),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    stats.hourseName,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
                Text(
                  '${stats.raceCount}走',
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 4),
            asyncResults.when(
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
              data: (results) {
                final filtered = results
                    .where((r) => r.hourseName == stats.hourseName)
                    .toList();
                if (filtered.isEmpty) return const SizedBox.shrink();
                final lastRace = filtered.last;
                final ageStr = lastRace.age ?? '';
                final sex = ageStr.isNotEmpty ? ageStr.substring(0, 1) : '';
                if (sex.isEmpty) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                    decoration: BoxDecoration(
                      color: sex == '牝'
                          ? const Color(0xFFE91E63).withValues(alpha: 0.3)
                          : sex == 'セ'
                              ? const Color(0xFF4CAF50).withValues(alpha: 0.3)
                              : const Color(0xFF2196F3).withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      sex,
                      style: TextStyle(
                        fontSize: 11,
                        color: sex == '牝'
                            ? const Color(0xFFE91E63)
                            : sex == 'セ'
                                ? const Color(0xFF4CAF50)
                                : const Color(0xFF2196F3),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
            asyncResults.when(
              loading: () => const SizedBox(height: 22),
              error: (_, __) => const SizedBox.shrink(),
              data: (results) {
                final filtered = results
                    .where((r) => r.hourseName == stats.hourseName)
                    .toList();
                if (filtered.isEmpty) return const SizedBox.shrink();
                final shouldReverse = filtered.length > 10;
                return SizedBox(
                  height: 22,
                  child: ListView.separated(
                    reverse: shouldReverse,
                    scrollDirection: Axis.horizontal,
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 3),
                    itemBuilder: (context, index) {
                      final actualIndex = shouldReverse
                          ? filtered.length - 1 - index
                          : index;
                      final pos = filtered[actualIndex].result ?? 0;
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Color _posColor(int pos) {
    switch (pos) {
      case 1:
        return const Color(0xFFFFD700); // Gold
      case 2:
        return const Color(0xFFC0C0C0); // Silver
      case 3:
        return const Color(0xFFCD7F32); // Bronze
      default:
        return const Color(0xFF555555);
    }
  }
}
