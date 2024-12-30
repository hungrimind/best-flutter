// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:demo/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Widgets contains all required elements',
      (WidgetTester tester) async {
    // Build our widget and trigger a frame
    await tester.pumpWidget(const MaterialApp(home: Widgets()));

    // Verify Text widget
    expect(find.text('Simple Text Widget'), findsOneWidget);

    // Verify ListTile and its contents
    expect(find.byType(ListTile), findsOneWidget);
    expect(find.text('List Tile Widget'), findsOneWidget);
    expect(find.byIcon(Icons.star), findsOneWidget);

    // Verify FlutterLogo
    expect(find.byType(FlutterLogo), findsOneWidget);
  });
}
