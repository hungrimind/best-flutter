import 'package:demo/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Layout contains Row with three colored containers',
      (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(const MaterialApp(home: LayoutDemo()));

    // Find the Row widget
    final rowFinder = find.byType(Row);
    expect(rowFinder, findsOneWidget,
        reason: 'The layout should contain exactly one Row widget');

    // Verify the Row has MainAxisAlignment.center
    final row = tester.widget<Row>(rowFinder);
    expect(row.mainAxisAlignment, MainAxisAlignment.center,
        reason: 'The Row should center its children horizontally');

    // Find all containers
    final containerFinder = find.byType(Container);
    expect(containerFinder, findsNWidgets(3),
        reason:
            'The layout should contain exactly three containers, one for each color');

    // Get the actual Container widgets
    final containers = tester.widgetList<Container>(containerFinder);

    // Verify the properties of each container
    int index = 0;
    final expectedColors = [Colors.red, Colors.green, Colors.blue];

    for (var container in containers) {
      expect((container.constraints)?.maxWidth, 50,
          reason: 'Each container should have a width of 50 logical pixels');
      expect((container.constraints)?.maxHeight, 50,
          reason: 'Each container should have a height of 50 logical pixels');
      expect(container.color, expectedColors[index],
          reason: 'Container ${index + 1} should be ${expectedColors[index]}');
      index++;
    }
  });
}
