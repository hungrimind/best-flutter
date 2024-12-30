// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:demo/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Container padding and margin test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Find the containers by their text
    final paddedContainer = find.text('Padded Text').first;
    final marginContainer = find.text('Margin Text').first;

    // Get the parent Container widgets
    final paddedParent = tester.widget<Container>(
      find
          .ancestor(
            of: paddedContainer,
            matching: find.byType(Container),
          )
          .first,
    );

    final marginParent = tester.widget<Container>(
      find
          .ancestor(
            of: marginContainer,
            matching: find.byType(Container),
          )
          .first,
    );

    // Verify padding value
    expect(paddedParent.padding, const EdgeInsets.all(16.0));

    // Verify margin value
    expect(marginParent.margin, const EdgeInsets.all(16.0));
  });
}
