// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hourse_race_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HourseRaceResult {

 int get id; String? get year; String? get month; String? get day; String? get grade;@JsonKey(name: 'race_name') String? get raceName; int? get result;@JsonKey(name: 'hourse_name') String? get hourseName; String? get age;@JsonKey(name: 'jockey_name') String? get jockeyName;@JsonKey(name: 'race_time') String? get raceTime;
/// Create a copy of HourseRaceResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HourseRaceResultCopyWith<HourseRaceResult> get copyWith => _$HourseRaceResultCopyWithImpl<HourseRaceResult>(this as HourseRaceResult, _$identity);

  /// Serializes this HourseRaceResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HourseRaceResult&&(identical(other.id, id) || other.id == id)&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.day, day) || other.day == day)&&(identical(other.grade, grade) || other.grade == grade)&&(identical(other.raceName, raceName) || other.raceName == raceName)&&(identical(other.result, result) || other.result == result)&&(identical(other.hourseName, hourseName) || other.hourseName == hourseName)&&(identical(other.age, age) || other.age == age)&&(identical(other.jockeyName, jockeyName) || other.jockeyName == jockeyName)&&(identical(other.raceTime, raceTime) || other.raceTime == raceTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,year,month,day,grade,raceName,result,hourseName,age,jockeyName,raceTime);

@override
String toString() {
  return 'HourseRaceResult(id: $id, year: $year, month: $month, day: $day, grade: $grade, raceName: $raceName, result: $result, hourseName: $hourseName, age: $age, jockeyName: $jockeyName, raceTime: $raceTime)';
}


}

/// @nodoc
abstract mixin class $HourseRaceResultCopyWith<$Res>  {
  factory $HourseRaceResultCopyWith(HourseRaceResult value, $Res Function(HourseRaceResult) _then) = _$HourseRaceResultCopyWithImpl;
@useResult
$Res call({
 int id, String? year, String? month, String? day, String? grade,@JsonKey(name: 'race_name') String? raceName, int? result,@JsonKey(name: 'hourse_name') String? hourseName, String? age,@JsonKey(name: 'jockey_name') String? jockeyName,@JsonKey(name: 'race_time') String? raceTime
});




}
/// @nodoc
class _$HourseRaceResultCopyWithImpl<$Res>
    implements $HourseRaceResultCopyWith<$Res> {
  _$HourseRaceResultCopyWithImpl(this._self, this._then);

  final HourseRaceResult _self;
  final $Res Function(HourseRaceResult) _then;

/// Create a copy of HourseRaceResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? year = freezed,Object? month = freezed,Object? day = freezed,Object? grade = freezed,Object? raceName = freezed,Object? result = freezed,Object? hourseName = freezed,Object? age = freezed,Object? jockeyName = freezed,Object? raceTime = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as String?,month: freezed == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String?,day: freezed == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as String?,grade: freezed == grade ? _self.grade : grade // ignore: cast_nullable_to_non_nullable
as String?,raceName: freezed == raceName ? _self.raceName : raceName // ignore: cast_nullable_to_non_nullable
as String?,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as int?,hourseName: freezed == hourseName ? _self.hourseName : hourseName // ignore: cast_nullable_to_non_nullable
as String?,age: freezed == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as String?,jockeyName: freezed == jockeyName ? _self.jockeyName : jockeyName // ignore: cast_nullable_to_non_nullable
as String?,raceTime: freezed == raceTime ? _self.raceTime : raceTime // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [HourseRaceResult].
extension HourseRaceResultPatterns on HourseRaceResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HourseRaceResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HourseRaceResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HourseRaceResult value)  $default,){
final _that = this;
switch (_that) {
case _HourseRaceResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HourseRaceResult value)?  $default,){
final _that = this;
switch (_that) {
case _HourseRaceResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String? year,  String? month,  String? day,  String? grade, @JsonKey(name: 'race_name')  String? raceName,  int? result, @JsonKey(name: 'hourse_name')  String? hourseName,  String? age, @JsonKey(name: 'jockey_name')  String? jockeyName, @JsonKey(name: 'race_time')  String? raceTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HourseRaceResult() when $default != null:
return $default(_that.id,_that.year,_that.month,_that.day,_that.grade,_that.raceName,_that.result,_that.hourseName,_that.age,_that.jockeyName,_that.raceTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String? year,  String? month,  String? day,  String? grade, @JsonKey(name: 'race_name')  String? raceName,  int? result, @JsonKey(name: 'hourse_name')  String? hourseName,  String? age, @JsonKey(name: 'jockey_name')  String? jockeyName, @JsonKey(name: 'race_time')  String? raceTime)  $default,) {final _that = this;
switch (_that) {
case _HourseRaceResult():
return $default(_that.id,_that.year,_that.month,_that.day,_that.grade,_that.raceName,_that.result,_that.hourseName,_that.age,_that.jockeyName,_that.raceTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String? year,  String? month,  String? day,  String? grade, @JsonKey(name: 'race_name')  String? raceName,  int? result, @JsonKey(name: 'hourse_name')  String? hourseName,  String? age, @JsonKey(name: 'jockey_name')  String? jockeyName, @JsonKey(name: 'race_time')  String? raceTime)?  $default,) {final _that = this;
switch (_that) {
case _HourseRaceResult() when $default != null:
return $default(_that.id,_that.year,_that.month,_that.day,_that.grade,_that.raceName,_that.result,_that.hourseName,_that.age,_that.jockeyName,_that.raceTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HourseRaceResult implements HourseRaceResult {
  const _HourseRaceResult({required this.id, this.year, this.month, this.day, this.grade, @JsonKey(name: 'race_name') this.raceName, this.result, @JsonKey(name: 'hourse_name') this.hourseName, this.age, @JsonKey(name: 'jockey_name') this.jockeyName, @JsonKey(name: 'race_time') this.raceTime});
  factory _HourseRaceResult.fromJson(Map<String, dynamic> json) => _$HourseRaceResultFromJson(json);

@override final  int id;
@override final  String? year;
@override final  String? month;
@override final  String? day;
@override final  String? grade;
@override@JsonKey(name: 'race_name') final  String? raceName;
@override final  int? result;
@override@JsonKey(name: 'hourse_name') final  String? hourseName;
@override final  String? age;
@override@JsonKey(name: 'jockey_name') final  String? jockeyName;
@override@JsonKey(name: 'race_time') final  String? raceTime;

/// Create a copy of HourseRaceResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HourseRaceResultCopyWith<_HourseRaceResult> get copyWith => __$HourseRaceResultCopyWithImpl<_HourseRaceResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HourseRaceResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HourseRaceResult&&(identical(other.id, id) || other.id == id)&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.day, day) || other.day == day)&&(identical(other.grade, grade) || other.grade == grade)&&(identical(other.raceName, raceName) || other.raceName == raceName)&&(identical(other.result, result) || other.result == result)&&(identical(other.hourseName, hourseName) || other.hourseName == hourseName)&&(identical(other.age, age) || other.age == age)&&(identical(other.jockeyName, jockeyName) || other.jockeyName == jockeyName)&&(identical(other.raceTime, raceTime) || other.raceTime == raceTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,year,month,day,grade,raceName,result,hourseName,age,jockeyName,raceTime);

@override
String toString() {
  return 'HourseRaceResult(id: $id, year: $year, month: $month, day: $day, grade: $grade, raceName: $raceName, result: $result, hourseName: $hourseName, age: $age, jockeyName: $jockeyName, raceTime: $raceTime)';
}


}

/// @nodoc
abstract mixin class _$HourseRaceResultCopyWith<$Res> implements $HourseRaceResultCopyWith<$Res> {
  factory _$HourseRaceResultCopyWith(_HourseRaceResult value, $Res Function(_HourseRaceResult) _then) = __$HourseRaceResultCopyWithImpl;
@override @useResult
$Res call({
 int id, String? year, String? month, String? day, String? grade,@JsonKey(name: 'race_name') String? raceName, int? result,@JsonKey(name: 'hourse_name') String? hourseName, String? age,@JsonKey(name: 'jockey_name') String? jockeyName,@JsonKey(name: 'race_time') String? raceTime
});




}
/// @nodoc
class __$HourseRaceResultCopyWithImpl<$Res>
    implements _$HourseRaceResultCopyWith<$Res> {
  __$HourseRaceResultCopyWithImpl(this._self, this._then);

  final _HourseRaceResult _self;
  final $Res Function(_HourseRaceResult) _then;

/// Create a copy of HourseRaceResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? year = freezed,Object? month = freezed,Object? day = freezed,Object? grade = freezed,Object? raceName = freezed,Object? result = freezed,Object? hourseName = freezed,Object? age = freezed,Object? jockeyName = freezed,Object? raceTime = freezed,}) {
  return _then(_HourseRaceResult(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as String?,month: freezed == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String?,day: freezed == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as String?,grade: freezed == grade ? _self.grade : grade // ignore: cast_nullable_to_non_nullable
as String?,raceName: freezed == raceName ? _self.raceName : raceName // ignore: cast_nullable_to_non_nullable
as String?,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as int?,hourseName: freezed == hourseName ? _self.hourseName : hourseName // ignore: cast_nullable_to_non_nullable
as String?,age: freezed == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as String?,jockeyName: freezed == jockeyName ? _self.jockeyName : jockeyName // ignore: cast_nullable_to_non_nullable
as String?,raceTime: freezed == raceTime ? _self.raceTime : raceTime // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
