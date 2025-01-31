import 'package:demo/database_abstraction.dart';
import 'package:demo/user_service.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => DatabaseAbstraction());

  locator.registerLazySingleton(
    () => UserService(
      databaseAbstraction: locator.get<DatabaseAbstraction>(),
    ),
  );
}
