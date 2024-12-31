// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:demo/form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoginForm', () {
    testWidgets('shows error when submitting empty form', (tester) async {
      await tester
          .pumpWidget(const MaterialApp(home: Scaffold(body: LoginForm())));

      // Try to submit without entering text
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Verify error message is shown
      expect(find.text('Field cannot be empty'), findsOneWidget);
    });

    testWidgets('shows error when text is less than 10 characters',
        (tester) async {
      await tester
          .pumpWidget(const MaterialApp(home: Scaffold(body: LoginForm())));

      // Enter short text
      await tester.enterText(find.byType(TextFormField), 'Short');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Verify correct error message is shown
      expect(find.text('Field must be at least 10 characters'), findsOneWidget);
    });

    testWidgets('shows success message when valid input is submitted',
        (tester) async {
      await tester
          .pumpWidget(const MaterialApp(home: Scaffold(body: LoginForm())));

      // Enter valid text (more than 10 characters)
      const validInput = 'This is a valid input';
      await tester.enterText(find.byType(TextFormField), validInput);
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Verify success message in SnackBar
      expect(find.text('Saved: $validInput'), findsOneWidget);
    });
  });
}
