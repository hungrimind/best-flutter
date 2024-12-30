import 'package:demo/configure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Container should have correct dimensions',
      (WidgetTester tester) async {
    // Build the Demo widget
    await tester.pumpWidget(const MaterialApp(home: Demo()));

    // Find the Container
    final containerFinder = find.byType(Container);
    final container = tester.widget<Container>(containerFinder);

    // Verify dimensions
    expect(container.constraints?.maxHeight, 200);
    expect(container.constraints?.maxWidth, 400);
  });

  testWidgets('Container should have correct padding',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Demo()));

    // Find the Container
    final containerFinder = find.byType(Container);
    final container = tester.widget<Container>(containerFinder);

    // Verify padding
    expect(container.padding, const EdgeInsets.all(20));
  });

  testWidgets('Container should have correct border decoration',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Demo()));

    // Find the Container
    final containerFinder = find.byType(Container);
    final container = tester.widget<Container>(containerFinder);

    // Get the BoxDecoration
    final decoration = container.decoration as BoxDecoration;

    // Verify border properties
    expect(decoration.border?.top.width, 3);
    expect(decoration.border?.top.color, Colors.black);
    expect(decoration.borderRadius, BorderRadius.circular(10));
    expect(decoration.color, Colors.blue);
  });
}
