// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'hourse_race_result.freezed.dart';
part 'hourse_race_result.g.dart';

@freezed
abstract class HourseRaceResult with _$HourseRaceResult {
  const factory HourseRaceResult({
    required int id,
    String? year,
    String? month,
    String? day,
    String? grade,
    @JsonKey(name: 'race_name') String? raceName,
    int? result,
    @JsonKey(name: 'hourse_name') String? hourseName,
    String? age,
    @JsonKey(name: 'jockey_name') String? jockeyName,
    @JsonKey(name: 'race_time') String? raceTime,
  }) = _HourseRaceResult;

  factory HourseRaceResult.fromJson(Map<String, dynamic> json) =>
      _$HourseRaceResultFromJson(json);
}
