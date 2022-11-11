import 'package:calc/shared.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Internal set - consequative', () {
    final counter = CalculatorInternal();
    counter.perform(CalculatorInput.d3);
    counter.perform(CalculatorInput.d3);
    counter.perform(CalculatorInput.equals);
    counter.perform(CalculatorInput.d6);
    counter.perform(CalculatorInput.d6);
    counter.perform(CalculatorInput.equals);
    expect(counter.result, 66.0);
    expect(counter.formula, "66 =");
  });

  test('Internal set', () {
    final counter = CalculatorInternal();
    counter.perform(CalculatorInput.d3);
    counter.perform(CalculatorInput.d3);
    counter.perform(CalculatorInput.equals);
    expect(counter.result, 33.0);
    expect(counter.formula, "33 =");
  });

  test('Internal multiply', () {
    final counter = CalculatorInternal();
    counter.perform(CalculatorInput.d3);
    counter.perform(CalculatorInput.multiply);
    counter.perform(CalculatorInput.d3);
    counter.perform(CalculatorInput.equals);
    expect(counter.result, 9.0);
    expect(counter.formula, "3 x 3 =");
  });

  test('Internal add', () {
    final counter = CalculatorInternal();
    counter.perform(CalculatorInput.d3);
    counter.perform(CalculatorInput.addition);
    counter.perform(CalculatorInput.d3);
    counter.perform(CalculatorInput.equals);
    expect(counter.result, 6.0);
    expect(counter.formula, "3 + 3 =");
  });

  test('Internal divide', () {
    final counter = CalculatorInternal();
    counter.perform(CalculatorInput.d3);
    counter.perform(CalculatorInput.division);
    counter.perform(CalculatorInput.d3);
    counter.perform(CalculatorInput.equals);
    expect(counter.result, 1.0);
    expect(counter.formula, "3 ÷ 3 =");
  });

  test('Internal subtract', () {
    final counter = CalculatorInternal();
    counter.perform(CalculatorInput.d3);
    counter.perform(CalculatorInput.subtraction);
    counter.perform(CalculatorInput.d3);
    counter.perform(CalculatorInput.equals);
    expect(counter.result, 0.0);
    expect(counter.formula, "3 - 3 =");
  });

  test('Internal redo operand', () {
    final counter = CalculatorInternal();
    counter.perform(CalculatorInput.d8);
    counter.perform(CalculatorInput.multiply);
    counter.perform(CalculatorInput.subtraction);
    counter.perform(CalculatorInput.d3);
    counter.perform(CalculatorInput.equals);
    expect(counter.result, 5.0);
    expect(counter.formula, "8 - 3 =");
  });

  test('Multiple operand multiply', () {
    final counter = CalculatorInternal();
    counter.perform(CalculatorInput.d8);
    counter.perform(CalculatorInput.multiply);
    counter.perform(CalculatorInput.d3);
    counter.perform(CalculatorInput.multiply);
    counter.perform(CalculatorInput.d5);
    counter.perform(CalculatorInput.equals);
    expect(counter.result, 8.0 * 3.0 * 5.0);
    expect(counter.formula, "24 x 5 =");
  });

  test('Multiple operand addition', () {
    final counter = CalculatorInternal();
    counter.perform(CalculatorInput.d8);
    counter.perform(CalculatorInput.addition);
    counter.perform(CalculatorInput.d3);
    counter.perform(CalculatorInput.addition);
    counter.perform(CalculatorInput.d5);
    counter.perform(CalculatorInput.equals);
    expect(counter.result, 8.0 + 3.0 + 5.0);
    expect(counter.formula, "11 + 5 =");
  });

  test('Complex', () {
    final counter = CalculatorInternal();
    counter.perform(CalculatorInput.d2);
    counter.perform(CalculatorInput.d5);
    counter.perform(CalculatorInput.addition);
    counter.perform(CalculatorInput.d3);
    counter.perform(CalculatorInput.d6);
    counter.perform(CalculatorInput.addition);
    counter.perform(CalculatorInput.d1);
    counter.perform(CalculatorInput.d4);
    counter.perform(CalculatorInput.equals);
    counter.perform(CalculatorInput.equals);
    expect(counter.result, 25 + 36 + 14 + 14);
    expect(counter.formula, "75 + 14 =");
  });

  test('Complex division by zero', () {
    final counter = CalculatorInternal();
    counter.perform(CalculatorInput.d9);
    counter.perform(CalculatorInput.division);
    counter.perform(CalculatorInput.d0);
    counter.perform(CalculatorInput.multiply);
    expect(counter.result, double.infinity);

    counter.perform(CalculatorInput.d5);
    expect(counter.result, 0.0);
    expect(counter.formula, "");
    counter.perform(CalculatorInput.multiply);
    counter.perform(CalculatorInput.d5);
    counter.perform(CalculatorInput.equals);

    expect(counter.result, 25.0);
    expect(counter.formula, "5 x 5 =");
  });

  test('Multiple operand subtraction', () {
    final counter = CalculatorInternal();
    counter.perform(CalculatorInput.d8);
    counter.perform(CalculatorInput.subtraction);
    counter.perform(CalculatorInput.d3);
    counter.perform(CalculatorInput.subtraction);
    counter.perform(CalculatorInput.d5);
    counter.perform(CalculatorInput.equals);
    expect(counter.result, 8.0 - 3.0 - 5.0);
    expect(counter.formula, "5 - 5 =");
  });

  test('Negative number support', () {
    final counter = CalculatorInternal();
    counter.perform(CalculatorInput.subtraction);
    counter.perform(CalculatorInput.d5);
    counter.perform(CalculatorInput.equals);
    expect(counter.formula, "0 - 5 =");
    expect(counter.result, -5.0);
  });

  test('Implicit value expression', () {
    final counter = CalculatorInternal();
    counter.perform(CalculatorInput.d3);
    counter.perform(CalculatorInput.multiply);
    counter.perform(CalculatorInput.equals);
    expect(counter.formula, "3 x 3 =");
    expect(counter.result, 9.0);
  });

  test('input dot', () {
    final counter = CalculatorInternal();
    counter.perform(CalculatorInput.d9);
    counter.perform(CalculatorInput.dot);
    counter.perform(CalculatorInput.d0);
    counter.perform(CalculatorInput.d0);
    counter.perform(CalculatorInput.dot);
    expect(counter.d0, "9.00");
    expect(counter.result, 0.0);
  });

  test('Special button ce', () {
    final counter = CalculatorInternal();
    counter.perform(CalculatorInput.d9);
    counter.perform(CalculatorInput.multiply);
    counter.perform(CalculatorInput.d3);
    counter.perform(CalculatorInput.ce);
    expect(counter.formula, "9 x");
    expect(counter.result, 0.0);
    counter.perform(CalculatorInput.equals);
    expect(counter.formula, "9 x 0 =");
    expect(counter.result, 0.0);
  });

  test('Special button c', () {
    final counter = CalculatorInternal();
    counter.perform(CalculatorInput.d8);
    counter.perform(CalculatorInput.subtraction);
    counter.perform(CalculatorInput.d3);
    counter.perform(CalculatorInput.equals);
    counter.perform(CalculatorInput.c);
    expect(counter.formula, "");
    expect(counter.result, 0.0);
  });
}
