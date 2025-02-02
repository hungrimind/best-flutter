import 'package:demo/auth/user.dart';
import 'package:demo/auth/user_service.dart';
import 'package:demo/core/database_abstraction.dart';

class DatabaseViewModel {
  DatabaseViewModel({
    required DatabaseAbstraction databaseAbstraction,
    required UserService userService,
  })  : _databaseAbstraction = databaseAbstraction,
        _userService = userService;

  final DatabaseAbstraction _databaseAbstraction;
  final UserService _userService;

  Stream<List<User>> listenToAllUsers() {
    return _databaseAbstraction.dbUpdates
        .where((update) => update.tableName == 'users')
        .map((_) {
      return getAllUsers();
    });
  }

  List<User> getAllUsers() {
    const query = 'SELECT * FROM users';
    final result = _databaseAbstraction.dbSelect(query);
    return result
        .map((row) => User(
            name: row['name'] as String,
            id: row['id'] as int,
            uid: row['uid'] as String))
        .toList();
  }

  void deleteUser(User user) {
    _userService.deleteUser(user);
  }
}
