import 'package:demo/sqlite_abstraction.dart';
import 'package:demo/user.dart';
import 'package:uuid/uuid.dart';

class UserService {
  UserService({required SqliteAbstraction sqliteAbstraction})
      : _sqliteAbstraction = sqliteAbstraction;

  final SqliteAbstraction _sqliteAbstraction;

  void createUser(String name) {
    _sqliteAbstraction.createUser(User(name: name, uid: Uuid().v4()));
  }
}
