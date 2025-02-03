import 'package:demo/auth/user.dart';
import 'package:demo/auth/user_service.dart';
import 'package:uuid/uuid.dart';

class CreateAccountViewModel {
  CreateAccountViewModel(UserService userService) : _userService = userService;

  final UserService _userService;

  User? createUser(String name) {
    try {
      if (name == 'admin') {
        return _userService.createUser(User(
          name: name,
          uid: Uuid().v4(),
          isAdmin: 1,
        ));
      } else {
        return _userService.createUser(User(
          name: name,
          uid: Uuid().v4(),
          isAdmin: 0,
        ));
      }
    } catch (e) {
      return null;
    }
  }
}
