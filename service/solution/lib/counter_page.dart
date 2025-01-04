import 'package:demo/date_service.dart';
import 'package:demo/locator.dart';
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

    counterViewModel = CounterViewModel(
      dateService: locator<DateService>(),
    );
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            const Text('Current Date from the service:'),
            ValueListenableBuilder(
              valueListenable: counterViewModel.dateService,
              builder: (context, date, child) {
                return Text(date.toString());
              },
            ),
            const Text('You have pushed the button this many times:'),
            ValueListenableBuilder(
              valueListenable: counterViewModel.countNotifier,
              builder: (context, count, child) {
                return Text(
                  '$count',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        children: [
          FloatingActionButton(
            onPressed: counterViewModel.increment,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: counterViewModel.updateDate,
            tooltip: 'Update Date',
            child: const Icon(Icons.update),
          ),
        ],
      ),
    );
  }
}
