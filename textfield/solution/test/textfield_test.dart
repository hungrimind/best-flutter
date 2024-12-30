// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:demo/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('TextField updates display text when button is clicked',
      (WidgetTester tester) async {
    // Build the TextFieldExample widget
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: TextFieldExample(),
      ),
    ));

    // Enter text into the TextField
    await tester.enterText(find.byType(TextField), 'Hello, Flutter!');

    // Verify the display text hasn't changed yet
    expect(find.text('You typed: '), findsOneWidget);
    expect(find.text('You typed: Hello, Flutter!'), findsNothing);

    // Tap the "Update Display" button
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Verify the display text has updated
    expect(find.text('You typed: Hello, Flutter!'), findsOneWidget);
  });
}
