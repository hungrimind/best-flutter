import 'dart:async';

import 'package:demo/counter/counter_view.dart';
import 'package:demo/core/database_abstraction.dart';
import 'package:demo/core/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeDatabaseAbstraction extends Fake implements DatabaseAbstraction {
  int currentCount = 0;
  final _controller = StreamController<DatabaseUpdate>.broadcast();

  @override
  List<Map<String, dynamic>> dbSelect(String query, [List<Object?> parameters = const []]) {
    if (query.contains('SELECT count FROM counters')) {
      return currentCount == 0 ? [] : [{'count': currentCount}];
    }
    return [];
  }

  @override
  void dbExecute(String query, [List<Object?> parameters = const []]) {
    if (query.contains('INSERT OR REPLACE INTO counters')) {
      currentCount = parameters[0] as int;
      _controller.add(DatabaseUpdate(
        DatabaseUpdateKind.update,
        'counters',
        1, // rowId
      ));
    }
  }

  @override
  Stream<DatabaseUpdate> get dbUpdates => _controller.stream;

  void dispose() {
    _controller.close();
  }
}

void main() {
  late FakeDatabaseAbstraction fakeDb;

  setUp(() {
    fakeDb = FakeDatabaseAbstraction();
    locator.registerSingleton<DatabaseAbstraction>(fakeDb);
  });

  tearDown(() {
    fakeDb.dispose();
    locator.reset();
  });

  group('CounterView', () {
    testWidgets('displays initial count of zero', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: CounterView(),
      ));

      expect(find.text('0'), findsOneWidget);
    });

    testWidgets('increments counter when FAB is pressed', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: CounterView(),
      ));

      // Initial state
      expect(find.text('0'), findsOneWidget);

      // Tap the increment button
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();

      // Verify counter increased
      expect(find.text('1'), findsOneWidget);

      // Tap again
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();

      // Verify counter increased again
      expect(find.text('2'), findsOneWidget);
    });

    testWidgets('shows database page when button is pressed', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: CounterView(),
      ));

      await tester.tap(find.text('Show Database'));
      await tester.pumpAndSettle();

      // Verify navigation to database page
      expect(find.text('Database View'), findsOneWidget);
    });
  });
} 