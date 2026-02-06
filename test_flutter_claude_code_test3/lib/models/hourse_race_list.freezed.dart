// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hourse_race_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HourseRaceList {

 int get id; String? get year; String? get month; String? get day; String? get grade;@JsonKey(name: 'race_name') String? get raceName; String? get place;@JsonKey(name: 'age_rate') String? get ageRate;@JsonKey(name: 'course_kind') String? get courseKind;@JsonKey(name: 'course_length') String? get courseLength;@JsonKey(name: 'result_url') String? get resultUrl; int? get finish;
/// Create a copy of HourseRaceList
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HourseRaceListCopyWith<HourseRaceList> get copyWith => _$HourseRaceListCopyWithImpl<HourseRaceList>(this as HourseRaceList, _$identity);

  /// Serializes this HourseRaceList to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HourseRaceList&&(identical(other.id, id) || other.id == id)&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.day, day) || other.day == day)&&(identical(other.grade, grade) || other.grade == grade)&&(identical(other.raceName, raceName) || other.raceName == raceName)&&(identical(other.place, place) || other.place == place)&&(identical(other.ageRate, ageRate) || other.ageRate == ageRate)&&(identical(other.courseKind, courseKind) || other.courseKind == courseKind)&&(identical(other.courseLength, courseLength) || other.courseLength == courseLength)&&(identical(other.resultUrl, resultUrl) || other.resultUrl == resultUrl)&&(identical(other.finish, finish) || other.finish == finish));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,year,month,day,grade,raceName,place,ageRate,courseKind,courseLength,resultUrl,finish);

@override
String toString() {
  return 'HourseRaceList(id: $id, year: $year, month: $month, day: $day, grade: $grade, raceName: $raceName, place: $place, ageRate: $ageRate, courseKind: $courseKind, courseLength: $courseLength, resultUrl: $resultUrl, finish: $finish)';
}


}

/// @nodoc
abstract mixin class $HourseRaceListCopyWith<$Res>  {
  factory $HourseRaceListCopyWith(HourseRaceList value, $Res Function(HourseRaceList) _then) = _$HourseRaceListCopyWithImpl;
@useResult
$Res call({
 int id, String? year, String? month, String? day, String? grade,@JsonKey(name: 'race_name') String? raceName, String? place,@JsonKey(name: 'age_rate') String? ageRate,@JsonKey(name: 'course_kind') String? courseKind,@JsonKey(name: 'course_length') String? courseLength,@JsonKey(name: 'result_url') String? resultUrl, int? finish
});




}
/// @nodoc
class _$HourseRaceListCopyWithImpl<$Res>
    implements $HourseRaceListCopyWith<$Res> {
  _$HourseRaceListCopyWithImpl(this._self, this._then);

  final HourseRaceList _self;
  final $Res Function(HourseRaceList) _then;

/// Create a copy of HourseRaceList
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? year = freezed,Object? month = freezed,Object? day = freezed,Object? grade = freezed,Object? raceName = freezed,Object? place = freezed,Object? ageRate = freezed,Object? courseKind = freezed,Object? courseLength = freezed,Object? resultUrl = freezed,Object? finish = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as String?,month: freezed == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String?,day: freezed == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as String?,grade: freezed == grade ? _self.grade : grade // ignore: cast_nullable_to_non_nullable
as String?,raceName: freezed == raceName ? _self.raceName : raceName // ignore: cast_nullable_to_non_nullable
as String?,place: freezed == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as String?,ageRate: freezed == ageRate ? _self.ageRate : ageRate // ignore: cast_nullable_to_non_nullable
as String?,courseKind: freezed == courseKind ? _self.courseKind : courseKind // ignore: cast_nullable_to_non_nullable
as String?,courseLength: freezed == courseLength ? _self.courseLength : courseLength // ignore: cast_nullable_to_non_nullable
as String?,resultUrl: freezed == resultUrl ? _self.resultUrl : resultUrl // ignore: cast_nullable_to_non_nullable
as String?,finish: freezed == finish ? _self.finish : finish // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [HourseRaceList].
extension HourseRaceListPatterns on HourseRaceList {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HourseRaceList value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HourseRaceList() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HourseRaceList value)  $default,){
final _that = this;
switch (_that) {
case _HourseRaceList():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HourseRaceList value)?  $default,){
final _that = this;
switch (_that) {
case _HourseRaceList() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String? year,  String? month,  String? day,  String? grade, @JsonKey(name: 'race_name')  String? raceName,  String? place, @JsonKey(name: 'age_rate')  String? ageRate, @JsonKey(name: 'course_kind')  String? courseKind, @JsonKey(name: 'course_length')  String? courseLength, @JsonKey(name: 'result_url')  String? resultUrl,  int? finish)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HourseRaceList() when $default != null:
return $default(_that.id,_that.year,_that.month,_that.day,_that.grade,_that.raceName,_that.place,_that.ageRate,_that.courseKind,_that.courseLength,_that.resultUrl,_that.finish);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String? year,  String? month,  String? day,  String? grade, @JsonKey(name: 'race_name')  String? raceName,  String? place, @JsonKey(name: 'age_rate')  String? ageRate, @JsonKey(name: 'course_kind')  String? courseKind, @JsonKey(name: 'course_length')  String? courseLength, @JsonKey(name: 'result_url')  String? resultUrl,  int? finish)  $default,) {final _that = this;
switch (_that) {
case _HourseRaceList():
return $default(_that.id,_that.year,_that.month,_that.day,_that.grade,_that.raceName,_that.place,_that.ageRate,_that.courseKind,_that.courseLength,_that.resultUrl,_that.finish);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String? year,  String? month,  String? day,  String? grade, @JsonKey(name: 'race_name')  String? raceName,  String? place, @JsonKey(name: 'age_rate')  String? ageRate, @JsonKey(name: 'course_kind')  String? courseKind, @JsonKey(name: 'course_length')  String? courseLength, @JsonKey(name: 'result_url')  String? resultUrl,  int? finish)?  $default,) {final _that = this;
switch (_that) {
case _HourseRaceList() when $default != null:
return $default(_that.id,_that.year,_that.month,_that.day,_that.grade,_that.raceName,_that.place,_that.ageRate,_that.courseKind,_that.courseLength,_that.resultUrl,_that.finish);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HourseRaceList implements HourseRaceList {
  const _HourseRaceList({required this.id, this.year, this.month, this.day, this.grade, @JsonKey(name: 'race_name') this.raceName, this.place, @JsonKey(name: 'age_rate') this.ageRate, @JsonKey(name: 'course_kind') this.courseKind, @JsonKey(name: 'course_length') this.courseLength, @JsonKey(name: 'result_url') this.resultUrl, this.finish});
  factory _HourseRaceList.fromJson(Map<String, dynamic> json) => _$HourseRaceListFromJson(json);

@override final  int id;
@override final  String? year;
@override final  String? month;
@override final  String? day;
@override final  String? grade;
@override@JsonKey(name: 'race_name') final  String? raceName;
@override final  String? place;
@override@JsonKey(name: 'age_rate') final  String? ageRate;
@override@JsonKey(name: 'course_kind') final  String? courseKind;
@override@JsonKey(name: 'course_length') final  String? courseLength;
@override@JsonKey(name: 'result_url') final  String? resultUrl;
@override final  int? finish;

/// Create a copy of HourseRaceList
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HourseRaceListCopyWith<_HourseRaceList> get copyWith => __$HourseRaceListCopyWithImpl<_HourseRaceList>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HourseRaceListToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HourseRaceList&&(identical(other.id, id) || other.id == id)&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.day, day) || other.day == day)&&(identical(other.grade, grade) || other.grade == grade)&&(identical(other.raceName, raceName) || other.raceName == raceName)&&(identical(other.place, place) || other.place == place)&&(identical(other.ageRate, ageRate) || other.ageRate == ageRate)&&(identical(other.courseKind, courseKind) || other.courseKind == courseKind)&&(identical(other.courseLength, courseLength) || other.courseLength == courseLength)&&(identical(other.resultUrl, resultUrl) || other.resultUrl == resultUrl)&&(identical(other.finish, finish) || other.finish == finish));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,year,month,day,grade,raceName,place,ageRate,courseKind,courseLength,resultUrl,finish);

@override
String toString() {
  return 'HourseRaceList(id: $id, year: $year, month: $month, day: $day, grade: $grade, raceName: $raceName, place: $place, ageRate: $ageRate, courseKind: $courseKind, courseLength: $courseLength, resultUrl: $resultUrl, finish: $finish)';
}


}

/// @nodoc
abstract mixin class _$HourseRaceListCopyWith<$Res> implements $HourseRaceListCopyWith<$Res> {
  factory _$HourseRaceListCopyWith(_HourseRaceList value, $Res Function(_HourseRaceList) _then) = __$HourseRaceListCopyWithImpl;
@override @useResult
$Res call({
 int id, String? year, String? month, String? day, String? grade,@JsonKey(name: 'race_name') String? raceName, String? place,@JsonKey(name: 'age_rate') String? ageRate,@JsonKey(name: 'course_kind') String? courseKind,@JsonKey(name: 'course_length') String? courseLength,@JsonKey(name: 'result_url') String? resultUrl, int? finish
});




}
/// @nodoc
class __$HourseRaceListCopyWithImpl<$Res>
    implements _$HourseRaceListCopyWith<$Res> {
  __$HourseRaceListCopyWithImpl(this._self, this._then);

  final _HourseRaceList _self;
  final $Res Function(_HourseRaceList) _then;

/// Create a copy of HourseRaceList
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? year = freezed,Object? month = freezed,Object? day = freezed,Object? grade = freezed,Object? raceName = freezed,Object? place = freezed,Object? ageRate = freezed,Object? courseKind = freezed,Object? courseLength = freezed,Object? resultUrl = freezed,Object? finish = freezed,}) {
  return _then(_HourseRaceList(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as String?,month: freezed == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String?,day: freezed == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as String?,grade: freezed == grade ? _self.grade : grade // ignore: cast_nullable_to_non_nullable
as String?,raceName: freezed == raceName ? _self.raceName : raceName // ignore: cast_nullable_to_non_nullable
as String?,place: freezed == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as String?,ageRate: freezed == ageRate ? _self.ageRate : ageRate // ignore: cast_nullable_to_non_nullable
as String?,courseKind: freezed == courseKind ? _self.courseKind : courseKind // ignore: cast_nullable_to_non_nullable
as String?,courseLength: freezed == courseLength ? _self.courseLength : courseLength // ignore: cast_nullable_to_non_nullable
as String?,resultUrl: freezed == resultUrl ? _self.resultUrl : resultUrl // ignore: cast_nullable_to_non_nullable
as String?,finish: freezed == finish ? _self.finish : finish // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
