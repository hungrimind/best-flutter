import 'package:demo/auth/user.dart';
import 'package:demo/core/database_abstraction.dart';

class UserService {
  UserService({required DatabaseAbstraction databaseAbstraction})
      : _databaseAbstraction = databaseAbstraction;

  final DatabaseAbstraction _databaseAbstraction;

  /// Creates a user and returns the created user
  ///
  /// Throws: [Exception]
  ///
  /// * [Exception] - If the user is not found
  User createUser(User user) {
    final query = 'INSERT INTO users (name, uid) VALUES  (?, ?)';
    _databaseAbstraction.dbExecute(query, [user.name, user.uid]);
    final dbUser = getUser(user.name);
    if (dbUser == null) {
      throw Exception('User not found');
    }
    createSession(dbUser);
    return dbUser;
  }

  void deleteUser(User user) {
    final deleteSessionQuery = 'DELETE FROM sessions WHERE user_id = ?';
    _databaseAbstraction.dbExecute(deleteSessionQuery, [user.id]);

    final deleteUserQuery = 'DELETE FROM users WHERE id = ?';
    _databaseAbstraction.dbExecute(deleteUserQuery, [user.id]);
  }

  void createSession(User user) {
    final deleteQuery = 'DELETE FROM sessions';
    _databaseAbstraction.dbExecute(deleteQuery);

    final insertQuery = 'INSERT INTO sessions (user_id) VALUES (?)';
    _databaseAbstraction.dbExecute(insertQuery, [user.id]);
  }

  User? sessionExists() {
    final query = 'SELECT * FROM sessions';
    final result = _databaseAbstraction.dbSelect(query);
    if (result.isEmpty) {
      return null;
    }

    final sessionUserId = result[0]['user_id'] as int;
    final userQuery = 'SELECT * FROM users WHERE id = ?';
    final userResult =
        _databaseAbstraction.dbSelect(userQuery, [sessionUserId]);
    return User.fromJson(userResult[0]);
  }

  void deleteSession(User user) {
    final query = 'DELETE FROM sessions WHERE user_id = ?';
    _databaseAbstraction.dbExecute(query, [user.id]);
  }

  User? getUser(String name) {
    final query = 'SELECT * FROM users WHERE name = ?';
    final result = _databaseAbstraction.dbSelect(query, [name]);
    return result
        .map((row) => User.fromJson(row))
        .firstOrNull;
  }

  Stream<User?> listenToUser(String name) {
    return _databaseAbstraction.dbUpdates
        .where((update) => update.tableName == 'users')
        .map((_) {
      final query = 'SELECT * FROM users WHERE name = ?';
      final result = _databaseAbstraction.dbSelect(query, [name]);
      return result
          .map((row) => User.fromJson(row))
          .firstOrNull;
    });
  }

  List<User> getAllUsers() {
    const query = 'SELECT * FROM users';
    final result = _databaseAbstraction.dbSelect(query);
    return result
        .map((row) => User.fromJson(row))
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
