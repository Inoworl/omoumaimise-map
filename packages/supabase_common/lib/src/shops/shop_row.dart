import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:map_domain/map_domain.dart';

part 'shop_row.freezed.dart';
part 'shop_row.g.dart';

@freezed
abstract class ShopRow with _$ShopRow {
  const factory ShopRow({
    required String id,
    required String name,
    @JsonKey(name: 'prefecture_name') required String prefectureName,
    required double latitude,
    required double longitude,
  }) = _ShopRow;

  factory ShopRow.fromJson(Map<String, dynamic> json) =>
      _$ShopRowFromJson(json);
}

extension ShopRowMapper on ShopRow {
  Shop toDomain() {
    return Shop(
      id: id,
      name: name,
      prefecture: prefectureName,
      latitude: latitude,
      longitude: longitude,
    );
  }
}
