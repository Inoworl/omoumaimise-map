// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shop_row.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ShopRow {

 String get id; String get name;@JsonKey(name: 'prefecture_name') String get prefectureName; double get latitude; double get longitude;
/// Create a copy of ShopRow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShopRowCopyWith<ShopRow> get copyWith => _$ShopRowCopyWithImpl<ShopRow>(this as ShopRow, _$identity);

  /// Serializes this ShopRow to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShopRow&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.prefectureName, prefectureName) || other.prefectureName == prefectureName)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,prefectureName,latitude,longitude);

@override
String toString() {
  return 'ShopRow(id: $id, name: $name, prefectureName: $prefectureName, latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class $ShopRowCopyWith<$Res>  {
  factory $ShopRowCopyWith(ShopRow value, $Res Function(ShopRow) _then) = _$ShopRowCopyWithImpl;
@useResult
$Res call({
 String id, String name,@JsonKey(name: 'prefecture_name') String prefectureName, double latitude, double longitude
});




}
/// @nodoc
class _$ShopRowCopyWithImpl<$Res>
    implements $ShopRowCopyWith<$Res> {
  _$ShopRowCopyWithImpl(this._self, this._then);

  final ShopRow _self;
  final $Res Function(ShopRow) _then;

/// Create a copy of ShopRow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? prefectureName = null,Object? latitude = null,Object? longitude = null,}) {
  return _then(ShopRow(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,prefectureName: null == prefectureName ? _self.prefectureName : prefectureName // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ShopRow].
extension ShopRowPatterns on ShopRow {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShopRow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShopRow() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShopRow value)  $default,){
final _that = this;
switch (_that) {
case _ShopRow():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShopRow value)?  $default,){
final _that = this;
switch (_that) {
case _ShopRow() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name, @JsonKey(name: 'prefecture_name')  String prefectureName,  double latitude,  double longitude)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShopRow() when $default != null:
return $default(_that.id,_that.name,_that.prefectureName,_that.latitude,_that.longitude);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name, @JsonKey(name: 'prefecture_name')  String prefectureName,  double latitude,  double longitude)  $default,) {final _that = this;
switch (_that) {
case _ShopRow():
return $default(_that.id,_that.name,_that.prefectureName,_that.latitude,_that.longitude);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name, @JsonKey(name: 'prefecture_name')  String prefectureName,  double latitude,  double longitude)?  $default,) {final _that = this;
switch (_that) {
case _ShopRow() when $default != null:
return $default(_that.id,_that.name,_that.prefectureName,_that.latitude,_that.longitude);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShopRow implements ShopRow {
  const _ShopRow({required this.id, required this.name, @JsonKey(name: 'prefecture_name') required this.prefectureName, required this.latitude, required this.longitude});
  factory _ShopRow.fromJson(Map<String, dynamic> json) => _$ShopRowFromJson(json);

@override final  String id;
@override final  String name;
@override@JsonKey(name: 'prefecture_name') final  String prefectureName;
@override final  double latitude;
@override final  double longitude;

/// Create a copy of ShopRow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShopRowCopyWith<_ShopRow> get copyWith => __$ShopRowCopyWithImpl<_ShopRow>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShopRowToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShopRow&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.prefectureName, prefectureName) || other.prefectureName == prefectureName)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,prefectureName,latitude,longitude);

@override
String toString() {
  return 'ShopRow(id: $id, name: $name, prefectureName: $prefectureName, latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class _$ShopRowCopyWith<$Res> implements $ShopRowCopyWith<$Res> {
  factory _$ShopRowCopyWith(_ShopRow value, $Res Function(_ShopRow) _then) = __$ShopRowCopyWithImpl;
@override @useResult
$Res call({
 String id, String name,@JsonKey(name: 'prefecture_name') String prefectureName, double latitude, double longitude
});




}
/// @nodoc
class __$ShopRowCopyWithImpl<$Res>
    implements _$ShopRowCopyWith<$Res> {
  __$ShopRowCopyWithImpl(this._self, this._then);

  final _ShopRow _self;
  final $Res Function(_ShopRow) _then;

/// Create a copy of ShopRow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? prefectureName = null,Object? latitude = null,Object? longitude = null,}) {
  return _then(_ShopRow(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,prefectureName: null == prefectureName ? _self.prefectureName : prefectureName // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
