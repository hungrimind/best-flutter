import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Padding and Margin Demo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              Container(
                width: 200,
                color: Colors.blue,
                child: const Text(
                  'No Padding or Margin',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 200,
                color: Colors.red[200],
                child: Container(
                  color: Colors.blue,
                  child: const Text(
                    'Padded Text',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                width: 200,
                color: Colors.red[200],
                child: Container(
                  color: Colors.blue,
                  child: const Text(
                    'Margin Text',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
