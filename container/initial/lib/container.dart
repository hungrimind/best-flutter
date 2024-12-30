import 'package:flutter/material.dart';

class Demo extends StatelessWidget {
  const Demo({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: const Text(
          "Add Name Here",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
