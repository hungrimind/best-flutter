import 'package:demo/user.dart';
import 'package:demo/user_service.dart';
import 'package:flutter/material.dart';

class HomePageViewModel {
  HomePageViewModel({required UserService userService}) : _userService = userService;

  final UserService _userService;

  ValueNotifier<User?> get userNotifier => _userService.userNotifier;

  void signOut() {
    _userService.endSession();
  }
}
