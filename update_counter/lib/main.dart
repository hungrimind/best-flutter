import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const LayoutDemo(),
    );
  }
}

class LayoutDemo extends StatelessWidget {
  const LayoutDemo({super.key});

  Widget _buildColorBox(Color color) {
    return Container(
      margin: const EdgeInsets.all(8),
      width: 50,
      height: 50,
      color: color,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Row & Column Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // A row of colored boxes
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildColorBox(Colors.red),
                _buildColorBox(Colors.green),
                _buildColorBox(Colors.blue),
              ],
            ),
            const SizedBox(height: 20), // Spacing
            // A column of text
            Column(
              children: const [
                Text('First Text'),
                Text('Second Text'),
                Text('Third Text'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
