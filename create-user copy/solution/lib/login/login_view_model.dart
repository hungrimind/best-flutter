import 'package:demo/user.dart';
import 'package:demo/user_service.dart';
import 'package:flutter/material.dart';

class LoginViewModel {
  LoginViewModel({required UserService userService}) : _userService = userService;

  final UserService _userService;

  ValueNotifier<User?> get userNotifier => _userService.userNotifier;

  void login(String name) {
    _userService.createSession(name);
  }
}
