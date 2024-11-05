import 'package:calculadora/app/core/math.dart';
import 'package:flutter/material.dart';
import 'home_results.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String displayText = '0';
  String operator = '';
  num? num1;
  num? num2;
  List<String> historico = [];

  void onKeyPressed(String value) {
    setState(() {
      if (value == 'C') {
        displayText = '0';
        num1 = null;
        num2 = null;
        operator = '';
      } else if (value == '<-') {
        if (displayText.isNotEmpty) {
          displayText = displayText.substring(0, displayText.length - 1);
          if (displayText.isEmpty) {
            displayText = '0';
          }
        }
      } else if (value == '+' ||
          value == '-' ||
          value == '*' ||
          value == '/' ||
          value == 'x' ||
          value == '%') {
        num1 ??= num.tryParse(displayText);
        operator = value;
        displayText += value;
      } else if (value == '=') {
        if (num1 != null && operator.isNotEmpty) {
          num2 = num.tryParse(displayText.split(operator).last);
          if (num2 != null) {
            final result = Math.calculate(num1!, num2!, operator);
            historico.add('$num1 $operator $num2 = $result');
            displayText = result.toString();
            num1 = result;
            num2 = null;
            operator = '';
          }
          num1 = null;
          num2 = null;
          operator = '';
          displayText = '0';
        }
      } else {
        if (displayText == '0' && value != ',') {
          displayText = value;
        } else {
          displayText += value;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora'),
      ),
      body: Column(
        children: [
          Expanded(
            child: HomeResults(displayText: displayText, historico: historico),
          ),
          const Divisor(),
          Expanded(
            child: Keyboard(onKeyPressed: onKeyPressed),
          ),
        ],
      ),
    );
  }
}

class Divisor extends StatelessWidget {
  const Divisor({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.0),
      child: Divider(
        color: Colors.black,
        thickness: 2.0,
      ),
    );
  }
}

class Keyboard extends StatelessWidget {
  final void Function(String) onKeyPressed;

  const Keyboard({super.key, required this.onKeyPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            KeyButton(text: '7', onKeyPressed: onKeyPressed),
            const SizedBox(width: 8),
            KeyButton(text: '8', onKeyPressed: onKeyPressed),
            const SizedBox(width: 8),
            KeyButton(text: '9', onKeyPressed: onKeyPressed),
            const SizedBox(width: 8),
            KeyButton(text: 'x', onKeyPressed: onKeyPressed),
            const SizedBox(width: 8),
            KeyButton(text: '/', onKeyPressed: onKeyPressed),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            KeyButton(text: '4', onKeyPressed: onKeyPressed),
            const SizedBox(width: 8),
            KeyButton(text: '5', onKeyPressed: onKeyPressed),
            const SizedBox(width: 8),
            KeyButton(text: '6', onKeyPressed: onKeyPressed),
            const SizedBox(width: 8),
            KeyButton(text: '-', onKeyPressed: onKeyPressed),
            const SizedBox(width: 8),
            KeyButton(text: ',', onKeyPressed: onKeyPressed),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            KeyButton(text: '1', onKeyPressed: onKeyPressed),
            const SizedBox(width: 8),
            KeyButton(text: '2', onKeyPressed: onKeyPressed),
            const SizedBox(width: 8),
            KeyButton(text: '3', onKeyPressed: onKeyPressed),
            const SizedBox(width: 8),
            KeyButton(text: '+', onKeyPressed: onKeyPressed),
            const SizedBox(width: 8),
            KeyButton(text: '%', onKeyPressed: onKeyPressed),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            KeyButton(text: '0', onKeyPressed: onKeyPressed),
            const SizedBox(width: 8),
            KeyButton(text: 'C', onKeyPressed: onKeyPressed),
            const SizedBox(width: 8),
            KeyButton(text: '<-', onKeyPressed: onKeyPressed),
            const SizedBox(width: 8),
            KeyButton(text: '=', onKeyPressed: onKeyPressed),
          ],
        ),
      ],
    );
  }
}

class KeyButton extends StatelessWidget {
  final String text;
  final void Function(String) onKeyPressed;

  const KeyButton({super.key, required this.text, required this.onKeyPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      height: 70,
      child: ElevatedButton(
        onPressed: () => onKeyPressed(text),
        child: Text(text, style: const TextStyle(fontSize: 24)),
      ),
    );
  }
}
