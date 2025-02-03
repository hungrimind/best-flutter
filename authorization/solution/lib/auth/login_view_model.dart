import 'package:demo/auth/user.dart';
import 'package:demo/auth/user_service.dart';
import 'package:flutter/material.dart';

class LoginViewModel {
  LoginViewModel({required UserService userService})
      : _userService = userService;

  final UserService _userService;

  ValueNotifier<User?> get userNotifier => _userService.userNotifier;

  User? login(String name) {
    try {
      return _userService.createSession(name);
    } catch (e) {
      return null;
    }
  }
}