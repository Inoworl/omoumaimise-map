import 'package:flutter_test/flutter_test.dart';
import 'package:omoumaimise_map/main.dart';

void main() {
  testWidgets('shows hello world', (WidgetTester tester) async {
    await tester.pumpWidget(const OmoumaiApp());

    expect(find.text('Hello world'), findsOneWidget);
  });
}
