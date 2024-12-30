import 'package:flutter/material.dart';

class Widgets extends StatelessWidget {
  const Widgets({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 20,
        children: const [
          Text(
            'Simple Text Widget',
            style: TextStyle(fontSize: 20),
          ),
          ListTile(
            title: Text('List Tile Widget'),
            leading: Icon(Icons.star),
          ),
          FlutterLogo(
            size: 100,
          ),
        ],
      ),
    );
  }
}
