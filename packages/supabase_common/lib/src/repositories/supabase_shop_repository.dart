import 'package:map_domain/map_domain.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_common/src/shops/shop_row.dart';

class SupabaseShopRepository {
  const SupabaseShopRepository(this._client);

  final SupabaseClient _client;

  Future<List<Shop>> fetchPublishedShops({int limit = 20}) async {
    final rows = await _client
        .from('shops')
        .select('id,name,prefecture_name,latitude,longitude')
        .eq('status', 'published')
        .order('name')
        .limit(limit);

    return rows
        .map((row) => ShopRow.fromJson(row).toDomain())
        .toList(growable: false);
  }
}
