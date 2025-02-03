import 'package:demo/core/database_abstraction.dart';

class CounterViewModel {
  CounterViewModel(DatabaseAbstraction databaseAbstraction) 
      : _db = databaseAbstraction;

  final DatabaseAbstraction _db;

  void incrementCounter() {
    final result = _db.dbSelect('SELECT count FROM counters WHERE id = 1');
    final currentCount = result.isEmpty ? 0 : result.first['count'] as int;
    
    _db.dbExecute(
      'INSERT OR REPLACE INTO counters (id, count) VALUES (1, ?)',
      [currentCount],
    );
  }

  Stream<int> get counterStream => _db.dbUpdates
      .where((update) => update.tableName == 'counters')
      .map((_) {
        final result = _db.dbSelect('SELECT count FROM counters WHERE id = 1');
        return result.isEmpty ? 0 : result.first['count'] as int;
      });

  int getCurrentCount() {
    final result = _db.dbSelect('SELECT count FROM counters WHERE id = 1');
    return result.isEmpty ? 0 : result.first['count'] as int;
  }
}
