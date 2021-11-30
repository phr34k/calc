library calc;

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:math_expressions/math_expressions.dart';

// TODO: Add unit tests for the test project
class Calculator {
  String _number = "";
  String _builder = "";
  double _previous = 0;
  double current = 0;
  String operation = "";
  bool _set = false;
  bool _tag = false;

  void Function(String text1, String text2)? updateDisplay;

  /*
  void setOperator(String op) {
    if (op == "=") {
      if (operation != "") {
        perform();
      } else {
        flush();
      }
    } else {
      if (previous != null && current != null) {
        operation = op;
        perform();
        flush();
        current = null;
      } else {
        // ignore: prefer_conditional_assignment
        if (current == null) {
          current = 0;
        }

        if (current != null) {
          _previous = current!;
          operation = op;
          _equation = "$_previous $operation";
        } else {
          operation = op;
          _equation = "$_previous $operation";
        }
      }
    }
  }


  void perform() {
    if (operation == "+") {
      if (_previous != null) {
        _result = previous! + current!;
        _equation = "$_previous $operation $current = ";
      } else {
        _previous = current;
        _equation = "$_previous $operation";
      }
    } else if (operation == "-") {
      if (_previous != null) {
        _result = previous! - current!;
        _equation = "$_previous $operation $current = ";
      } else {
        _previous = current;
        _equation = "$_previous $operation";
      }
    } else if (operation == "*") {
      if (_previous != null) {
        _result = previous! * current!;
        _equation = "$_previous $operation $current = ";
      } else {
        _previous = current;
        _equation = "$_previous $operation";
      }
    } else if (operation == "/") {
      if (_previous != null) {
        _result = previous! / current!;
        _equation = "$_previous $operation $current = ";
      } else {
        _previous = current;
        _equation = "$_previous $operation";
      }
    } else if (operation == "") {
      _result = current;
    } else {
      throw Exception("Not implemented");
    }
  }

  void c() {
    _reset();
  }

  void ce() {
    _reset();
  }

  void _reset() {
    _previous = 0;
    current = 0;
    _result = null;
    operation = "";
    _equation = "";
  }

  void flush() {
    if (_result != null) {
      _previous = _result!;
    }
  }
  */

  String _toNumber(double v) {
    bool isFractional = (v - v.floor().toDouble()) != 0.0;
    return isFractional ? v.toString() : v.toInt().toString();
  }

  void c() {
    current = 0;
    _previous = 0;
    operation = '=';
    _builder = "";
    _number = "0";
    _tag = true;
    updateDisplay?.call(_builder, _number);
  }

  void ce() {
    _builder = "";
    current = 0;
    _set = false;
    updateDisplay?.call(_builder, _number);
  }

  void backspace() {
    _number =
        _number.isNotEmpty ? _number.substring(0, _number.length - 1) : "";
    current =
        double.tryParse(_number) ?? int.tryParse(_number)?.toDouble() ?? 0;
    _set = true;
    updateDisplay?.call(_builder, _number);
  }

  void perform(bool wasEquals) {
    if (wasEquals || !wasEquals && _set == true) {
      _previous = performOperand(operation, _previous!, current!);
      _tag = true;
      _number = _previous.toString();
      updateDisplay?.call(_builder, _number);
    }
  }

  void appendNumber(String number) {
    if ("+-/*=".contains(number)) {
      if (number == "=") {
        perform(true);
        upateStack(operation, operation, _set, _previous!, current!);
        _set = false;
      } else {
        perform(false);
        operation = number;
        upateStack(operation, operation, _set, _previous!, current!);
        _set = false;
      }
    } else {
      if (number == ".") {
        _number = _tag == true ? "" : _number;
        _number =
            (number == "." && _number.isEmpty ? "0" : "") + _number + number;
        current =
            double.tryParse(_number) ?? int.tryParse(_number)?.toDouble() ?? 0;
        _set = true;
        _tag = false;
        updateDisplay?.call(_builder, _number);
      } else {
        _number = _tag == true ? "" : _number;
        _number =
            (number == "." && _number.isEmpty ? "0" : "") + _number + number;
        current =
            double.tryParse(_number) ?? int.tryParse(_number)?.toDouble() ?? 0;
        _set = true;
        _tag = false;
        updateDisplay?.call(_builder, _number);
      }
    }
  }

  void upateStack(String operation, String last, bool set, double previous,
      double current) {
    if (operation == '+' ||
        operation == '-' ||
        operation == '*' ||
        operation == '/') {
      if (set) {
        _builder += _toNumber(current);
        _builder += " ";
        _builder += operation;
        _builder += " ";
      } else {
        _builder = _builder.substring(0, _builder.length - 3);
        _builder += " ";
        _builder += operation;
        _builder += " ";
      }

      //label1.Text = builder.ToString();
      //label2.Tag = this;
      //label2.Text = previous.ToString();
      _tag = true;
      _number = _toNumber(previous);
      updateDisplay?.call(_builder, _number);
    } else if (operation == '=') {
      if (last != '=') {
        _builder = "";
        _builder += _toNumber(previous);
        _builder += " ";
        _builder += last;
        _builder += " ";
        _builder += _toNumber(current);
        _builder += " ";
        _builder += "=";
        _builder += " ";
      } else {
        _builder = "";
        _builder += _toNumber(previous);
        _builder += " ";
        _builder += last;
        _builder += " ";
      }

      //label2.Tag = this;

      _tag = true;
      _number = _toNumber(previous);
      updateDisplay?.call(_builder, _number);
    }
  }

  double performOperand(String operation, double a, double b) {
    if (operation == '+') {
      return a + b;
    } else if (operation == '-') {
      return a - b;
    } else if (operation == '*') {
      return a * b;
    } else if (operation == '/') {
      try {
        return a / b;
      } catch (ex) {
        return 0;
      }
    } else {
      return b;
    }
  }
}

@immutable
class CalcDialog extends StatefulWidget {
  final int requiredLevel;
  final bool cancel;
  final String title;
  final String body;
  final String progress;
  const CalcDialog(
      {Key? key,
      this.requiredLevel = 0,
      this.cancel = false,
      this.title = "Calculator",
      this.body = "Enter credentionals in order to unlock the workstation.",
      this.progress = "Please wait while we unlock the workstation"})
      : super(key: key);
  @override
  CalcDialogState createState() => CalcDialogState();
}

// TODO: This is a quick port of old c# code that needs get bug fixed. In specific this code implements a dart/flutter based calculated based on calc.exe.
class CalcDialogState extends State<CalcDialog> {
  String v1 = "";
  String v2 = "";
  Calculator calculator = Calculator();
  double equationFontSize = 28.0;
  double resultFontSize = 38.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        calculator.c();
      } else if (buttonText == "CE") {
        calculator.ce();
      } else if (buttonText == "BSPC") {
        calculator.backspace();
      } else if (buttonText == "+") {
        calculator.appendNumber("+");
      } else if (buttonText == "-") {
        calculator.appendNumber("-");
      } else if (buttonText == "/") {
        calculator.appendNumber("/");
      } else if (buttonText == "*" || buttonText == "X" || buttonText == "x") {
        calculator.appendNumber("*");
      } else if (buttonText == "=") {
        calculator.appendNumber("=");
      } else {
        calculator.appendNumber(buttonText);
      }
    });
  }

  // void doOperation(String val) {
  //   setState(() {
  //     num1 += val;
  //     // ans = int.parse(num1);
  //     ansStr = "$ans";
  //   });
  // }

  // void _disp() {
  //   setState(() {
  //     if (oper == '+') {
  //       ans = double.parse(num1) + double.parse(num2);
  //       flag++;
  //       oper = "";
  //       num1 = "";
  //     } else if (oper == '-') {
  //       ans = double.parse(num2) - double.parse(num1);
  //       flag++;
  //       oper = "";
  //       num1 = "";
  //     } else if (oper == '*') {
  //       ans = double.parse(num2) * double.parse(num1);
  //       flag++;
  //       oper = "";
  //       num1 = "";
  //     } else if (oper == '/') {
  //       ans = (double.parse(num2) / double.parse(num1));
  //       // int a = double.parse(num2) ~/ double.parse(num1);
  //       // ans = double.parse(a.toString());
  //       flag++;
  //       oper = "";
  //       num1 = "";
  //     }
  //     ansStr = "$ans";
  //   });
  // }

  var digit0 = FocusNode(onKey: test2);
  var digit1 = FocusNode(onKey: test2);
  var digit2 = FocusNode(onKey: test2);
  var digit3 = FocusNode(onKey: test2);
  var digit4 = FocusNode(onKey: test2);
  var digit5 = FocusNode(onKey: test2);
  var digit6 = FocusNode(onKey: test2);
  var digit7 = FocusNode(onKey: test2);
  var digit8 = FocusNode(onKey: test2);
  var digit9 = FocusNode(onKey: test2);
  var digitDot = FocusNode(onKey: test2);
  var digitBackspace = FocusNode(onKey: test2);
  var digitCE = FocusNode(onKey: test2);
  var digitC = FocusNode(onKey: test2);
  var digitMultiply = FocusNode(onKey: test2);
  var digitDivide = FocusNode(onKey: test2);
  var digitSubtract = FocusNode(onKey: test2);
  var digitAddition = FocusNode(onKey: test2);
  var digitEquals = FocusNode(onKey: test2);

  var builder = "";
  var username = TextEditingController();
  var pincode = TextEditingController();
  var checking = Future.value(false);

  @override
  void initState() {
    calculator.updateDisplay = (v1, v2) {
      setState(() {
        this.v1 = v1;
        this.v2 = v2;
      });
    };
    super.initState();
  }

  void ok() {
    Navigator.of(context).pop(true);
  }

  Widget buildEmpty({
    double width = 70,
    double height = 56,
  }) {
    return Padding(
        padding: const EdgeInsets.all(2.5),
        child: SizedBox(
          width: width,
          height: height,
        ));
  }

  Widget buildButton(String? text,
      {FocusNode? focusNode,
      double width = 70,
      double height = 56,
      Function()? f}) {
    return Padding(
        padding: const EdgeInsets.all(2.5),
        child: OutlinedButton(
          key: Key(text!),
          focusNode: focusNode,
          style: OutlinedButton.styleFrom(fixedSize: Size(width, height)),
          child: Align(
              alignment: Alignment.center,
              child: Text(
                text ?? "",
                textAlign: TextAlign.center,
              )),
          onPressed: f,
        ));
  }

  Widget buildProgress() {
    return AlertDialog(
        title: Text(widget.title),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(
            widget.progress,
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 20, width: 400),
          const CircularProgressIndicator(),
        ]));
  }

  Widget buildLoginState() {
    return AlertDialog(
      title: Row(
        children: [Expanded(child: Text(widget.title)), const CloseButton()],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
              width: 290,
              child: SingleChildScrollView(
                  reverse: true,
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    v1,
                    key: const Key("equation"),
                    style: TextStyle(
                        color: Colors.blueGrey, fontSize: equationFontSize),
                  ))),
          SizedBox(
              width: 290,
              child: SingleChildScrollView(
                  reverse: true,
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    v2,
                    key: const Key("result"),
                    style: TextStyle(fontSize: resultFontSize),
                  ))),
          const SizedBox(height: 20, width: 400),
          Focus(
              onKey: test,
              autofocus: true,
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        buildButton("BSPC",
                            focusNode: digitBackspace,
                            f: () => buttonPressed("BSPC")),
                        buildButton("CE",
                            focusNode: digitCE, f: () => buttonPressed("CE")),
                        buildButton("C",
                            focusNode: digitC, f: () => buttonPressed("C")),
                        buildButton("/",
                            focusNode: digitDivide,
                            f: () => buttonPressed("/")),
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        buildButton("1",
                            focusNode: digit1, f: () => buttonPressed("1")),
                        buildButton("2",
                            focusNode: digit2, f: () => buttonPressed("2")),
                        buildButton("3",
                            focusNode: digit3, f: () => buttonPressed("3")),
                        buildButton("X",
                            focusNode: digitMultiply,
                            f: () => buttonPressed("*")),
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        buildButton("4",
                            focusNode: digit4, f: () => buttonPressed("4")),
                        buildButton("5",
                            focusNode: digit5, f: () => buttonPressed("5")),
                        buildButton("6",
                            focusNode: digit6, f: () => buttonPressed("6")),
                        buildButton("-",
                            focusNode: digitSubtract,
                            f: () => buttonPressed("-")),
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        buildButton("7",
                            focusNode: digit7, f: () => buttonPressed("7")),
                        buildButton("8",
                            focusNode: digit8, f: () => buttonPressed("8")),
                        buildButton("9",
                            focusNode: digit9, f: () => buttonPressed("9")),
                        buildButton("+",
                            focusNode: digitAddition,
                            f: () => buttonPressed("+")),
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        buildEmpty(),
                        buildButton("0",
                            focusNode: digit0, f: () => buttonPressed("0")),
                        buildButton(".",
                            focusNode: digitDot, f: () => buttonPressed(".")),
                        buildButton("=",
                            focusNode: digitEquals,
                            f: () => buttonPressed("=")),
                      ]),
                ],
              )),
        ],
      ),
      actions: const [],
    );
  }

  static KeyEventResult test2(FocusNode node, RawKeyEvent event) {
    if (event.isKeyPressed(LogicalKeyboardKey.backspace)) {
      return KeyEventResult.handled;
    } else if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
      return KeyEventResult.handled;
    } else if (event.isKeyPressed(LogicalKeyboardKey.numpadEnter)) {
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  KeyEventResult test(FocusNode node, RawKeyEvent event) {
    var v = testInner(node, event);
    if (v == KeyEventResult.skipRemainingHandlers) {
      var x = FocusScope.of(context)
          .focusedChild
          ?.context
          ?.findAncestorWidgetOfExactType<OutlinedButton>();
      if (x != null) x.onPressed!();
    }

    return v;
  }

  KeyEventResult testInner(FocusNode node, RawKeyEvent event) {
    if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
      digitEquals.requestFocus();
      return KeyEventResult.skipRemainingHandlers;
    } else if (event.isKeyPressed(LogicalKeyboardKey.numpadEnter)) {
      digitEquals.requestFocus();
      return KeyEventResult.skipRemainingHandlers;
    } else if (event.isKeyPressed(LogicalKeyboardKey.backspace)) {
      digitBackspace.requestFocus();
      return KeyEventResult.skipRemainingHandlers;
    } else if (event.isKeyPressed(LogicalKeyboardKey.numpadAdd)) {
      digitAddition.requestFocus();
      return KeyEventResult.skipRemainingHandlers;
    } else if (event.isKeyPressed(LogicalKeyboardKey.numpadSubtract)) {
      digitSubtract.requestFocus();
      return KeyEventResult.skipRemainingHandlers;
    } else if (event.isKeyPressed(LogicalKeyboardKey.numpadMultiply)) {
      digitMultiply.requestFocus();
      return KeyEventResult.skipRemainingHandlers;
    } else if (event.isKeyPressed(LogicalKeyboardKey.numpadDivide)) {
      digitDivide.requestFocus();
      return KeyEventResult.skipRemainingHandlers;
    } else if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
      return KeyEventResult.skipRemainingHandlers;
    } else if (event.isKeyPressed(LogicalKeyboardKey.numpad0)) {
      digit0.requestFocus();
      return KeyEventResult.skipRemainingHandlers;
    } else if (event.isKeyPressed(LogicalKeyboardKey.numpad1)) {
      digit1.requestFocus();
      return KeyEventResult.skipRemainingHandlers;
    } else if (event.isKeyPressed(LogicalKeyboardKey.numpad2)) {
      digit2.requestFocus();
      return KeyEventResult.skipRemainingHandlers;
    } else if (event.isKeyPressed(LogicalKeyboardKey.numpad3)) {
      digit3.requestFocus();
      return KeyEventResult.skipRemainingHandlers;
    } else if (event.isKeyPressed(LogicalKeyboardKey.numpad4)) {
      digit4.requestFocus();
      return KeyEventResult.skipRemainingHandlers;
    } else if (event.isKeyPressed(LogicalKeyboardKey.numpad5)) {
      digit5.requestFocus();
      return KeyEventResult.skipRemainingHandlers;
    } else if (event.isKeyPressed(LogicalKeyboardKey.numpad6)) {
      digit6.requestFocus();
      return KeyEventResult.skipRemainingHandlers;
    } else if (event.isKeyPressed(LogicalKeyboardKey.numpad7)) {
      digit7.requestFocus();
      return KeyEventResult.skipRemainingHandlers;
    } else if (event.isKeyPressed(LogicalKeyboardKey.numpad8)) {
      digit8.requestFocus();
      return KeyEventResult.skipRemainingHandlers;
    } else if (event.isKeyPressed(LogicalKeyboardKey.numpad9)) {
      digit9.requestFocus();
      return KeyEventResult.skipRemainingHandlers;
    }

    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    return buildLoginState();
    // show the dialog
  }
}

Future<T?> showCalculator<T extends Object>(BuildContext context, bool cancel) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return CalcDialog(cancel: cancel);
    },
  );
}
