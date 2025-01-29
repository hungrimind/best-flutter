import 'package:demo/user.dart';
import 'package:sqlite3/wasm.dart';

class SqliteAbstraction {
  late WasmSqlite3 sqlite;
  late CommonDatabase db;

  Future<void> loadSqlite() async {
    final tempSqlite = await WasmSqlite3.loadFromUrl(Uri.parse('sqlite3.wasm'));
    final fileSystem = await IndexedDbFileSystem.open(dbName: 'my_app');
    tempSqlite.registerVirtualFileSystem(fileSystem, makeDefault: true);
    sqlite = tempSqlite;
    db = sqlite.open('my_app');

    // Create users table if it doesn't exist
    const createTableQuery = '''
      CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        uid INTEGER NOT NULL
      )
    ''';
    db.execute(createTableQuery);

    const createSessionTableQuery = '''
      CREATE TABLE IF NOT EXISTS sessions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER NOT NULL,
        FOREIGN KEY (userId) REFERENCES users(id)
      )
    ''';
    db.execute(createSessionTableQuery);
  }

  void createUser(User user) {
    final query = 'INSERT INTO users (name, uid) VALUES  (?, ?)';
    db.execute(query, [user.name, user.uid]);
  }

  void deleteUser(User user) {
    final query = 'DELETE FROM users WHERE id = ?';
    db.execute(query, [user.id]);
  }

  void createSession(User user) {
    final query = 'INSERT INTO sessions (userId) VALUES (?)';
    db.execute(query, [user.id]);
  }

  void deleteSession(User user) {
    final query = 'DELETE FROM sessions WHERE userId = ?';
    db.execute(query, [user.id]);
  }

  User? getUser(String name) {
    final query = 'SELECT * FROM users WHERE name = ?';
    final result = db.select(query, [name]);
    return result
        .map((row) => User(
            name: row['name'] as String,
            id: row['id'] as int,
            uid: row['uid'] as int))
        .firstOrNull;
  }

  Stream<User?> listenToUser(String name) {
    return db.updates.where((update) => update.tableName == 'users').map((_) {
      final query = 'SELECT * FROM users WHERE name = ?';
      final result = db.select(query, [name]);
      return result
          .map((row) => User(
              name: row['name'] as String,
              id: row['id'] as int,
              uid: row['uid'] as int))
          .firstOrNull;
    });
  }

  List<User> getAllUsers() {
    const query = 'SELECT * FROM users';
    final result = db.select(query);
    return result
        .map((row) => User(
            name: row['name'] as String,
            id: row['id'] as int,
            uid: row['uid'] as int))
        .toList();
  }

  Stream<List<User>> listenToAllUsers() {
    return db.updates.where((update) => update.tableName == 'users').map((_) {
      return getAllUsers();
    });
  }
}
