// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'hourse_name_stats.freezed.dart';
part 'hourse_name_stats.g.dart';

@freezed
abstract class HourseNameStats with _$HourseNameStats {
  const factory HourseNameStats({
    @JsonKey(name: 'hourse_name') required String hourseName,
    @JsonKey(name: 'race_count') required int raceCount,
    @JsonKey(name: 'last_year') required String lastYear,
  }) = _HourseNameStats;

  factory HourseNameStats.fromJson(Map<String, dynamic> json) =>
      _$HourseNameStatsFromJson(json);
}
