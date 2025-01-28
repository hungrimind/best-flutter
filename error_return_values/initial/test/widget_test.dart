import 'package:flutter_test/flutter_test.dart';

import 'package:demo/main.dart';

void main() {
  testWidgets('Network status test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that we start with 'No issues' status
    expect(
      find.text('No issues'),
      findsOneWidget,
      reason: 'Should start with No issues status',
    );
  });
}
