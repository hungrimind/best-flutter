import 'package:demo/core/database_abstraction.dart';
import 'package:demo/core/locator.dart';
import 'package:demo/counter/counter_view.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();

  await locator<DatabaseAbstraction>().openDatabaseWithTables(
    [
      'CREATE TABLE IF NOT EXISTS counters (id INTEGER PRIMARY KEY AUTOINCREMENT, count INTEGER NOT NULL)',
    ],
    'hungrimind_counter',
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: CounterView(),
    );
  }
}
