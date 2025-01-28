import 'package:demo/counter_repository.dart';
import 'package:flutter/material.dart';
import 'counter_view_model.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key, required this.title});

  final String title;

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  late final CounterViewModel counterViewModel;

  @override
  void initState() {
    super.initState();
    counterViewModel = CounterViewModel(CounterRepository());
  }

  @override
  void dispose() {
    counterViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: ValueListenableBuilder(
          valueListenable: counterViewModel.issuesNotifier,
          builder: (context, exception, child) {
            if (exception != null) {
              return Text(
                'Fake lesson exception: ${exception.message}',
                style: Theme.of(context).textTheme.headlineMedium,
              );
            }
            return Text(
              'No issues',
              style: Theme.of(context).textTheme.headlineMedium,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: counterViewModel.fetchNumberFromFakeApi,
        tooltip: 'Fetch number from fake api',
        child: const Icon(Icons.network_check),
      ),
    );
  }
}
