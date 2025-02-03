import 'package:demo/counter/counter_view_model.dart';
import 'package:demo/core/database_view.dart';
import 'package:demo/core/locator.dart';
import 'package:flutter/material.dart';

class CounterView extends StatefulWidget {
  const CounterView({super.key});

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  late final CounterViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = CounterViewModel(locator.get());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Counter Example'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DatabasePage(),
                ),
              );
            },
            child: const Text('Show Database'),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times:'),
            StreamBuilder<int>(
              stream: _viewModel.counterStream,
              initialData: _viewModel.getCurrentCount(),
              builder: (context, snapshot) {
                return Text(
                  '${snapshot.data ?? 0}',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _viewModel.incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
