import 'package:flutter/material.dart';

void main() {
  runApp(const Calculator());
}

CalculatorBackend logic = CalculatorBackend();

class Calculator extends StatelessWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Calculator',
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: CalculatorDisplay(),
        ),
      ),
    );
  }
}

class CalculatorDisplay extends StatefulWidget {
  const CalculatorDisplay({Key? key}) : super(key: key);

  @override
  NumberDisplayState createState() => NumberDisplayState();
}

class NumberDisplayState extends State {
  String displayVal = '';

  get key => null;
  updateDisplay() {
    setState(() {
      displayVal = logic.getVal2().toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Text(
          logic.getVal().toString(),
          style: const TextStyle(fontSize: 40),
        ),
        Text(
          logic.getMode() + logic.getVal2().toString(),
          style: const TextStyle(fontSize: 20),
        ),
        GridView.count(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          crossAxisCount: 7,
          children: [
            MaterialButton(
              child: const Text('.'),
              onPressed: () {
                logic.insertDecimal();
                updateDisplay();
              },
            ),
            MaterialButton(
              child: const Text('*'),
              onPressed: () {
                logic.changeMode("*");
                updateDisplay();
              },
            ),
            MaterialButton(
              child: const Text('/'),
              onPressed: () {
                logic.changeMode("/");
                updateDisplay();
              },
            ),
            MaterialButton(
              child: const Text('+'),
              onPressed: () {
                logic.changeMode("+");
                updateDisplay();
              },
            ),
            MaterialButton(
              child: const Text('-'),
              onPressed: () {
                logic.changeMode("-");
                updateDisplay();
              },
            ),
            MaterialButton(
              child: const Text('='),
              onPressed: () {
                logic.equal();
                updateDisplay();
              },
            ),
            MaterialButton(
              child: const Text('←'),
              onPressed: () {
                logic.popVal2();
                updateDisplay();
              },
            ),
          ],
        ),
        const Divider(
          thickness: 1,
        ),
        GridView.count(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          crossAxisCount: 5,
          children: List.generate(10, (i) {
            return MaterialButton(
              child: Text('$i'),
              onPressed: () {
                logic.appendVal2(i);
                updateDisplay();
              },
            );
          }),
        ),
      ],
    );
  }
}

class CalculatorBackend {
  double val = 0.0;
  double val2 = 0.0;
  int decimal = 0;
  String mode = "=";
  double getVal() {
    return val;
  }

  double getVal2() {
    return val2;
  }

  void appendVal2(number) {
    if (decimal != 0) {
      val2 += number / decimal;
      decimal *= 10;
    } else {
      val2 *= 10;
      val2 += number;
    }
  }

  void popVal2() {
    if (val2 > 0.0) {
      val2 -= val2 % 10;
      val2 /= 10;
    }
  }

  String getMode() {
    return mode;
  }

  void changeMode(String current) {
    mode = current;
  }

  void insertDecimal() {
    decimal = 10;
  }

  void equal() {
    if (mode == "=") {
      val = val2;
    }
    if (mode == "+") {
      val += val2;
    }
    if (mode == "-") {
      val -= val2;
    }
    if (mode == "*") {
      val *= val2;
    }
    if (mode == "/") {
      val /= val2;
    }
    val2 = 0;
    mode = "=";
    decimal = 0;
  }
}
