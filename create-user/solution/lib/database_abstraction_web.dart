import 'package:demo/database_abstraction_vm.dart';
import 'package:sqlite3/wasm.dart';

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
