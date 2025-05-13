import 'package:demo/main.dart';
import 'package:flutter/material.dart';

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Third'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8,
          children: [
            Text('Third Page'),
            ElevatedButton(
              onPressed: () {
                routes.value = ['/', '/third'];
              },
              child: const Text('Remove middle page'),
            ),
          ],
        ),
      ),
    );
  }
}
