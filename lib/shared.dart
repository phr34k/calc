library calc;

//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum CalculatorInput {
  equals,
  subtraction,
  addition,
  multiply,
  division,
  back,
  ce,
  c,
  d0,
  d1,
  d2,
  d3,
  d4,
  d5,
  d6,
  d7,
  d8,
  d9,
  dot,
}

class CalculatorNumberRange extends TextRange {
  const CalculatorNumberRange({required int start, required int end})
      : super(start: start, end: end);
}

class CalculatorOperandRange extends TextRange {
  const CalculatorOperandRange({required int start, required int end})
      : super(start: start, end: end);
}

class CalculatorEqualsRange extends TextRange {
  const CalculatorEqualsRange({required int start, required int end})
      : super(start: start, end: end);
}

class CalculatorInternal {
  List<TextRange> ranges = [const CalculatorNumberRange(start: 0, end: 0)];
  String number = "";
  double? _result;

  void _flush() {
    ranges.clear();
    number = (_result ?? 0).toString();
    ranges.add(CalculatorNumberRange(start: 0, end: number.length - 1));
  }

  void _equals({bool flush = true}) {
    switch (ranges.length) {
      case 1:
        _result = _substringToDouble(ranges[0]);
        if (flush == true) _flush();
        break;
      case 2:
        _result = _substringToDouble(ranges[0]);
        if (flush == true) _flush();
        break;
      case 3:
        switch (_substring(ranges[1])) {
          case "x":
            _result = (_substringToDouble(ranges[0]) ?? 0) *
                (_substringToDouble(ranges[2]) ?? 0);
            if (flush == true) _flush();
            break;
          case "/":
            _result = (_substringToDouble(ranges[0]) ?? 0) /
                (_substringToDouble(ranges[2]) ?? 0);
            if (flush == true) _flush();
            break;
          case "-":
            _result = (_substringToDouble(ranges[0]) ?? 0) -
                (_substringToDouble(ranges[2]) ?? 0);
            if (flush == true) _flush();
            break;
          case "+":
            _result = (_substringToDouble(ranges[0]) ?? 0) +
                (_substringToDouble(ranges[2]) ?? 0);
            if (flush == true) _flush();
            break;
        }
        break;
    }
  }

  void perform(CalculatorInput e) {
    var g = [
      '=',
      '-',
      '+',
      'x',
      '/',
      null,
      null,
      null,
      '0',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '.',
    ];

    switch (e) {
      case CalculatorInput.c:
      case CalculatorInput.ce:
        _result = null;
        number = "";
        ranges.replaceRange(
            0, ranges.length, [const CalculatorNumberRange(start: 0, end: 0)]);
        break;

      case CalculatorInput.equals:
        if (ranges.last is! CalculatorEqualsRange) {
          number = "$number${g[e.index]}";
          ranges.add(CalculatorEqualsRange(
              start: number.length - 1, end: number.length));
        } else {
          number = number.replaceRange(
              ranges.last.start, ranges.last.end, "${g[e.index]}");
        }
        break;

      // operands handeling
      case CalculatorInput.addition:
      case CalculatorInput.subtraction:
      case CalculatorInput.division:
      case CalculatorInput.multiply:
        if (ranges.length == 3) {
          _equals();
        }

        if (ranges.last is! CalculatorOperandRange) {
          number = "$number${g[e.index]}";
          ranges.add(CalculatorOperandRange(
              start: number.length - 1, end: number.length));
        } else {
          number = number.replaceRange(
              ranges.last.start, ranges.last.end, "${g[e.index]}");
        }
        break;

      // number handeling
      case CalculatorInput.d0:
      case CalculatorInput.d1:
      case CalculatorInput.d2:
      case CalculatorInput.d3:
      case CalculatorInput.d4:
      case CalculatorInput.d5:
      case CalculatorInput.d6:
      case CalculatorInput.d7:
      case CalculatorInput.d8:
      case CalculatorInput.d9:
        if (ranges.last is CalculatorEqualsRange) {
          _equals();
        }

        if (ranges.last is! CalculatorNumberRange) {
          number = "$number${g[e.index]}";
          ranges.add(CalculatorNumberRange(
              start: number.length - 1, end: number.length - 1 + 1));
        } else {
          number = "$number${g[e.index]}";
          ranges.last = CalculatorNumberRange(
              start: ranges.last.start, end: ranges.last.end + 1);
        }
        break;
      default:
        break;
    }

    updateDisplay?.call(formula, d0);
  }

  String _substring(TextRange range) {
    return number.substring(range.start, range.end);
  }

  double? _substringToDouble(TextRange range) {
    var z = number.substring(range.start, range.end);
    return z.isNotEmpty ? double.parse(z) : null;
  }

  void Function(String text1, String text2)? updateDisplay;

  String get d0 =>
      result?.toString() ??
      _substring(
          ranges.lastWhere((element) => element is CalculatorNumberRange));
  String get formula => ranges.length > 1
      ? number.substring(0, ranges.length == 3 ? ranges[1].end : ranges[1].end)
      : "";
  double? get result => _result;
}

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
      _previous = performOperand(operation, _previous, current);
      _tag = true;
      _number = _previous.toString();
      updateDisplay?.call(_builder, _number);
    }
  }

  void appendNumber(String number) {
    if ("+-/*=".contains(number)) {
      if (number == "=") {
        perform(true);
        upateStack(operation, operation, _set, _previous, current);
        _set = false;
      } else {
        perform(false);
        operation = number;
        upateStack(operation, operation, _set, _previous, current);
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
        _builder += _builder.isEmpty ? _toNumber(previous) : "";
        _builder = _builder.length > 3
            ? _builder.substring(0, _builder.length - 3)
            : _builder;
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

class CalculatorActivateIntent extends ActivateIntent {
  const CalculatorActivateIntent(this.model);
  final FocusNode model;
}

class CalculatorActivateAction extends Action<CalculatorActivateIntent> {
  CalculatorActivateAction();
  @override
  void invoke(covariant CalculatorActivateIntent intent) {
    Actions.maybeInvoke(intent.model.context!, const ActivateIntent());
  }
}

mixin CalculatorMixin on StatefulWidget {
  String get title;
}

mixin CalculatorStateMixin<T extends CalculatorMixin> on State<T> {
  String v1 = "";
  String v2 = "";
  double equationFontSize = 28.0;
  double resultFontSize = 38.0;

  buttonPressed(String buttonText);

  var digit0 = FocusNode();
  var digit1 = FocusNode();
  var digit2 = FocusNode();
  var digit3 = FocusNode();
  var digit4 = FocusNode();
  var digit5 = FocusNode();
  var digit6 = FocusNode();
  var digit7 = FocusNode();
  var digit8 = FocusNode();
  var digit9 = FocusNode();
  var digitDot = FocusNode();
  var digitBackspace = FocusNode();
  var digitCE = FocusNode();
  var digitC = FocusNode();
  var digitMultiply = FocusNode();
  var digitDivide = FocusNode();
  var digitSubtract = FocusNode();
  var digitAddition = FocusNode();
  var digitEquals = FocusNode();

  Map<ShortcutActivator, Intent> get defaultCalculatorShortcuts {
    return <ShortcutActivator, Intent>{
      const SingleActivator(LogicalKeyboardKey.escape, shift: true):
          const DismissIntent(),
      const SingleActivator(LogicalKeyboardKey.backspace):
          CalculatorActivateIntent(digitBackspace),
      const SingleActivator(LogicalKeyboardKey.delete):
          CalculatorActivateIntent(digitCE),
      const SingleActivator(LogicalKeyboardKey.escape):
          CalculatorActivateIntent(digitC),
      const SingleActivator(LogicalKeyboardKey.digit0):
          CalculatorActivateIntent(digit0),
      const SingleActivator(LogicalKeyboardKey.digit1):
          CalculatorActivateIntent(digit1),
      const SingleActivator(LogicalKeyboardKey.digit2):
          CalculatorActivateIntent(digit2),
      const SingleActivator(LogicalKeyboardKey.digit3):
          CalculatorActivateIntent(digit3),
      const SingleActivator(LogicalKeyboardKey.digit4):
          CalculatorActivateIntent(digit4),
      const SingleActivator(LogicalKeyboardKey.digit5):
          CalculatorActivateIntent(digit5),
      const SingleActivator(LogicalKeyboardKey.digit6):
          CalculatorActivateIntent(digit6),
      const SingleActivator(LogicalKeyboardKey.digit7):
          CalculatorActivateIntent(digit7),
      const SingleActivator(LogicalKeyboardKey.digit8):
          CalculatorActivateIntent(digit8),
      const SingleActivator(LogicalKeyboardKey.digit9):
          CalculatorActivateIntent(digit9),
      const SingleActivator(LogicalKeyboardKey.numpad0):
          CalculatorActivateIntent(digit0),
      const SingleActivator(LogicalKeyboardKey.numpad1):
          CalculatorActivateIntent(digit1),
      const SingleActivator(LogicalKeyboardKey.numpad2):
          CalculatorActivateIntent(digit2),
      const SingleActivator(LogicalKeyboardKey.numpad3):
          CalculatorActivateIntent(digit3),
      const SingleActivator(LogicalKeyboardKey.numpad4):
          CalculatorActivateIntent(digit4),
      const SingleActivator(LogicalKeyboardKey.numpad5):
          CalculatorActivateIntent(digit5),
      const SingleActivator(LogicalKeyboardKey.numpad6):
          CalculatorActivateIntent(digit6),
      const SingleActivator(LogicalKeyboardKey.numpad7):
          CalculatorActivateIntent(digit7),
      const SingleActivator(LogicalKeyboardKey.numpad8):
          CalculatorActivateIntent(digit8),
      const SingleActivator(LogicalKeyboardKey.numpad9):
          CalculatorActivateIntent(digit9),
      const SingleActivator(LogicalKeyboardKey.enter):
          CalculatorActivateIntent(digitEquals),
      const SingleActivator(LogicalKeyboardKey.equal):
          CalculatorActivateIntent(digitEquals),
      const SingleActivator(LogicalKeyboardKey.minus):
          CalculatorActivateIntent(digitSubtract),
      const SingleActivator(LogicalKeyboardKey.add, shift: true):
          CalculatorActivateIntent(digitAddition),
      const SingleActivator(LogicalKeyboardKey.numpadDivide):
          CalculatorActivateIntent(digitDivide),
      const SingleActivator(LogicalKeyboardKey.slash):
          CalculatorActivateIntent(digitDivide),
      const SingleActivator(LogicalKeyboardKey.numpadMultiply):
          CalculatorActivateIntent(digitMultiply),
      const SingleActivator(LogicalKeyboardKey.asterisk, shift: true):
          CalculatorActivateIntent(digitMultiply),
    };
  }

  @override
  void initState() {
    digitEquals.requestFocus();
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
      {required FocusNode focusNode,
      double width = 70,
      double height = 56,
      required Function() f}) {
    return Padding(
        padding: const EdgeInsets.all(2.5),
        child: OutlinedButton(
          key: Key(text!),
          focusNode: focusNode,
          style: OutlinedButton.styleFrom(fixedSize: Size(width, height)),
          child: Align(
              alignment: Alignment.center,
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              )),
          onPressed: f,
        ));
  }

  Widget buildCalculator() {
    return FocusScope(
        skipTraversal: true,
        autofocus: true,
        child: Shortcuts(
            shortcuts: defaultCalculatorShortcuts,
            child: Actions(
                actions: <Type, Action<Intent>>{
                  CalculatorActivateIntent: CalculatorActivateAction(),
                  DismissIntent: CallbackAction<DismissIntent>(onInvoke: (_) {
                    Navigator.of(context).pop();
                    return null;
                  })
                },
                child: AlertDialog(
                  title: Row(
                    children: [
                      Expanded(child: Text(widget.title)),
                      const CloseButton()
                    ],
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
                                    color: Colors.blueGrey,
                                    fontSize: equationFontSize),
                              ))),
                      SizedBox(
                          width: 290,
                          child: SingleChildScrollView(
                              reverse: true,
                              scrollDirection: Axis.horizontal,
                              child: SelectableText(
                                v2,
                                key: const Key("result"),
                                style: TextStyle(fontSize: resultFontSize),
                              ))),
                      const SizedBox(height: 20, width: 400),
                      Column(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                buildButton("⌫",
                                    focusNode: digitBackspace,
                                    f: () => buttonPressed("BSPC")),
                                buildButton("CE",
                                    focusNode: digitCE,
                                    f: () => buttonPressed("CE")),
                                buildButton("C",
                                    focusNode: digitC,
                                    f: () => buttonPressed("C")),
                                buildButton("÷",
                                    focusNode: digitDivide,
                                    f: () => buttonPressed("/")),
                              ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                buildButton("1",
                                    focusNode: digit1,
                                    f: () => buttonPressed("1")),
                                buildButton("2",
                                    focusNode: digit2,
                                    f: () => buttonPressed("2")),
                                buildButton("3",
                                    focusNode: digit3,
                                    f: () => buttonPressed("3")),
                                buildButton("⨉",
                                    focusNode: digitMultiply,
                                    f: () => buttonPressed("*")),
                              ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                buildButton("4",
                                    focusNode: digit4,
                                    f: () => buttonPressed("4")),
                                buildButton("5",
                                    focusNode: digit5,
                                    f: () => buttonPressed("5")),
                                buildButton("6",
                                    focusNode: digit6,
                                    f: () => buttonPressed("6")),
                                buildButton("-",
                                    focusNode: digitSubtract,
                                    f: () => buttonPressed("-")),
                              ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                buildButton("7",
                                    focusNode: digit7,
                                    f: () => buttonPressed("7")),
                                buildButton("8",
                                    focusNode: digit8,
                                    f: () => buttonPressed("8")),
                                buildButton("9",
                                    focusNode: digit9,
                                    f: () => buttonPressed("9")),
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
                                    focusNode: digit0,
                                    f: () => buttonPressed("0")),
                                buildButton(".",
                                    focusNode: digitDot,
                                    f: () => buttonPressed(".")),
                                buildButton("=",
                                    focusNode: digitEquals,
                                    f: () => buttonPressed("=")),
                              ]),
                        ],
                      ),
                    ],
                  ),
                  actions: const [],
                ))));
  }

  @override
  Widget build(BuildContext context) {
    return buildCalculator();
    // show the dialog
  }
}