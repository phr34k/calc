library calc;

import 'dart:async';
import './shared.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@immutable
class CalcDialog extends StatefulWidget with CalculatorMixin {
  final bool cancel;
  @override
  final String title;
  const CalcDialog({Key? key, this.cancel = false, this.title = "Calculator"})
      : super(key: key);
  @override
  CalcDialogState createState() => CalcDialogState();
}

class CalcDialogState extends State<CalcDialog> with CalculatorStateMixin {
  Calculator calculator = Calculator();

  @override
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

  @override
  Widget build(BuildContext context) {
    return buildCalculator();
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
