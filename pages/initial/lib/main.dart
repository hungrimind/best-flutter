import 'package:demo/first.dart';
import 'package:demo/second.dart';
import 'package:demo/third.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Navigator(
        pages: [
          MaterialPage(
            name: 'first',
            child: const FirstPage(),
          ),
          MaterialPage(
            name: 'second',
            child: const SecondPage(),
          ),
        ],
        onDidRemovePage: (page) {
          print('onDidRemovePage: ${page.name}');
        },
      ),
    );
  }
}
