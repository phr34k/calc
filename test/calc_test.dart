import 'package:flutter_test/flutter_test.dart';
import 'package:calc/calc.dart';

void main() {
  test('adds one to input values', () {
    final calculator = Calculator();
    calculator.current = 5;
    calculator.perform();
    calculator.flush();
    calculator.operation = "+";
    calculator.current = 5;
    calculator.perform();
    expect(calculator.result, 10);
  });

  test('multiply two input values', () {
    final calculator = Calculator();
    calculator.current = 5;
    calculator.perform();
    calculator.flush();
    calculator.operation = "*";
    calculator.current = 5;
    calculator.perform();
    expect(calculator.result, 25);
  });

  test('divide two input values', () {
    final calculator = Calculator();
    calculator.current = 0.4;
    calculator.perform();
    calculator.flush();
    calculator.operation = "/";
    calculator.current = 0.2;
    calculator.perform();
    expect(calculator.result, 2);
  });
}
