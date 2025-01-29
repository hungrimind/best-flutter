import 'package:demo/user.dart';
import 'package:demo/user_service.dart';
import 'package:flutter/material.dart';

class LoginViewModel {
  LoginViewModel(UserService userService) : _userService = userService;

  final UserService _userService;

  late final ValueNotifier<User?> userNotifier = _userService.userNotifier;

  void login() {
    _userService.startSession();
  }
}
