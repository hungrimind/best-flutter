import 'dart:async';
import 'dart:math';

import 'package:demo/sqlite_abstraction.dart';
import 'package:demo/user.dart';
import 'package:flutter/material.dart';

class UserService {
  UserService({required SqliteAbstraction sqliteAbstraction})
      : _sqliteAbstraction = sqliteAbstraction;

  final ValueNotifier<User?> userNotifier = ValueNotifier(null);

  StreamSubscription<User?>? userStreamSubscription;

  final SqliteAbstraction _sqliteAbstraction;

  void _listenToUser(String name) {
    userStreamSubscription ??=
        _sqliteAbstraction.listenToUser(name).listen((user) {
      userNotifier.value = user;
    });
  }

  void createUser(String name) {
    _listenToUser(name);
    _sqliteAbstraction
        .createUser(User(name: name, uid: Random().nextInt(1000000)));
  }

  void startSession() {
    final user = _sqliteAbstraction.sessionExists();
    if (user == null) {
      throw Exception('User not found');
    }
    _listenToUser(user.name);
    userNotifier.value = user;
  }

  void endSession() {
    _sqliteAbstraction.deleteSession(userNotifier.value!);
  }

  void dispose() {
    userStreamSubscription?.cancel();
  }
}
