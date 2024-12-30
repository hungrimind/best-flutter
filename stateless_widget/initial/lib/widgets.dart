import 'package:flutter/material.dart';

class Widgets extends StatelessWidget {
  const Widgets({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 20,
        children: const [Placeholder()],
      ),
    );
  }
}
