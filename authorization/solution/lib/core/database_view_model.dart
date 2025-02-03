import 'dart:async';

import 'package:demo/auth/user.dart';
import 'package:demo/auth/user_service.dart';
import 'package:demo/core/database_abstraction.dart';
import 'package:flutter/foundation.dart';

class DatabaseViewModel {
  DatabaseViewModel({
    required DatabaseAbstraction databaseAbstraction,
    required UserService userService,
  })  : _databaseAbstraction = databaseAbstraction,
        _userService = userService;

  final DatabaseAbstraction _databaseAbstraction;
  final UserService _userService;
  
  final ValueNotifier<List<User>> users = ValueNotifier<List<User>>([]);
  final ValueNotifier<List<int>> sessions = ValueNotifier<List<int>>([]);

  StreamSubscription<List<User>>? _usersSubscription;
  StreamSubscription<List<int>>? _sessionsSubscription;

  void init() {
    users.value = getAllUsers();
    sessions.value = getAllSessions();

    _usersSubscription = listenToAllUsers().listen((users) {
      this.users.value = users;
    });
    _sessionsSubscription = listenToAllSessions().listen((sessions) {
      this.sessions.value = sessions;
    });
  }

  void dispose() {
    users.dispose();
    sessions.dispose();
    _usersSubscription?.cancel();
    _sessionsSubscription?.cancel();
  }

  Stream<List<User>> listenToAllUsers() {
    return _databaseAbstraction.dbUpdates
        .where((update) => update.tableName == 'users')
        .map((_) {
      return getAllUsers();
    });
  }

  List<User> getAllUsers() {
    const query = 'SELECT * FROM users';
    final result = _databaseAbstraction.dbSelect(query);
    return result
        .map((row) => User.fromJson(row))
        .toList();
  }

  void deleteUser(User user) {
    _userService.deleteUser(user);
  }

  Stream<List<int>> listenToAllSessions() {
    return _databaseAbstraction.dbUpdates
        .where((update) => update.tableName == 'sessions')
        .map((_) {
      return getAllSessions();
    });
  }

  List<int> getAllSessions() {
    const query = 'SELECT * FROM sessions';
    final result = _databaseAbstraction.dbSelect(query);
    return result
        .map((row) => row['user_id'] as int)
        .toList();
  }
}
