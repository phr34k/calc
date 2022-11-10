
Calculator

a simple calculator dialog and utulity state machine to perform arithimetics.

## Features

- open up a calculator dialog that can perform basic arithimetics
- supports key bindings so you can type equations via numpad e.g. 8 * 8 [enter]

## Getting started

Add the following lines to your pubspec.yaml

```yaml
dependencies:
  calc:
    git: https://github.com/phr34k/calc
```

## Usage

The following code show a minimum example of displaying the calculator dialog.

```dart
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.calculate),
        onPressed: () {
          showCalculator(context, true);
        },
      ),
    );
  }
```

## Additional information

Aims to implement a simple calculator that can be embedded into applications, extenced customisation options will follow in consequative releases.