import 'package:flutter/material.dart';

class Demo extends StatelessWidget {
  const Demo({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 200,
          width: 200,
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 20),
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue,
          ),
          child: const Text(
            "Add Name Here",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}