import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:map_domain/map_domain.dart';
import 'package:supabase_common/supabase_common.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabaseConfigProvider = Provider<SupabaseAppConfig>((ref) {
  return SupabaseAppConfig.fromDartDefines();
});

final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  final config = ref.watch(supabaseConfigProvider);

  if (!config.isConfigured) {
    throw StateError('Supabase is not configured');
  }

  return SupabaseClient(config.url, config.publishableKey);
});

final shopRepositoryProvider = Provider<SupabaseShopRepository>((ref) {
  return SupabaseShopRepository(ref.watch(supabaseClientProvider));
});

final publishedShopsProvider = FutureProvider.autoDispose<List<Shop>>((
  ref,
) async {
  return ref.watch(shopRepositoryProvider).fetchPublishedShops();
});
