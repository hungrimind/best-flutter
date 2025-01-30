import 'package:sqlite3/wasm.dart';

enum DatabaseUpdateKind {
  insert,
  update,
  delete,
}

final class DatabaseUpdate {
  /// The kind of write being reported.
  final DatabaseUpdateKind kind;

  /// The table on which the update has happened.
  final String tableName;

  /// The id of the inserted, modified or deleted row.
  final int rowId;

  DatabaseUpdate(this.kind, this.tableName, this.rowId);

  @override
  int get hashCode => Object.hash(kind, tableName, rowId);

  @override
  bool operator ==(Object other) {
    return other is DatabaseUpdate &&
        other.kind == kind &&
        other.tableName == tableName &&
        other.rowId == rowId;
  }

  @override
  String toString() {
    return 'DatabaseUpdate: $kind on $tableName, rowid = $rowId';
  }
}

/// Make configuration changes t

class DatabaseAbstraction {
  late WasmSqlite3 _sqlite;
  late CommonDatabase _db;

  // Database operation wrappers
  void dbExecute(String query, [List<Object?> parameters = const []]) {
    _db.execute(query, parameters);
  }

  List<Map<String, Object?>> dbSelect(String query,
      [List<Object?> parameters = const []]) {
    return _db.select(query, parameters);
  }

  Stream<DatabaseUpdate> get dbUpdates =>
      _db.updates.map((update) => DatabaseUpdate(
          DatabaseUpdateKind.values[update.kind.index],
          update.tableName,
          update.rowId));

  Future<void> loadDatabaseWithTables(
      List<String> tables, String dbName) async {
    final tempSqlite = await WasmSqlite3.loadFromUrl(Uri.parse('sqlite3.wasm'));
    final fileSystem = await IndexedDbFileSystem.open(dbName: dbName);
    tempSqlite.registerVirtualFileSystem(fileSystem, makeDefault: true);
    _sqlite = tempSqlite;
    _db = _sqlite.open(dbName);

    for (final table in tables) {
      _db.execute(table);
    }
  }
}
