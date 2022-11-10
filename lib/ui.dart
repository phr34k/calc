library calc;

import 'dart:async';
import './shared.dart';
import 'package:flutter/material.dart';

@immutable
class CalcDialog2 extends StatefulWidget with CalculatorMixin {
  final bool cancel;
  @override
  final String title;
  const CalcDialog2({Key? key, this.cancel = false, this.title = "Calculator"})
      : super(key: key);
  @override
  CalcDialog2State createState() => CalcDialog2State();
}

class CalcDialog2State extends State<CalcDialog2> with CalculatorStateMixin {
  CalculatorInternal calculator = CalculatorInternal();

  @override
  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        calculator.perform(CalculatorInput.c);
      } else if (buttonText == "CE") {
        calculator.perform(CalculatorInput.ce);
      } else if (buttonText == "BSPC") {
        calculator.perform(CalculatorInput.back);
      } else if (buttonText == "+") {
        calculator.perform(CalculatorInput.addition);
      } else if (buttonText == "-") {
        calculator.perform(CalculatorInput.subtraction);
      } else if (buttonText == "/") {
        calculator.perform(CalculatorInput.division);
      } else if (buttonText == "*" || buttonText == "X" || buttonText == "x") {
        calculator.perform(CalculatorInput.multiply);
      } else if (buttonText == "=") {
        calculator.perform(CalculatorInput.equals);
      } else {
        calculator.perform(CalculatorInput
            .values[CalculatorInput.d0.index + int.parse(buttonText)]);
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
      return CalcDialog2(cancel: cancel);
    },
  );
}
