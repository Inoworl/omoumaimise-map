import 'package:supabase_common/supabase_common.dart';
import 'package:test/test.dart';

void main() {
  test('maps shop row json to domain shop', () {
    final row = ShopRow.fromJson({
      'id': '00000000-0000-4000-8000-000000000101',
      'name': 'サンプル食堂 東京',
      'prefecture_name': '東京都',
      'latitude': 35.681236,
      'longitude': 139.767125,
    });

    final shop = row.toDomain();

    expect(shop.id, '00000000-0000-4000-8000-000000000101');
    expect(shop.name, 'サンプル食堂 東京');
    expect(shop.prefecture, '東京都');
    expect(shop.latitude, 35.681236);
    expect(shop.longitude, 139.767125);
  });
}
