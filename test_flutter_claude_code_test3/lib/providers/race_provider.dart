import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../config/api_config.dart';
import '../models/hourse_name_stats.dart';
import '../models/hourse_race_list.dart';
import '../models/hourse_race_result.dart';

part 'race_provider.g.dart';

@riverpod
Future<List<HourseRaceList>> allRace(Ref ref) async {
  final response = await http.get(
    Uri.parse('$baseUrl/getAllRace'),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to load races: ${response.statusCode}');
  }

  final List<dynamic> jsonList = json.decode(response.body);
  return jsonList.map((json) => HourseRaceList.fromJson(json)).toList();
}

@riverpod
class SelectedYear extends _$SelectedYear {
  @override
  String? build() => null;

  void select(String? year) {
    state = year;
  }
}

/// 全レース結果を一括取得（SELECT * FROM t_hourse_race_result）
@riverpod
Future<List<HourseRaceResult>> allRaceResults(Ref ref) async {
  final response = await http.get(
    Uri.parse('$baseUrl/getAllRaceResults'),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to load all race results: ${response.statusCode}');
  }

  final decoded = json.decode(response.body);
  if (decoded == null) return [];
  final List<dynamic> jsonList = decoded;
  return jsonList.map((json) => HourseRaceResult.fromJson(json)).toList();
}

/// 馬名一覧（不要になったAPIコールをローカル集計に置き換え）
@riverpod
Future<List<String>> allHourseNames(Ref ref) async {
  final allResults = await ref.watch(allRaceResultsProvider.future);
  final names = <String>{};
  for (final r in allResults) {
    if (r.hourseName != null) names.add(r.hourseName!);
  }
  final sorted = names.toList()..sort();
  return sorted;
}

/// 特定レースの結果（ローカルフィルタリング）
@riverpod
Future<List<HourseRaceResult>> selectedResult(
  Ref ref, {
  required String year,
  required String month,
  required String day,
  required String raceName,
}) async {
  final allResults = await ref.watch(allRaceResultsProvider.future);
  final filtered = allResults
      .where((r) =>
          r.year == year &&
          r.month == month &&
          r.day == day &&
          r.raceName == raceName)
      .toList();
  filtered.sort((a, b) => (a.result ?? 0).compareTo(b.result ?? 0));
  return filtered;
}

/// 馬名で検索（ローカル完全一致フィルタリング、LIKE問題解消）
@riverpod
Future<List<HourseRaceResult>> resultByHourseName(
  Ref ref, {
  required String hourseName,
}) async {
  final allResults = await ref.watch(allRaceResultsProvider.future);
  return allResults.where((r) => r.hourseName == hourseName).toList();
}

/// 馬名統計（ローカル集計に置き換え）
@riverpod
Future<List<HourseNameStats>> allHourseNamesWithStats(Ref ref) async {
  final allResults = await ref.watch(allRaceResultsProvider.future);
  final statsMap = <String, _HorseStatsAccum>{};

  for (final r in allResults) {
    final name = r.hourseName;
    if (name == null) continue;
    final accum = statsMap.putIfAbsent(name, () => _HorseStatsAccum());
    accum.count++;
    final year = r.year ?? '';
    if (year.compareTo(accum.maxYear) > 0) accum.maxYear = year;
  }

  final statsList = statsMap.entries.map((e) {
    return HourseNameStats(
      hourseName: e.key,
      raceCount: e.value.count,
      lastYear: e.value.maxYear,
    );
  }).toList();
  statsList.sort((a, b) => a.hourseName.compareTo(b.hourseName));
  return statsList;
}

class _HorseStatsAccum {
  int count = 0;
  String maxYear = '';
}

/// アクティブ馬の結果Map（ローカルフィルタリング、個別APIコール不要）
@riverpod
Future<Map<String, List<HourseRaceResult>>> activeHorseResults(Ref ref) async {
  final statsList = await ref.watch(allHourseNamesWithStatsProvider.future);
  final allResults = await ref.watch(allRaceResultsProvider.future);
  final now = DateTime.now();
  final currentYear = now.year;

  final activeNames = statsList
      .where((s) {
        final lastYear = int.tryParse(s.lastYear) ?? 0;
        return lastYear >= currentYear - 1;
      })
      .map((s) => s.hourseName)
      .toSet();

  final map = <String, List<HourseRaceResult>>{};
  for (final r in allResults) {
    final name = r.hourseName;
    if (name == null || !activeNames.contains(name)) continue;
    (map[name] ??= []).add(r);
  }

  return map;
}

@riverpod
Future<Map<String, HourseRaceList>> raceMap(Ref ref) async {
  final races = await ref.watch(allRaceProvider.future);
  final map = <String, HourseRaceList>{};
  for (final race in races) {
    final key = '${race.year}/${race.month}/${race.day}/${race.raceName}';
    map[key] = race;
  }
  return map;
}

String toKatakana(String input) {
  return String.fromCharCodes(input.runes.map((rune) {
    if (rune >= 0x3041 && rune <= 0x3096) {
      return rune + 0x60;
    }
    return rune;
  }));
}
