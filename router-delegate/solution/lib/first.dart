import 'package:demo/main.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            Text('First Page'),
            ElevatedButton(
              onPressed: () {
                routes.value = ['/first', '/second'];
              },
              child: const Text('Go to Second'),
            ),
            ElevatedButton(
              onPressed: () {
                routes.value = ['/first', '/second', '/third'];
              },
              child: const Text('Add Second and Third'),
            ),
          ],
        ),
      ),
    );
  }
}
