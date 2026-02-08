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

@riverpod
Future<List<String>> allHourseNames(Ref ref) async {
  final response = await http.get(
    Uri.parse('$baseUrl/getAllHourseNames'),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to load horse names: ${response.statusCode}');
  }

  final List<dynamic> jsonList = json.decode(response.body);
  return jsonList.cast<String>();
}

@riverpod
Future<List<HourseRaceResult>> selectedResult(
  Ref ref, {
  required String year,
  required String month,
  required String day,
  required String raceName,
}) async {
  final uri = Uri.parse('$baseUrl/getSelectedResult')
      .replace(queryParameters: {
    'year': year,
    'month': month,
    'day': day,
    'race_name': raceName,
  });

  final response = await http.get(uri);

  if (response.statusCode != 200) {
    throw Exception('Failed to load results: ${response.statusCode}');
  }

  final decoded = json.decode(response.body);
  if (decoded == null) return [];
  final List<dynamic> jsonList = decoded;
  return jsonList.map((json) => HourseRaceResult.fromJson(json)).toList();
}

@riverpod
Future<List<HourseRaceResult>> resultByHourseName(
  Ref ref, {
  required String hourseName,
}) async {
  final uri = Uri.parse('$baseUrl/getResultByHourseName')
      .replace(queryParameters: {'hourse_name': hourseName});

  final response = await http.get(uri);

  if (response.statusCode != 200) {
    throw Exception('Failed to load results: ${response.statusCode}');
  }

  final decoded = json.decode(response.body);
  if (decoded == null) return [];
  final List<dynamic> jsonList = decoded;
  return jsonList.map((json) => HourseRaceResult.fromJson(json)).toList();
}

@riverpod
Future<List<HourseNameStats>> allHourseNamesWithStats(Ref ref) async {
  final response = await http.get(
    Uri.parse('$baseUrl/getAllHourseNamesWithStats'),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to load horse name stats: ${response.statusCode}');
  }

  final List<dynamic> jsonList = json.decode(response.body);
  return jsonList.map((json) => HourseNameStats.fromJson(json)).toList();
}

String toKatakana(String input) {
  return String.fromCharCodes(input.runes.map((rune) {
    if (rune >= 0x3041 && rune <= 0x3096) {
      return rune + 0x60;
    }
    return rune;
  }));
}
