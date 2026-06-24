import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:omoumaimise_map/app/app.dart';

void main() {
  testWidgets('shows hello world', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: OmoumaiApp()));

    expect(find.text('Hello world'), findsOneWidget);
    expect(find.text('Environment: dev'), findsOneWidget);
    expect(find.text('Supabase is not configured'), findsOneWidget);
  });
}
