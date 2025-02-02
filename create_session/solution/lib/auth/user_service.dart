import 'dart:async';

import 'package:demo/auth/user.dart';
import 'package:demo/core/database_abstraction.dart';
import 'package:flutter/foundation.dart';

class UserService {
  UserService({required DatabaseAbstraction databaseAbstraction})
      : _databaseAbstraction = databaseAbstraction;

  final DatabaseAbstraction _databaseAbstraction;

  final ValueNotifier<User?> userNotifier = ValueNotifier(null);

  StreamSubscription<User?>? userStreamSubscription;

  void _listenToUser(String name) {
    // Cancel existing subscription first
    userStreamSubscription?.cancel();

    userStreamSubscription = listenToUser(name).listen((user) {
      userNotifier.value = user;
    });
  }

  /// Creates a user and returns the created user
  ///
  /// Throws: [Exception]
  ///
  /// * [Exception] - If the user is not found
  User createUser(User user) {
    final query = 'INSERT INTO users (name, uid) VALUES  (?, ?)';
    _databaseAbstraction.dbExecute(query, [user.name, user.uid]);
    final dbUser = getUser(user.name);
    _listenToUser(user.name);
    if (dbUser == null) {
      throw Exception('User not found');
    }
    createSession(dbUser.name);
    return dbUser;
  }

  void deleteUser(User user) {
    final deleteSessionQuery = 'DELETE FROM sessions WHERE userId = ?';
    _databaseAbstraction.dbExecute(deleteSessionQuery, [user.id]);

    final deleteUserQuery = 'DELETE FROM users WHERE id = ?';
    _databaseAbstraction.dbExecute(deleteUserQuery, [user.id]);
  }

  User? createSession(String name) {
    final user = getUser(name);
    if (user == null) {
      throw Exception('User not found');
    }

    final deleteQuery = 'DELETE FROM sessions';
    _databaseAbstraction.dbExecute(deleteQuery);

    final insertQuery = 'INSERT INTO sessions (userId) VALUES (?)';
    _databaseAbstraction.dbExecute(insertQuery, [user.id]);
    _listenToUser(user.name);
    userNotifier.value = user;
    return user;
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
    final user = User(
        name: userResult[0]['name'] as String,
        id: userResult[0]['id'] as int,
        uid: userResult[0]['uid'] as String);
    _listenToUser(user.name);
    userNotifier.value = user;
    return user;
  }

  void deleteSession(User user) {
    final query = 'DELETE FROM sessions WHERE userId = ?';
    _databaseAbstraction.dbExecute(query, [user.id]);
    userNotifier.value = null;
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
      final user = result
          .map((row) => User(
              name: row['name'] as String,
              id: row['id'] as int,
              uid: row['uid'] as String))
          .firstOrNull;
      return user;
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
