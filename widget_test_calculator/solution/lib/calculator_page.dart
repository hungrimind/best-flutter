import 'package:flutter/material.dart';
import 'calculator.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final calculator = Calculator();

  int firstNumber = 0;
  int secondNumber = 0;
  String? result;
  String? operation;

  void _setOperation(String op) {
    setState(() {
      operation = op;
      result = null;
    });
  }

  void _calculate() {
    setState(() {
      try {
        switch (operation) {
          case '+':
            result = calculator.add(firstNumber, secondNumber).toString();
          case '-':
            result = calculator.subtract(firstNumber, secondNumber).toString();
          case '*':
            result = calculator.multiply(firstNumber, secondNumber).toString();
          case '/':
            result = calculator.divide(firstNumber, secondNumber).toString();
        }
      } catch (e) {
        result = 'Error';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator Widget Test Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'First Number'),
              keyboardType: TextInputType.number,
              onChanged: (value) => setState(() {
                firstNumber = int.tryParse(value) ?? 0;
              }),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Second Number'),
              keyboardType: TextInputType.number,
              onChanged: (value) => setState(() {
                secondNumber = int.tryParse(value) ?? 0;
              }),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _setOperation('+'),
                  child: const Text('+'),
                ),
                ElevatedButton(
                  onPressed: () => _setOperation('-'),
                  child: const Text('-'),
                ),
                ElevatedButton(
                  onPressed: () => _setOperation('*'),
                  child: const Text('×'),
                ),
                ElevatedButton(
                  onPressed: () => _setOperation('/'),
                  child: const Text('÷'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: operation != null ? _calculate : null,
              child: const Text('Calculate'),
            ),
            if (result != null) ...[
              const SizedBox(height: 20),
              Text(
                'Result: $result',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ],
        ),
      ),
    );
  }
}