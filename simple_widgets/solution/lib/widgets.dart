import 'package:flutter/material.dart';

class WidgetsDemo extends StatelessWidget {
  const WidgetsDemo({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text('ElevatedButton'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('TextButton'),
            ),
            OutlinedButton(
              onPressed: () {},
              child: const Text('OutlinedButton'),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add),
              tooltip: 'Add',
            ),
          ],
        ),
      ),
    );
  }
}
