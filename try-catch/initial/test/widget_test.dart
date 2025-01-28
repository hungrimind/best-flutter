import 'package:flutter/material.dart';
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
    // Tap the network check button and trigger a frame
    await tester.tap(find.byIcon(Icons.network_check));
    await tester.pump();

    expect(
      find.text('No issues'),
      findsNothing,
      reason: 'No issues status should no longer be visible',
    );
    expect(
      find.text('Fake lesson exception: Thanks for catching me!'),
      findsOneWidget,
      reason: 'Should show FakeLessonException after tapping the button',
    );
  });
}
