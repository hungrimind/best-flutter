import 'package:demo/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:demo/main.dart';

void main() {
  setUp(() {
    setupLocator();
  });

  tearDown(() {
    locator.reset();
  });

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

  testWidgets('Date service should update the date when button is tapped',
      (WidgetTester tester) async {
    // Capture the time just before widget creation
    final beforeTime = DateTime.now();

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Get the initial date displayed
    String initialDateText = '';
    tester.widget<Text>(find.byWidgetPredicate((widget) {
      if (widget is Text) {
        try {
          DateTime.parse(widget.data!);
          initialDateText = widget.data!;
          return true;
        } catch (e) {
          return false;
        }
      }
      return false;
    }));

    // Tap the update date button
    await tester.tap(find.byIcon(Icons.update));
    await tester.pump();

    // Find the displayed date text after update
    final dateTextFinder = find.byWidgetPredicate((widget) {
      if (widget is Text) {
        try {
          final displayedDate = DateTime.parse(widget.data!);
          // Verify the displayed date is between before and after our widget creation
          return displayedDate.isAfter(beforeTime) &&
              widget.data != initialDateText; // Make sure it changed
        } catch (e) {
          return false;
        }
      }
      return false;
    });

    expect(dateTextFinder, findsOneWidget,
        reason:
            'Should find a Text widget with an updated DateTime different from initial value');
  });
}
