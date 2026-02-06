// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'hourse_race_list.freezed.dart';
part 'hourse_race_list.g.dart';

@freezed
abstract class HourseRaceList with _$HourseRaceList {
  const factory HourseRaceList({
    required int id,
    String? year,
    String? month,
    String? day,
    String? grade,
    @JsonKey(name: 'race_name') String? raceName,
    String? place,
    @JsonKey(name: 'age_rate') String? ageRate,
    @JsonKey(name: 'course_kind') String? courseKind,
    @JsonKey(name: 'course_length') String? courseLength,
    @JsonKey(name: 'result_url') String? resultUrl,
    int? finish,
  }) = _HourseRaceList;

  factory HourseRaceList.fromJson(Map<String, dynamic> json) =>
      _$HourseRaceListFromJson(json);
}
