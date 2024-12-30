import 'package:flutter/material.dart';

class LayoutDemo extends StatelessWidget {
  const LayoutDemo({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Row & Column Lesson',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            'by Hungrimind',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Row(
            children: [
              Container(width: 50, height: 50, color: Colors.red),
              Container(width: 50, height: 50, color: Colors.green),
              Container(width: 50, height: 50, color: Colors.blue),
            ],
          ),
        ],
      ),
    );
  }
}
