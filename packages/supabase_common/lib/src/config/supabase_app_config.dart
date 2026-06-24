import 'package:app_common/app_common.dart';

class SupabaseAppConfig {
  const SupabaseAppConfig({
    required this.environment,
    required this.url,
    required this.publishableKey,
  });

  factory SupabaseAppConfig.fromDartDefines() {
    return SupabaseAppConfig(
      environment: AppEnvironment.fromName(
        const String.fromEnvironment('APP_ENV', defaultValue: 'dev'),
      ),
      url: const String.fromEnvironment('SUPABASE_URL'),
      publishableKey: const String.fromEnvironment('SUPABASE_PUBLISHABLE_KEY'),
    );
  }

  final AppEnvironment environment;
  final String url;
  final String publishableKey;

  bool get isConfigured => url.isNotEmpty && publishableKey.isNotEmpty;
}
