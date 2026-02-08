// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hourse_name_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HourseNameStats _$HourseNameStatsFromJson(Map<String, dynamic> json) =>
    _HourseNameStats(
      hourseName: json['hourse_name'] as String,
      raceCount: (json['race_count'] as num).toInt(),
      lastYear: json['last_year'] as String,
    );

Map<String, dynamic> _$HourseNameStatsToJson(_HourseNameStats instance) =>
    <String, dynamic>{
      'hourse_name': instance.hourseName,
      'race_count': instance.raceCount,
      'last_year': instance.lastYear,
    };
