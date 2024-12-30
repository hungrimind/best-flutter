import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:demo/main.dart';

void main() {
  testWidgets('Navigation from home to second page works', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const MyApp());

    // Verify we're on the home page initially by checking AppBar title
    expect(
      find.descendant(
        of: find.byType(AppBar),
        matching: find.text('Home Screen'),
      ),
      findsOneWidget,
    );

    // Find and tap the navigation button
    final buttonFinder = find.text('Go to Second Screen');
    await tester.tap(buttonFinder);
    
    // Wait for navigation animation to complete
    await tester.pumpAndSettle();

    // Verify we're now on the second page by checking AppBar title
    expect(
      find.descendant(
        of: find.byType(AppBar),
        matching: find.text('Second Screen'),
      ),
      findsOneWidget,
    );
  });


  testWidgets('Navigation pop from second page to home works', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const MyApp());

    // Navigate to second page
    await tester.tap(find.text('Go to Second Screen'));
    await tester.pumpAndSettle();

    // Verify we're on second page
    expect(
      find.descendant(
        of: find.byType(AppBar),
        matching: find.text('Second Screen'),
      ),
      findsOneWidget,
    );

    // Find and tap the back button
    await tester.tap(find.text('Go Back'));
    await tester.pumpAndSettle();

    // Verify we're back on the home page
    expect(
      find.descendant(
        of: find.byType(AppBar),
        matching: find.text('Home Screen'),
      ),
      findsOneWidget,
    );
  });
}