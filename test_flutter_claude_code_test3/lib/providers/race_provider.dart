import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import '../models/hourse_race_list.dart';
// ignore: unused_import
import '../models/hourse_race_result.dart';

final allRaceProvider = FutureProvider<List<HourseRaceList>>((ref) async {
  final response = await http.get(
    Uri.parse('$baseUrl/getAllRace'),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to load races: ${response.statusCode}');
  }

  final List<dynamic> jsonList = json.decode(response.body);
  return jsonList.map((json) => HourseRaceList.fromJson(json)).toList();
});

final selectedYearProvider =
    NotifierProvider<SelectedYearNotifier, String?>(
        SelectedYearNotifier.new);

class SelectedYearNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  void select(String? year) {
    state = year;
  }
}

final allHourseNamesProvider = FutureProvider<List<String>>((ref) async {
  final response = await http.get(
    Uri.parse('$baseUrl/getAllHourseNames'),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to load horse names: ${response.statusCode}');
  }

  final List<dynamic> jsonList = json.decode(response.body);
  return jsonList.cast<String>();
});

Future<List<HourseRaceResult>> fetchSelectedResult({
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

Future<List<HourseRaceResult>> fetchResultByHourseName({
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

String toKatakana(String input) {
  return String.fromCharCodes(input.runes.map((rune) {
    if (rune >= 0x3041 && rune <= 0x3096) {
      return rune + 0x60;
    }
    return rune;
  }));
}
