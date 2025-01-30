import 'dart:async';

import 'package:demo/sqlite_abstraction.dart';
import 'package:demo/user.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class UserService {
  UserService({required SqliteAbstraction sqliteAbstraction})
      : _sqliteAbstraction = sqliteAbstraction;

  final ValueNotifier<User?> userNotifier = ValueNotifier(null);

  StreamSubscription<User?>? userStreamSubscription;

  final SqliteAbstraction _sqliteAbstraction;

  void _listenToUser(String name) {
    // Cancel existing subscription first
    userStreamSubscription?.cancel();

    userNotifier.value = _sqliteAbstraction.getUser(name);
    userStreamSubscription =
        _sqliteAbstraction.listenToUser(name).listen((user) {
      userNotifier.value = user;
    });
  }

  void createUser(String name) {
    _listenToUser(name);
    _sqliteAbstraction.createUser(User(name: name, uid: Uuid().v4()));
  }

  void createSession(String name) {
    final user = _sqliteAbstraction.getUser(name);
    if (user == null) {
      throw Exception('User not found');
    }

    _sqliteAbstraction.createSession(user);
    _listenToUser(name);
  }

  void checkForSession() {
    final user = _sqliteAbstraction.sessionExists();
    if (user == null) {
      print('No session found');
      return;
    }
    _listenToUser(user.name);
    userNotifier.value = user;
  }

  void endSession() {
    _sqliteAbstraction.deleteSession(userNotifier.value!);
    userNotifier.value = null;
  }

  void dispose() {
    userStreamSubscription?.cancel();
  }
}
