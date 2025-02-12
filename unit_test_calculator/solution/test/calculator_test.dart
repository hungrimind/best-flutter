import 'package:flutter_test/flutter_test.dart';
import 'package:demo/calculator.dart';

void main() {
  late Calculator calculator;

  setUp(() {
    calculator = Calculator();
  });

  group('Calculator', () {
    test('add should return the sum of two numbers', () {
      // Arrange - done in setUp
      // Act
      final result = calculator.add(2, 3);
      // Assert
      expect(result, equals(5));
    });

    test('subtract should return the difference of two numbers', () {
      final result = calculator.subtract(5, 3);
      expect(result, equals(2));
    });

    test('multiply should return the product of two numbers', () {
      final result = calculator.multiply(4, 3);
      expect(result, equals(12));
    });

    test('divide should return the quotient of two numbers', () {
      final result = calculator.divide(10, 2);
      expect(result, equals(5.0));
    });

    test('divide by zero should throw ArgumentError', () {
      expect(
        () => calculator.divide(10, 0),
        throwsA(isA<ArgumentError>()),
      );
    });
  });
}
