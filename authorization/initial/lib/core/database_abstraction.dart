import 'package:demo/core/sqlite/sqlite3.dart' show openSqliteDb;
import 'package:sqlite3/common.dart' show CommonDatabase;

class DatabaseUpdate {
  final DatabaseUpdateKind kind;
  final String tableName;
  final int rowId;

  DatabaseUpdate(this.kind, this.tableName, this.rowId);
}

enum DatabaseUpdateKind {
  insert,
  update,
  delete,
}

class DatabaseAbstraction {
  late CommonDatabase _db;

  // Database operation wrappers
  void dbExecute(String query, [List<Object?> parameters = const []]) {
    _db.execute(query, parameters);
  }

  List<Map<String, Object?>> dbSelect(String query,
      [List<Object?> parameters = const []]) {
    return _db.select(query, parameters);
  }

  Stream<DatabaseUpdate> get dbUpdates => _db.updates.map(
        (update) => DatabaseUpdate(DatabaseUpdateKind.values[update.kind.index],
            update.tableName, update.rowId),
      );

  Future<void> openDatabaseWithTables(
      List<String> tables, String dbName) async {
    _db = await openSqliteDb(dbName: dbName);

    for (final table in tables) {
      _db.execute(table);
    }
  }
}
