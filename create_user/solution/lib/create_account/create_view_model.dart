import 'package:demo/user.dart';
import 'package:demo/user_service.dart';
import 'package:uuid/uuid.dart';

class CreateAccountViewModel {
  CreateAccountViewModel(UserService userService) : _userService = userService;

  final UserService _userService;

  User? createUser(String name) {
    try {
      return _userService.createUser(User(name: name, uid: Uuid().v4()));
    } catch (e) {
      return null;
    }
  }
}
