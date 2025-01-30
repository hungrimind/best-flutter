import 'package:demo/database_abstraction.dart';
import 'package:demo/user.dart';

class UserService {
  UserService({required DatabaseAbstraction databaseAbstraction})
      : _databaseAbstraction = databaseAbstraction;

  final DatabaseAbstraction _databaseAbstraction;

  void createUser(User user) {
    final query = 'INSERT INTO users (name, uid) VALUES  (?, ?)';
    _databaseAbstraction.dbExecute(query, [user.name, user.uid]);
    final dbUser = getUser(user.name);
    if (dbUser == null) {
      throw Exception('User not found');
    }
    createSession(dbUser);
  }

  void deleteUser(User user) {
    final deleteSessionQuery = 'DELETE FROM sessions WHERE userId = ?';
    _databaseAbstraction.dbExecute(deleteSessionQuery, [user.id]);

    final deleteUserQuery = 'DELETE FROM users WHERE id = ?';
    _databaseAbstraction.dbExecute(deleteUserQuery, [user.id]);
  }

  void createSession(User user) {
    final deleteQuery = 'DELETE FROM sessions';
    _databaseAbstraction.dbExecute(deleteQuery);

    final insertQuery = 'INSERT INTO sessions (userId) VALUES (?)';
    _databaseAbstraction.dbExecute(insertQuery, [user.id]);
  }

  User? sessionExists() {
    final query = 'SELECT * FROM sessions';
    final result = _databaseAbstraction.dbSelect(query);
    if (result.isEmpty) {
      return null;
    }

    final sessionUserId = result[0]['userId'] as int;
    final userQuery = 'SELECT * FROM users WHERE id = ?';
    final userResult =
        _databaseAbstraction.dbSelect(userQuery, [sessionUserId]);
    return User(
        name: userResult[0]['name'] as String,
        id: userResult[0]['id'] as int,
        uid: userResult[0]['uid'] as String);
  }

  void deleteSession(User user) {
    final query = 'DELETE FROM sessions WHERE userId = ?';
    _databaseAbstraction.dbExecute(query, [user.id]);
  }

  User? getUser(String name) {
    final query = 'SELECT * FROM users WHERE name = ?';
    final result = _databaseAbstraction.dbSelect(query, [name]);
    return result
        .map((row) => User(
            name: row['name'] as String,
            id: row['id'] as int,
            uid: row['uid'] as String))
        .firstOrNull;
  }

  Stream<User?> listenToUser(String name) {
    return _databaseAbstraction.dbUpdates
        .where((update) => update.tableName == 'users')
        .map((_) {
      final query = 'SELECT * FROM users WHERE name = ?';
      final result = _databaseAbstraction.dbSelect(query, [name]);
      return result
          .map((row) => User(
              name: row['name'] as String,
              id: row['id'] as int,
              uid: row['uid'] as String))
          .firstOrNull;
    });
  }

  List<User> getAllUsers() {
    const query = 'SELECT * FROM users';
    final result = _databaseAbstraction.dbSelect(query);
    return result
        .map((row) => User(
            name: row['name'] as String,
            id: row['id'] as int,
            uid: row['uid'] as String))
        .toList();
  }

  Stream<List<User>> listenToAllUsers() {
    return _databaseAbstraction.dbUpdates
        .where((update) => update.tableName == 'users')
        .map((_) {
      return getAllUsers();
    });
  }
}
