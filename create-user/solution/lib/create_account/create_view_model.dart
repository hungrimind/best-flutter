import 'package:demo/user.dart';
import 'package:demo/user_service.dart';
import 'package:flutter/material.dart';

class CreateAccountViewModel {
  CreateAccountViewModel(UserService userService) : _userService = userService;

  final UserService _userService;

  late final ValueNotifier<User?> userNotifier = _userService.userNotifier;

  void createUser(String name) {
    _userService.createUser(name);
  }
}
