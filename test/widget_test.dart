import 'package:flutter_test/flutter_test.dart';
import 'package:eshopify/main.dart';

void main() {
  testWidgets('App builds smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const EshopifyApp());
    await tester.pump();
    expect(find.byType(EshopifyApp), findsOneWidget);
  });
}
