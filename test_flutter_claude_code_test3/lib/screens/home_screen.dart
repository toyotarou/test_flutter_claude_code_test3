import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/hourse_race_list.dart';
import '../models/hourse_race_result.dart';
import '../providers/race_provider.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final asyncRaces = ref.watch(allRaceProvider);

    return Scaffold(
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
    );
  }

  Widget _buildBody(BuildContext context, List<HourseRaceList> races,
      WidgetRef ref, TextEditingController searchController) {
    final selectedYear = ref.watch(selectedYearProvider);
    final hourseNames =
        ref.watch(allHourseNamesProvider).value ?? [];

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
        _buildSearchBar(context, searchController, hourseNames),
        _buildYearSelector(years, selectedYear, ref),
        Expanded(child: _buildRaceList(context, filteredRaces)),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context,
      TextEditingController searchController, List<String> hourseNames) {
    return _SearchBar(
      searchController: searchController,
      hourseNames: hourseNames,
      onSearch: () => _onSearch(context, searchController),
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
      builder: (context) => _HourseSearchResultDialog(hourseName: query),
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
      builder: (context) => _RaceResultDialog(race: race),
    );
  }
}

// ============================================================
// Race Result Dialog
// ============================================================

class _RaceResultDialog extends StatefulWidget {
  const _RaceResultDialog({required this.race});

  final HourseRaceList race;

  @override
  State<_RaceResultDialog> createState() => _RaceResultDialogState();
}

class _RaceResultDialogState extends State<_RaceResultDialog> {
  late Future<List<HourseRaceResult>> _futureResults;

  @override
  void initState() {
    super.initState();
    _futureResults = fetchSelectedResult(
      year: widget.race.year ?? '',
      month: widget.race.month ?? '',
      day: widget.race.day ?? '',
      raceName: widget.race.raceName ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    final race = widget.race;
    final date = '${race.year}/${race.month}/${race.day}';

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
              child: FutureBuilder<List<HourseRaceResult>>(
                future: _futureResults,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.all(32),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF53C0F0),
                          strokeWidth: 2,
                        ),
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: const TextStyle(color: Color(0xFFE94560)),
                      ),
                    );
                  }

                  final results = snapshot.data ?? [];

                  if (results.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(24),
                      child: Text(
                        'No results',
                        style: TextStyle(color: Colors.white54),
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                },
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// Horse Search Result Dialog
// ============================================================

class _HourseSearchResultDialog extends StatefulWidget {
  const _HourseSearchResultDialog({required this.hourseName});

  final String hourseName;

  @override
  State<_HourseSearchResultDialog> createState() =>
      _HourseSearchResultDialogState();
}

class _HourseSearchResultDialogState
    extends State<_HourseSearchResultDialog> {
  late Future<List<HourseRaceResult>> _futureResults;

  @override
  void initState() {
    super.initState();
    _futureResults =
        fetchResultByHourseName(hourseName: widget.hourseName);
  }

  @override
  Widget build(BuildContext context) {
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
                widget.hourseName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Flexible(
              child: FutureBuilder<List<HourseRaceResult>>(
                future: _futureResults,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.all(32),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF53C0F0),
                          strokeWidth: 2,
                        ),
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: const TextStyle(color: Color(0xFFE94560)),
                      ),
                    );
                  }

                  final results = snapshot.data ?? [];

                  if (results.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(24),
                      child: Text(
                        '該当する馬が見つかりません',
                        style: TextStyle(color: Colors.white54),
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final r = results[index];
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
                                  fontFeatures: [
                                    FontFeature.tabularFigures()
                                  ],
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
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
