import 'package:get_it/get_it.dart';
import 'date_service.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => DateService());
}
