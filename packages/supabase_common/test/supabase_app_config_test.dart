import 'package:app_common/app_common.dart';
import 'package:supabase_common/supabase_common.dart';
import 'package:test/test.dart';

void main() {
  group('SupabaseAppConfig', () {
    test('is configured when url and publishable key are present', () {
      const config = SupabaseAppConfig(
        environment: AppEnvironment.local,
        url: 'http://127.0.0.1:54321',
        publishableKey: 'publishable-key',
      );

      expect(config.isConfigured, isTrue);
    });

    test('is not configured when either value is missing', () {
      const missingUrl = SupabaseAppConfig(
        environment: AppEnvironment.dev,
        url: '',
        publishableKey: 'publishable-key',
      );
      const missingKey = SupabaseAppConfig(
        environment: AppEnvironment.dev,
        url: 'http://127.0.0.1:54321',
        publishableKey: '',
      );

      expect(missingUrl.isConfigured, isFalse);
      expect(missingKey.isConfigured, isFalse);
    });
  });
}
