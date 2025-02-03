import 'package:demo/core/database_abstraction.dart';
import 'package:demo/core/locator.dart';
import 'package:demo/counter/counter_view_model.dart';
import 'package:flutter/material.dart';

class DatabasePage extends StatefulWidget {
  const DatabasePage({super.key});

  @override
  State<DatabasePage> createState() => _DatabasePageState();
}

class _DatabasePageState extends State<DatabasePage> {
  late final CounterViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = CounterViewModel(locator<DatabaseAbstraction>());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Database View'),
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<int>(
          stream: _viewModel.counterStream,
          initialData: _viewModel.getCurrentCount(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 48, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(
                      'Error: ${snapshot.error}',
                      style: theme.textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }

            final count = snapshot.data ?? 0;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Database Contents',
                  style: theme.textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                Card(
                  child: ListTile(
                    title: Text(
                      'Counter',
                      style: theme.textTheme.titleMedium,
                    ),
                    subtitle: Text(
                      'ID: 1',
                      style: theme.textTheme.bodySmall,
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Count: $count',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
