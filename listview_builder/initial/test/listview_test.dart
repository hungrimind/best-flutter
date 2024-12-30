// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:demo/listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ListView.builder displays correct items',
      (WidgetTester tester) async {
    // Build our widget and trigger a frame
    await tester.pumpWidget(const MaterialApp(
      home: ListViewBuilderExample(),
    ));

    // Verify the AppBar title
    expect(find.text('ListView.builder Example'), findsOneWidget);

    // Verify initial items are rendered (Flutter usually renders enough items to fill the screen)
    expect(find.text('item 0'), findsOneWidget);
    expect(find.text('item 1'), findsOneWidget);
    expect(find.text('item 2'), findsOneWidget);

    // Scroll down to reveal more items
    await tester.dragFrom(
      tester.getCenter(find.byType(ListView)),
      const Offset(0, -100), // Scroll up by 300 pixels
    );
    await tester.pumpAndSettle();

    // Verify that new items are visible after scrolling
    expect(find.text('item 10'),
        findsOneWidget); // Approximate index, might need adjustment

    // Verify that item 0 is no longer visible
    expect(find.text('item 0'), findsNothing);
  });
}
