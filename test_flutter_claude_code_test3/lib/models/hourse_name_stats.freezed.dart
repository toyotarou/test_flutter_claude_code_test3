// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hourse_name_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HourseNameStats {

@JsonKey(name: 'hourse_name') String get hourseName;@JsonKey(name: 'race_count') int get raceCount;@JsonKey(name: 'last_year') String get lastYear;
/// Create a copy of HourseNameStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HourseNameStatsCopyWith<HourseNameStats> get copyWith => _$HourseNameStatsCopyWithImpl<HourseNameStats>(this as HourseNameStats, _$identity);

  /// Serializes this HourseNameStats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HourseNameStats&&(identical(other.hourseName, hourseName) || other.hourseName == hourseName)&&(identical(other.raceCount, raceCount) || other.raceCount == raceCount)&&(identical(other.lastYear, lastYear) || other.lastYear == lastYear));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hourseName,raceCount,lastYear);

@override
String toString() {
  return 'HourseNameStats(hourseName: $hourseName, raceCount: $raceCount, lastYear: $lastYear)';
}


}

/// @nodoc
abstract mixin class $HourseNameStatsCopyWith<$Res>  {
  factory $HourseNameStatsCopyWith(HourseNameStats value, $Res Function(HourseNameStats) _then) = _$HourseNameStatsCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'hourse_name') String hourseName,@JsonKey(name: 'race_count') int raceCount,@JsonKey(name: 'last_year') String lastYear
});




}
/// @nodoc
class _$HourseNameStatsCopyWithImpl<$Res>
    implements $HourseNameStatsCopyWith<$Res> {
  _$HourseNameStatsCopyWithImpl(this._self, this._then);

  final HourseNameStats _self;
  final $Res Function(HourseNameStats) _then;

/// Create a copy of HourseNameStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hourseName = null,Object? raceCount = null,Object? lastYear = null,}) {
  return _then(_self.copyWith(
hourseName: null == hourseName ? _self.hourseName : hourseName // ignore: cast_nullable_to_non_nullable
as String,raceCount: null == raceCount ? _self.raceCount : raceCount // ignore: cast_nullable_to_non_nullable
as int,lastYear: null == lastYear ? _self.lastYear : lastYear // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [HourseNameStats].
extension HourseNameStatsPatterns on HourseNameStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HourseNameStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HourseNameStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HourseNameStats value)  $default,){
final _that = this;
switch (_that) {
case _HourseNameStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HourseNameStats value)?  $default,){
final _that = this;
switch (_that) {
case _HourseNameStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'hourse_name')  String hourseName, @JsonKey(name: 'race_count')  int raceCount, @JsonKey(name: 'last_year')  String lastYear)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HourseNameStats() when $default != null:
return $default(_that.hourseName,_that.raceCount,_that.lastYear);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'hourse_name')  String hourseName, @JsonKey(name: 'race_count')  int raceCount, @JsonKey(name: 'last_year')  String lastYear)  $default,) {final _that = this;
switch (_that) {
case _HourseNameStats():
return $default(_that.hourseName,_that.raceCount,_that.lastYear);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'hourse_name')  String hourseName, @JsonKey(name: 'race_count')  int raceCount, @JsonKey(name: 'last_year')  String lastYear)?  $default,) {final _that = this;
switch (_that) {
case _HourseNameStats() when $default != null:
return $default(_that.hourseName,_that.raceCount,_that.lastYear);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HourseNameStats implements HourseNameStats {
  const _HourseNameStats({@JsonKey(name: 'hourse_name') required this.hourseName, @JsonKey(name: 'race_count') required this.raceCount, @JsonKey(name: 'last_year') required this.lastYear});
  factory _HourseNameStats.fromJson(Map<String, dynamic> json) => _$HourseNameStatsFromJson(json);

@override@JsonKey(name: 'hourse_name') final  String hourseName;
@override@JsonKey(name: 'race_count') final  int raceCount;
@override@JsonKey(name: 'last_year') final  String lastYear;

/// Create a copy of HourseNameStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HourseNameStatsCopyWith<_HourseNameStats> get copyWith => __$HourseNameStatsCopyWithImpl<_HourseNameStats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HourseNameStatsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HourseNameStats&&(identical(other.hourseName, hourseName) || other.hourseName == hourseName)&&(identical(other.raceCount, raceCount) || other.raceCount == raceCount)&&(identical(other.lastYear, lastYear) || other.lastYear == lastYear));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hourseName,raceCount,lastYear);

@override
String toString() {
  return 'HourseNameStats(hourseName: $hourseName, raceCount: $raceCount, lastYear: $lastYear)';
}


}

/// @nodoc
abstract mixin class _$HourseNameStatsCopyWith<$Res> implements $HourseNameStatsCopyWith<$Res> {
  factory _$HourseNameStatsCopyWith(_HourseNameStats value, $Res Function(_HourseNameStats) _then) = __$HourseNameStatsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'hourse_name') String hourseName,@JsonKey(name: 'race_count') int raceCount,@JsonKey(name: 'last_year') String lastYear
});




}
/// @nodoc
class __$HourseNameStatsCopyWithImpl<$Res>
    implements _$HourseNameStatsCopyWith<$Res> {
  __$HourseNameStatsCopyWithImpl(this._self, this._then);

  final _HourseNameStats _self;
  final $Res Function(_HourseNameStats) _then;

/// Create a copy of HourseNameStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hourseName = null,Object? raceCount = null,Object? lastYear = null,}) {
  return _then(_HourseNameStats(
hourseName: null == hourseName ? _self.hourseName : hourseName // ignore: cast_nullable_to_non_nullable
as String,raceCount: null == raceCount ? _self.raceCount : raceCount // ignore: cast_nullable_to_non_nullable
as int,lastYear: null == lastYear ? _self.lastYear : lastYear // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
