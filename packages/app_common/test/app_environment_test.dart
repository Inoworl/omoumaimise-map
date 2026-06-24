import 'package:app_common/app_common.dart';
import 'package:test/test.dart';

void main() {
  group('AppEnvironment', () {
    test('defaults to dev', () {
      expect(AppEnvironment.fromName(null), AppEnvironment.dev);
      expect(AppEnvironment.fromName(''), AppEnvironment.dev);
    });

    test('parses supported names', () {
      expect(AppEnvironment.fromName('local'), AppEnvironment.local);
      expect(AppEnvironment.fromName('dev'), AppEnvironment.dev);
      expect(AppEnvironment.fromName('prod'), AppEnvironment.prod);
    });

    test('rejects unsupported names', () {
      expect(() => AppEnvironment.fromName('staging'), throwsArgumentError);
    });
  });
}
