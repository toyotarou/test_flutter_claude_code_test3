// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hourse_race_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HourseRaceList _$HourseRaceListFromJson(Map<String, dynamic> json) =>
    _HourseRaceList(
      id: (json['id'] as num).toInt(),
      year: json['year'] as String?,
      month: json['month'] as String?,
      day: json['day'] as String?,
      grade: json['grade'] as String?,
      raceName: json['race_name'] as String?,
      place: json['place'] as String?,
      ageRate: json['age_rate'] as String?,
      courseKind: json['course_kind'] as String?,
      courseLength: json['course_length'] as String?,
      resultUrl: json['result_url'] as String?,
      finish: (json['finish'] as num?)?.toInt(),
    );

Map<String, dynamic> _$HourseRaceListToJson(_HourseRaceList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'year': instance.year,
      'month': instance.month,
      'day': instance.day,
      'grade': instance.grade,
      'race_name': instance.raceName,
      'place': instance.place,
      'age_rate': instance.ageRate,
      'course_kind': instance.courseKind,
      'course_length': instance.courseLength,
      'result_url': instance.resultUrl,
      'finish': instance.finish,
    };
