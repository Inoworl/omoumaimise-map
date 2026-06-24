// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_row.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ShopRow _$ShopRowFromJson(Map<String, dynamic> json) => _ShopRow(
  id: json['id'] as String,
  name: json['name'] as String,
  prefectureName: json['prefecture_name'] as String,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
);

Map<String, dynamic> _$ShopRowToJson(_ShopRow instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'prefecture_name': instance.prefectureName,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
};
