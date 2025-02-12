import 'package:sqlite3/wasm.dart';

Future<CommonDatabase> openSqliteDb({required String dbName}) async {
  final sqlite = await WasmSqlite3.loadFromUrl(Uri.parse('sqlite3.wasm'));
  final fileSystem = await IndexedDbFileSystem.open(dbName: dbName);
  sqlite.registerVirtualFileSystem(fileSystem, makeDefault: true);
  return sqlite.open(dbName);
}
