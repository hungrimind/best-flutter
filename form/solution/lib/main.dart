import 'package:demo/form.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TextField Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('TextField Example'),
        ),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: LoginForm(),
          ),
        ),
      ),
    );
  }
}
