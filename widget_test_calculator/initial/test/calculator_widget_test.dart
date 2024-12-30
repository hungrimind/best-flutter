import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:demo/calculator_page.dart';

void main() {
  group('CalculatorWidget', () {
    testWidgets('should show initial empty state', (tester) async {
      // Arrange
      await tester.pumpWidget(const MaterialApp(home: CalculatorPage()));

      // Assert
      expect(find.text('First Number'), findsOneWidget);
      expect(find.text('Second Number'), findsOneWidget);
      expect(find.text('Calculate'), findsOneWidget);
      expect(find.text('Result:'), findsNothing);
    });

    testWidgets('should perform addition correctly', (tester) async {
      // Arrange
      await tester.pumpWidget(const MaterialApp(home: CalculatorPage()));

      // Act
      await tester.enterText(find.byType(TextField).first, '5');
      await tester.enterText(find.byType(TextField).last, '3');
      await tester.tap(find.text('+'));
      await tester.pump();
      await tester.tap(find.text('Calculate'));
      await tester.pump();

      // Assert
      expect(find.text('Result: 8'), findsOneWidget);
    });

    testWidgets('should perform subtraction correctly', (tester) async {
      // Arrange
      await tester.pumpWidget(const MaterialApp(home: CalculatorPage()));

      // Act
      await tester.enterText(find.byType(TextField).first, '8');
      await tester.enterText(find.byType(TextField).last, '3');
      await tester.tap(find.text('-'));
      await tester.pump();
      await tester.tap(find.text('Calculate'));
      await tester.pump();

      // Assert
      expect(find.text('Result: 5'), findsOneWidget);
    });

    testWidgets('should perform multiplication correctly', (tester) async {
      // Arrange
      await tester.pumpWidget(const MaterialApp(home: CalculatorPage()));

      // Act
      await tester.enterText(find.byType(TextField).first, '4');
      await tester.enterText(find.byType(TextField).last, '3');
      await tester.tap(find.text('*'));
      await tester.pump();
      await tester.tap(find.text('Calculate'));
      await tester.pump();

      // Assert
      expect(find.text('Result: 12'), findsOneWidget);
    });

    testWidgets('should perform division correctly', (tester) async {
      // Arrange
      await tester.pumpWidget(const MaterialApp(home: CalculatorPage()));

      // Act
      await tester.enterText(find.byType(TextField).first, '10');
      await tester.enterText(find.byType(TextField).last, '2');
      await tester.tap(find.text('/'));
      await tester.pump();
      await tester.tap(find.text('Calculate'));
      await tester.pump();

      // Assert
      expect(find.text('Result: 5.0'), findsOneWidget);
    });

    testWidgets('should handle division by zero', (tester) async {
      // Arrange
      await tester.pumpWidget(const MaterialApp(home: CalculatorPage()));

      // Act
      await tester.enterText(find.byType(TextField).first, '10');
      await tester.enterText(find.byType(TextField).last, '0');
      await tester.tap(find.text('/'));
      await tester.pump();
      await tester.tap(find.text('Calculate'));
      await tester.pump();

      // Assert
      expect(find.text('Result: Error'), findsOneWidget);
    });
  });
}