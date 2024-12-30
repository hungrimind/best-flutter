// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:demo/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Check for ElevatedButton above TextButton',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Find the widgets
    final elevatedButtonFinder = find.text('ElevatedButton');
    final textButtonFinder = find.text('TextButton');

    // Get the render boxes for both widgets
    final elevatedButtonBox = tester.getRect(elevatedButtonFinder);
    final textButtonBox = tester.getRect(textButtonFinder);

    // Verify both widgets exist
    expect(elevatedButtonFinder, findsOneWidget);
    expect(textButtonFinder, findsOneWidget);

    // Check if ElevatedButton is above TextButton
    expect(elevatedButtonBox.bottom <= textButtonBox.top, true);
  });
}
