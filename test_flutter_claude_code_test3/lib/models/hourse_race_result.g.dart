// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hourse_race_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HourseRaceResult _$HourseRaceResultFromJson(Map<String, dynamic> json) =>
    _HourseRaceResult(
      id: (json['id'] as num).toInt(),
      year: json['year'] as String?,
      month: json['month'] as String?,
      day: json['day'] as String?,
      grade: json['grade'] as String?,
      raceName: json['race_name'] as String?,
      result: (json['result'] as num?)?.toInt(),
      hourseName: json['hourse_name'] as String?,
      age: json['age'] as String?,
      jockeyName: json['jockey_name'] as String?,
      raceTime: json['race_time'] as String?,
    );

Map<String, dynamic> _$HourseRaceResultToJson(_HourseRaceResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'year': instance.year,
      'month': instance.month,
      'day': instance.day,
      'grade': instance.grade,
      'race_name': instance.raceName,
      'result': instance.result,
      'hourse_name': instance.hourseName,
      'age': instance.age,
      'jockey_name': instance.jockeyName,
      'race_time': instance.raceTime,
    };
