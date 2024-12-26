import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:demo/demo.dart';

void main() {
  testWidgets('Layout contains Row with three colored containers', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(const MaterialApp(home: LayoutDemo()));

    // Find the Row widget
    final rowFinder = find.byType(Row);
    expect(rowFinder, findsOneWidget);

    // Find all containers
    final containerFinder = find.byType(Container);
    expect(containerFinder, findsNWidgets(3));

    // Get the actual Container widgets
    final containers = tester.widgetList<Container>(containerFinder);

    // Verify the properties of each container
    int index = 0;
    final expectedColors = [Colors.red, Colors.green, Colors.blue];
    
    for (var container in containers) {
      expect((container.constraints)?.maxWidth, 50);
      expect((container.constraints)?.maxHeight, 50);
      expect(container.color, expectedColors[index]);
      index++;
    }
  });
}