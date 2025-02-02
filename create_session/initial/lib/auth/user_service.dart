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
    _createSession(dbUser);
    return dbUser;
  }

  /// Delete any session for this user as well
  void deleteUser(User user) {
    deleteSession(user);

    final deleteUserQuery = 'DELETE FROM users WHERE id = ?';
    _databaseAbstraction.dbExecute(deleteUserQuery, [user.id]);
  }

  /// Creates a session for a user and returns the user
  ///
  /// Throws: [Exception]
  ///
  /// * [Exception] - If the user is not found
  User? createSession(String name) {
    final user = getUser(name);
    if (user == null) {
      throw Exception('User not found');
    }

    _createSession(user);
    return user;
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
    final user = User.fromJson(userResult[0]);
    _listenToUser(user);
    userNotifier.value = user;
    return user;
  }

  void deleteSession(User user) {
    final query = 'DELETE FROM sessions WHERE user_id = ?';
    _databaseAbstraction.dbExecute(query, [user.id]);
    userNotifier.value = null;
  }

  User? getUser(String name) {
    final query = 'SELECT * FROM users WHERE name = ?';
    final result = _databaseAbstraction.dbSelect(query, [name]);
    return result
        .map((row) => User.fromJson(row))
        .firstOrNull;
  }

  void _listenToUser(User user) {
    // Cancel existing subscription first
    userStreamSubscription?.cancel();

    userStreamSubscription = _databaseAbstraction.dbUpdates
        .where((update) => update.tableName == 'users')
        .map((_) {
      final query = 'SELECT * FROM users WHERE name = ?';
      final result = _databaseAbstraction.dbSelect(query, [user.name]);
      final userResult = result
          .map((row) => User.fromJson(row))
          .firstOrNull;
      return userResult;
    }).listen((userResult) {
      userNotifier.value = userResult;
    });
  }

  void _createSession(User user) {
    deleteSession(user);
    final insertQuery = 'INSERT INTO sessions (user_id) VALUES (?)';
    _databaseAbstraction.dbExecute(insertQuery, [user.id]);
    _listenToUser(user);
    userNotifier.value = user;
  }
}
