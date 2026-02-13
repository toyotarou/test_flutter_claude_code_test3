import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/hourse_race_list.dart';
import '../providers/race_provider.dart';
import '../widgets/horse_name_list_dialog.dart';
import '../widgets/horse_search_result_dialog.dart';
import '../widgets/race_info_input_dialog.dart';
import '../widgets/race_result_dialog.dart';
import '../widgets/search_bar_widget.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final scrollController = useScrollController();
    final asyncRaces = ref.watch(allRaceProvider);
    ref.watch(activeHorseResultsProvider);
    final isWaitingForDialog = useState(false);

    // データ準備完了を検知してダイアログを開く
    ref.listen(activeHorseResultsProvider, (prev, next) {
      if (isWaitingForDialog.value && next.hasValue) {
        isWaitingForDialog.value = false;
        showDialog(
          context: context,
          builder: (context) => const HorseNameListDialog(),
        );
      }
    });

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Horse Race',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              icon: const Icon(Icons.edit_note, color: Colors.white),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const RaceInfoInputDialog(),
                );
              },
            ),
          ],
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        body: SafeArea(child: asyncRaces.when(
          data: (races) => _buildBody(context, races, ref, searchController, scrollController, isWaitingForDialog),
          loading: () => const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Color(0xFF0F3460),
                  strokeWidth: 3,
                ),
                SizedBox(height: 16),
                Text(
                  'Loading...',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          error: (error, stack) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Color(0xFFE94560),
                  size: 48,
                ),
                const SizedBox(height: 16),
                Text(
                  'Error: $error',
                  style: const TextStyle(
                    color: Color(0xFFE94560),
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () => ref.invalidate(allRaceProvider),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F3460),
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }

  Widget _buildBody(BuildContext context, List<HourseRaceList> races,
      WidgetRef ref, TextEditingController searchController, ScrollController scrollController,
      ValueNotifier<bool> isWaitingForDialog) {
    final selectedYear = ref.watch(selectedYearProvider);
    final hourseNameStats = ref.watch(allHourseNamesWithStatsProvider).value ?? [];

    final years = races.map((r) => r.year).whereType<String>().toSet().toList()
      ..sort();

    var filteredRaces = selectedYear == null
        ? List<HourseRaceList>.from(races)
        : races.where((r) => r.year == selectedYear).toList();

    filteredRaces.sort((a, b) {
      final dateCompare = '${a.year}${a.month}${a.day}'
          .compareTo('${b.year}${b.month}${b.day}');
      if (dateCompare != 0) return dateCompare;
      return (a.raceName ?? '').compareTo(b.raceName ?? '');
    });

    return Stack(
      children: [
        Column(
          children: [
            SearchBarWidget(
              searchController: searchController,
              hourseNameStats: hourseNameStats,
              onSearch: () => _onSearch(context, searchController),
              onListTap: () => _showHorseNameListDialog(context, ref, isWaitingForDialog),
            ),
            _buildYearSelector(years, selectedYear, ref, scrollController),
            Expanded(child: _buildRaceList(context, filteredRaces, scrollController)),
          ],
        ),
        if (isWaitingForDialog.value)
          Positioned.fill(
            child: Container(
              color: Colors.black54,
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(
                      color: Color(0xFF53C0F0),
                      strokeWidth: 3,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'データ準備中...',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  void _onSearch(
      BuildContext context, TextEditingController searchController) {
    final query = toKatakana(searchController.text.trim());
    if (query.isEmpty) return;

    searchController.text = query;

    FocusScope.of(context).unfocus();

    showDialog(
      context: context,
      builder: (context) => HorseSearchResultDialog(hourseName: query),
    );
  }

  Widget _buildYearSelector(
      List<String> years, String? selectedYear, WidgetRef ref, ScrollController scrollController) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFF1A1A2E), width: 1),
        ),
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: years.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final year = years[index];
          final isSelected = year == selectedYear;

          return GestureDetector(
            onTap: () {
              ref
                  .read(selectedYearProvider.notifier)
                  .select(isSelected ? null : year);
              if (scrollController.hasClients) {
                scrollController.jumpTo(0);
              }
            },
            child: CircleAvatar(
              radius: 22,
              backgroundColor: isSelected
                  ? const Color(0xFF53C0F0)
                  : const Color(0xFF1A1A2E),
              child: Text(
                year,
                style: TextStyle(
                  color: isSelected ? Colors.black : Colors.white70,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRaceList(BuildContext context, List<HourseRaceList> races, ScrollController scrollController) {
    return ListView.separated(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      itemCount: races.length,
      separatorBuilder: (_, __) => const Divider(
        color: Color(0xFF1A1A2E),
        height: 1,
      ),
      itemBuilder: (context, index) {
        final race = races[index];
        final date = '${race.year}/${race.month}/${race.day}';
        final courseKind = race.courseKind ?? '';
        final courseLength = race.courseLength ?? '';
        final grade = (race.grade ?? '').toUpperCase();

        return GestureDetector(
          onTap: () => _showRaceResultDialog(context, race),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(0xFF0F3460).withValues(alpha: 0.3),
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  SizedBox(
                    width: 90,
                    child: Text(
                      date,
                      style: const TextStyle(
                        color: Color(0xFF53C0F0),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        fontFeatures: [FontFeature.tabularFigures()],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            if (grade.isNotEmpty)
                              Container(
                                margin: const EdgeInsets.only(right: 6),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: switch (grade) {
                                      'G1' => [const Color(0xFFFFD700), const Color(0xFFFFA000)],
                                      'G2' => [const Color(0xFFC0C0C0), const Color(0xFF9E9E9E)],
                                      'G3' => [const Color(0xFFCD7F32), const Color(0xFF8D6E63)],
                                      _ => [const Color(0xFF455A64), const Color(0xFF37474F)],
                                    },
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                  boxShadow: grade == 'G1'
                                      ? [BoxShadow(color: const Color(0xFFFFD700).withValues(alpha: 0.4), blurRadius: 4)]
                                      : null,
                                ),
                                child: Text(
                                  grade,
                                  style: TextStyle(
                                    color: grade == 'G2' ? Colors.black87 : Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            Expanded(
                              child: Text(
                                race.raceName ?? '',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${race.place ?? ''}  ${race.ageRate ?? ''}',
                          style: const TextStyle(
                            color: Colors.white60,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: courseKind == '芝'
                              ? const Color(0xFF2E7D32)
                              : const Color(0xFF8D6E63),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          courseKind,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$courseLength m',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showHorseNameListDialog(BuildContext context, WidgetRef ref,
      ValueNotifier<bool> isWaitingForDialog) {
    if (isWaitingForDialog.value) return; // 既に待機中なら無視

    isWaitingForDialog.value = true;

    final isReady = ref.read(activeHorseResultsProvider).hasValue;
    if (isReady) {
      // データ準備済み → Progress表示後にダイアログを開く
      Future.delayed(const Duration(milliseconds: 200), () {
        if (context.mounted) {
          isWaitingForDialog.value = false;
          showDialog(
            context: context,
            builder: (context) => const HorseNameListDialog(),
          );
        }
      });
    }
    // データ未準備の場合はref.listenが準備完了時にダイアログを開く
  }

  void _showRaceResultDialog(BuildContext context, HourseRaceList race) {
    showDialog(
      context: context,
      builder: (context) => RaceResultDialog(race: race),
    );
  }
}
