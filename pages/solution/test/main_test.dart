import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/main.dart';

void main() {
  testWidgets(
      'The app should initialize with 3 pages and handle back navigation',
      (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(const MyApp());

    // Wait for all animations and async operations to complete
    await tester.pumpAndSettle();

    // Find the Navigator that's a direct child of MaterialApp
    final navigator = tester.widget<Navigator>(
      find
          .descendant(
            of: find.byType(MaterialApp),
            matching: find.byType(Navigator),
          )
          .last,
    );

    // Verify that we have 3 pages in the navigation stack
    expect(navigator.pages.length, 3,
        reason: 'App should initialize with 3 pages');

    // Verify that the third page is visible initially
    expect(find.text('Third Page'), findsOneWidget,
        reason: 'Third page should be visible initially');
    expect(find.text('Second Page'), findsNothing,
        reason: 'Second page should not be visible initially');
    expect(find.text('First Page'), findsNothing,
        reason: 'First page should not be visible initially');

    // Simulate back button press
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    // Verify that we're now on the second page
    expect(find.text('Third Page'), findsNothing,
        reason: 'Third page should not be visible after back');
    expect(find.text('Second Page'), findsOneWidget,
        reason: 'Second page should be visible after back');
    expect(find.text('First Page'), findsNothing,
        reason: 'First page should not be visible after back');
  });
}
