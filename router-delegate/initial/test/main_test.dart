import 'package:demo/first.dart';
import 'package:demo/second.dart';
import 'package:demo/third.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:demo/main.dart';

void main() {
  testWidgets(
    'Testing the whole navigation flow',
    (WidgetTester tester) async {
      // Build our app and trigger a frame
      await tester.pumpWidget(const MyApp());

      // Wait for the router delegate to initialize
      await tester.pumpAndSettle();

      // Verify we start on the first page
      expect(find.byType(FirstPage), findsOneWidget,
          reason: 'App should initialize with FirstPage as the initial route');

      // Test navigation to second page
      await tester.tap(find.text('Go to Second'));
      await tester.pumpAndSettle();
      expect(find.byType(SecondPage), findsOneWidget,
          reason: 'Tapping "Go to Second" should navigate to SecondPage');

      // Test back navigation
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();
      expect(find.byType(FirstPage), findsOneWidget,
          reason: 'Back button should return to FirstPage');

      // Test navigation to second and third pages
      await tester.tap(find.text('Add Second and Third'));
      await tester.pumpAndSettle();
      expect(find.byType(ThirdPage), findsOneWidget,
          reason:
              'Tapping "Add Second and Third" should navigate to ThirdPage');

      // Test removing middle page from third page
      await tester.tap(find.text('Remove middle page'));
      await tester.pumpAndSettle();
      expect(find.byType(ThirdPage), findsOneWidget,
          reason: 'Removing middle page should keep ThirdPage visible');

      // Test back navigation from third page
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();
      expect(find.byType(FirstPage), findsOneWidget,
          reason: 'Back button from ThirdPage should return to FirstPage');
    },
  );
}
