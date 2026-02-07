import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/hourse_race_list.dart';
import '../providers/race_provider.dart';
import '../widgets/horse_search_result_dialog.dart';
import '../widgets/race_result_dialog.dart';
import '../widgets/search_bar_widget.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final asyncRaces = ref.watch(allRaceProvider);

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
        body: asyncRaces.when(
          data: (races) => _buildBody(context, races, ref, searchController),
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
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, List<HourseRaceList> races,
      WidgetRef ref, TextEditingController searchController) {
    final selectedYear = ref.watch(selectedYearProvider);
    final hourseNames = ref.watch(allHourseNamesProvider).value ?? [];

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

    return Column(
      children: [
        SearchBarWidget(
          searchController: searchController,
          hourseNames: hourseNames,
          onSearch: () => _onSearch(context, searchController),
        ),
        _buildYearSelector(years, selectedYear, ref),
        Expanded(child: _buildRaceList(context, filteredRaces)),
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
      List<String> years, String? selectedYear, WidgetRef ref) {
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

  Widget _buildRaceList(BuildContext context, List<HourseRaceList> races) {
    return ListView.separated(
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
                        Text(
                          race.raceName ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
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

  void _showRaceResultDialog(BuildContext context, HourseRaceList race) {
    showDialog(
      context: context,
      builder: (context) => RaceResultDialog(race: race),
    );
  }
}
