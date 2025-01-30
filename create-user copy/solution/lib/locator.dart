import 'package:demo/sqlite_abstraction.dart';
import 'package:demo/user_service.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => SqliteAbstraction());

  locator.registerLazySingleton(
    () => UserService(
      sqliteAbstraction: locator.get<SqliteAbstraction>(),
    ),
  );
}
