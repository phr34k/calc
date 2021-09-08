library calc;

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// TODO: Add unit tests for the test project
class Calculator {
  int addOne(int value) => value + 1;
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

  var text = "";
  var text2 = "";
  var current = 0.0;
  var previous = 0.0;
  var set = false;
  var reset = false;
  String? operation;

  void ok() {
    Navigator.of(context).pop(true);
  }

  void set_() {
    if (set == false) {}
  }

  double _performOperand(String? operation, double a, double b) {
    if (operation == '+') {
      return a + b;
    } else if (operation == '-') {
      return a - b;
    } else if (operation == '*') {
      return a * b;
    } else if (operation == '/') {
      try {
        return a / b;
      } catch (e) {
        return 0;
      }
    } else {
      return b;
    }
  }

  void _upateStack(String? operation, String? last, bool set, double previous,
      double current) {
    if (operation == '+' ||
        operation == '-' ||
        operation == '*' ||
        operation == '/') {
      if (set) {
        builder = "$builder $current $operation ";
      } else {
        builder = builder.substring(0, builder.length - 3);
        builder = "$builder $operation ";
      }

      text2 = builder;
      text = previous.toString();
      reset = true;
    } else if (operation == '=') {
      if (last != '=') {
        builder = "$previous $last $current = ";
      } else {
        builder = "$previous $last ";
      }

      text2 = builder;
      text = previous.toString();
      reset = true;
    }
  }

  void setOperation(String? op) {
    /*
    if (set == false) {
      print("needs to perform set");
    } else {
      var current_ = double.parse(text);
      operation = op;

      if (op == "+") {
        current_ = previous + current_;
      }

      //UpateStack(operation, operation, set, previous, current);
      set = false;
      previous = current_;
      current = 0;
      text = current.toInt().toString();
    }
    */

    operation = op;
    previous = _performOperand(operation, previous, current);
    text = previous.toInt().toString();
    _upateStack(operation, operation, set, previous, current);
    set = false;
    setState(() {});
  }

  Widget buildButton(String? text,
      {FocusNode? focusNode, double width = 40, double height = 56}) {
    return Padding(
        padding: const EdgeInsets.all(2.5),
        child: OutlinedButton(
          focusNode: focusNode,
          child: SizedBox(
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    text ?? "",
                    textAlign: TextAlign.center,
                  )),
              width: width,
              height: height),
          onPressed: () {
            if (text == "BSPC") {
              if (this.text.isNotEmpty) {
                this.text = this.text.substring(0, this.text.length - 1);
              }
              if (this.text.isNotEmpty) {
                current = double.parse(this.text);
              } else {
                current = 0;
              }
              setState(() {});
            } else if (text == "C") {
              reset = false;
              current = 0;
              previous = 0;
              operation = '=';
              text2 = "";
              text = "0";
              builder = "";
              setState(() {});
            } else if (text == "CE") {
              text = "0";
              current = 0;
              set = false;
              setState(() {});
            } else if (text == "+" ||
                text == "-" ||
                text == "/" ||
                text == "X" ||
                text == "=") {
              setOperation(text?.replaceAll("X", "*") ?? "");
            } else {
              this.text = reset ? "0$text" : "${this.text}$text";
              this.text = double.parse(this.text).toInt().toString();
              current = double.parse(this.text);
              set = true;
              reset = false;
              setState(() {});
            }
          },
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
          Text(
            text2,
            style: const TextStyle(color: Colors.blueGrey),
          ),
          Text(
            text,
            style: const TextStyle(fontSize: 22),
          ),
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
                        buildButton("BSPC", focusNode: digitBackspace),
                        buildButton("CE", focusNode: digitCE),
                        buildButton("C", focusNode: digitC),
                        buildButton("/", focusNode: digitDivide),
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        buildButton("1", focusNode: digit1),
                        buildButton("2", focusNode: digit2),
                        buildButton("3", focusNode: digit3),
                        buildButton("X", focusNode: digitMultiply),
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        buildButton("4", focusNode: digit4),
                        buildButton("5", focusNode: digit5),
                        buildButton("6", focusNode: digit6),
                        buildButton("-", focusNode: digitSubtract),
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        buildButton("7", focusNode: digit7),
                        buildButton("8", focusNode: digit8),
                        buildButton("9", focusNode: digit9),
                        buildButton("+", focusNode: digitAddition),
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SizedBox(
                          width: 76,
                          height: 45,
                        ),
                        buildButton("0", focusNode: digit0),
                        buildButton(".", focusNode: digitDot),
                        buildButton("=", focusNode: digitEquals),
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
