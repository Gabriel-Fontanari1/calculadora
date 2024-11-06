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
  String operator = ''; //armazenar o operador a ser usado
  num? num1;
  num? num2;
  List<String> historico = []; //lista do histórico de operações

  void onKeyPressed(String value) {
    setState(() {
      if (value == 'C') {
        //limpar tudo
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
          value == 'x') {
        num1 ??= Math.parseInput(displayText);
        operator = value;
        displayText =
            num1.toString() + operator; //exibe o operador após o primeiro valor
      } else if (value == '%') {
        //calculo de porcentagem
        if (num1 != null && operator.isNotEmpty) {
          num2 = Math.parseInput(displayText.split(operator).last);
          num2 = Math.calculate(num1!, num2!, '%');
          displayText = '$num1 $operator $num2';
        }
      } else if (value == '=') {
        if (num1 != null && operator.isNotEmpty) {
          num2 = Math.parseInput(
              displayText.split(operator).last); //obtem o segundo valor
          if (num2 != null) {
            final result = Math.calculate(num1!, num2!, operator);
            historico.add(
                '$num1 $operator $num2 = $result'); //add ao histórico após mostrar o resultado
            displayText = result.toString();
            num1 = null;
            num2 = null;
            operator = '';
            displayText = '0'; //limpa o display após mostrar o resultado
          }
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

//divisor entre a tela de resultados e o teclado
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

//teclado virtual
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
  //captura o valor do botão pressionado
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
