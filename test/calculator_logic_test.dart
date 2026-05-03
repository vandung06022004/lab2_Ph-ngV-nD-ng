import 'package:flutter_test/flutter_test.dart';
import 'package:calculator_app/calculator_logic.dart';

void main() {
  group('CalculatorLogic Tests', () {
    late CalculatorLogic calc;

    setUp(() {
      calc = CalculatorLogic();
    });

    // Test 1: Basic addition
    test('5 + 3 = 8', () {
      calc.onNumber('5');
      calc.onOperation('+');
      calc.onNumber('3');
      calc.onEquals();
      expect(calc.display, '8');
    });

    // Test 2: Decimal multiplication
    test('3.5 × 2 = 7', () {
      calc.onNumber('3');
      calc.onDecimal();
      calc.onNumber('5');
      calc.onOperation('×');
      calc.onNumber('2');
      calc.onEquals();
      expect(calc.display, '7');
    });

    // Test 3: Negative number
    test('-5 + 3 = -2', () {
      calc.onNumber('5');
      calc.onPlusMinus();
      calc.onOperation('+');
      calc.onNumber('3');
      calc.onEquals();
      expect(calc.display, '-2');
    });

    // Test 4: Division by zero
    test('Division by zero returns Error', () {
      calc.onNumber('5');
      calc.onOperation('÷');
      calc.onNumber('0');
      calc.onEquals();
      expect(calc.display, 'Error');
    });

    // Test 5: Clear (C)
    test('Clear resets to 0', () {
      calc.onNumber('9');
      calc.onNumber('9');
      calc.onClear();
      expect(calc.display, '0');
      expect(calc.operation, '');
      expect(calc.equation, '');
    });

    // Test 6: CE removes last digit
    test('CE removes last digit', () {
      calc.onNumber('1');
      calc.onNumber('2');
      calc.onNumber('3');
      calc.onClearEnd();
      expect(calc.display, '12');
    });

    // Test 7: Chain operations 5 + 3 × 2
    test('Chain: 5 + 3 then × 2 = 16', () {
      calc.onNumber('5');
      calc.onOperation('+');
      calc.onNumber('3');
      calc.onOperation('×');
      calc.onNumber('2');
      calc.onEquals();
      expect(calc.display, '16');
    });

    // Test 8: Percentage
    test('50% = 0.5', () {
      calc.onNumber('5');
      calc.onNumber('0');
      calc.onPercentage();
      expect(calc.display, '0.5');
    });

    // Test 9: Multiple decimal points prevented
    test('Multiple decimal points are ignored', () {
      calc.onNumber('3');
      calc.onDecimal();
      calc.onDecimal(); // Should be ignored
      calc.onNumber('5');
      expect(calc.display, '3.5');
    });

    // Test 10: Subtraction
    test('10 - 4 = 6', () {
      calc.onNumber('1');
      calc.onNumber('0');
      calc.onOperation('-');
      calc.onNumber('4');
      calc.onEquals();
      expect(calc.display, '6');
    });
  });
}
