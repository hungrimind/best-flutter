import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:demo/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(
      find.text('0'),
      findsOneWidget,
      reason: 'Counter should start at 0',
    );
    expect(
      find.text('1'),
      findsNothing,
      reason: 'Should not find text "1" before incrementing',
    );

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(
      find.text('0'),
      findsNothing,
      reason: 'Counter should no longer show 0 after incrementing',
    );
    expect(
      find.text('2'),
      findsOneWidget,
      reason: 'Counter should show 2 after incrementing',
    );
  });
}
