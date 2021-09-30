import 'package:calc/calc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Define a test. The TestWidgets function also provides a WidgetTester
  // to work with. The WidgetTester allows you to build and interact
  // with widgets in the test environment.
  testWidgets('test addition', (WidgetTester tester) async {
    await tester.pumpWidget(
        const MaterialApp(title: 'Flutter Demo', home: CalcDialog()));

    // Create the Finders.
    final button1 = find.byKey(const Key('1'));
    final button2 = find.byKey(const Key('2'));
    final button3 = find.byKey(const Key('3'));
    final button4 = find.byKey(const Key('4'));

    final buttonPlus = find.byKey(const Key('+'));

    final fieldResult = find.byKey(const Key('result'));

    expect(button1, findsOneWidget);
    expect(button2, findsOneWidget);
    expect(fieldResult, findsOneWidget);

    await tester.tap(button1);
    await tester.tap(button1);
    await tester.tap(buttonPlus);
    await tester.tap(button2);
    await tester.tap(button2);
    await tester.tap(buttonPlus);
    await tester.pump();

    String value = tester.widget<Text>(fieldResult).data!;
    expect(value, "33");
  });

  testWidgets('test substraction', (WidgetTester tester) async {
    await tester.pumpWidget(
        const MaterialApp(title: 'Flutter Demo', home: CalcDialog()));

    // Create the Finders.
    final button1 = find.byKey(const Key('1'));
    final button2 = find.byKey(const Key('2'));
    final button3 = find.byKey(const Key('3'));
    final button4 = find.byKey(const Key('4'));

    final buttonPlus = find.byKey(const Key('+'));
    final buttonMinus = find.byKey(const Key('-'));

    final fieldResult = find.byKey(const Key('result'));

    expect(button1, findsOneWidget);
    expect(button2, findsOneWidget);
    expect(button3, findsOneWidget);
    expect(fieldResult, findsOneWidget);

    await tester.tap(button3);
    await tester.tap(button3);
    await tester.tap(buttonMinus);
    await tester.tap(button2);
    await tester.tap(button2);
    await tester.tap(buttonMinus);
    await tester.pump();

    String value = tester.widget<Text>(fieldResult).data!;
    expect(value, "11");
  });

  testWidgets('test multiplication', (WidgetTester tester) async {
    await tester.pumpWidget(
        const MaterialApp(title: 'Flutter Demo', home: CalcDialog()));

    // Create the Finders.
    final button1 = find.byKey(const Key('1'));
    final button2 = find.byKey(const Key('2'));
    final button3 = find.byKey(const Key('3'));
    final button4 = find.byKey(const Key('4'));

    final buttonPlus = find.byKey(const Key('+'));
    final buttonMinus = find.byKey(const Key('-'));
    final buttonMultiply = find.byKey(const Key('X'));

    final fieldResult = find.byKey(const Key('result'));

    expect(button1, findsOneWidget);
    expect(button2, findsOneWidget);
    expect(button3, findsOneWidget);
    expect(fieldResult, findsOneWidget);

    await tester.tap(button3);
    await tester.tap(button3);
    await tester.tap(buttonMultiply);
    await tester.tap(button2);
    await tester.tap(button2);
    await tester.tap(buttonMultiply);
    await tester.pump();

    String value = tester.widget<Text>(fieldResult).data!;
    expect(value, "726");
  });

  testWidgets('test division', (WidgetTester tester) async {
    await tester.pumpWidget(
        const MaterialApp(title: 'Flutter Demo', home: CalcDialog()));

    // Create the Finders.
    final button1 = find.byKey(const Key('1'));
    final button2 = find.byKey(const Key('2'));
    final button3 = find.byKey(const Key('3'));
    final button4 = find.byKey(const Key('4'));

    final buttonPlus = find.byKey(const Key('+'));
    final buttonMinus = find.byKey(const Key('-'));
    final buttonMultiply = find.byKey(const Key('X'));
    final buttonDivide = find.byKey(const Key('/'));

    final fieldResult = find.byKey(const Key('result'));

    expect(button1, findsOneWidget);
    expect(button2, findsOneWidget);
    expect(button3, findsOneWidget);
    expect(fieldResult, findsOneWidget);

    await tester.tap(button3);
    await tester.tap(button3);
    await tester.tap(buttonDivide);
    await tester.tap(button2);
    await tester.tap(button2);
    await tester.tap(buttonDivide);
    await tester.pump();

    String value = tester.widget<Text>(fieldResult).data!;
    expect(value, "1.5");
  });
}
