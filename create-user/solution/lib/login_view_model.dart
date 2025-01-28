import 'dart:async';
import 'dart:math';

import 'package:demo/sqlite_abstraction.dart';
import 'package:demo/user.dart';
import 'package:flutter/material.dart';

class LoginViewModel {
  LoginViewModel() {
    init();
  }

  final ValueNotifier<User?> userNotifier = ValueNotifier(null);

  StreamSubscription<User?>? userStreamSubscription;

  late SqliteAbstraction sqliteAbstraction;

  void init() {
    sqliteAbstraction = SqliteAbstraction();
    sqliteAbstraction.loadSqlite();
  }

  void createUser(String name) {
    userStreamSubscription ??=
        sqliteAbstraction.listenToUser(name).listen((user) {
      userNotifier.value = user;
    });
    sqliteAbstraction
        .createUser(User(name: name, uid: Random().nextInt(1000000)));
  }

  void dispose() {
    userStreamSubscription?.cancel();
  }
}
