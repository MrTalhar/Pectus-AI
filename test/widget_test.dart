// Basic Flutter widget test for Pectus App.
import 'package:flutter_test/flutter_test.dart';
import 'package:pectus_app/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const PectusApp());
    // App should render without throwing.
    expect(tester.takeException(), isNull);
  });
}
