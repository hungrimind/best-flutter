import 'package:demo/core/http_abstraction.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import '../weather/weather_repository.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => HttpAbstraction(client: Client()));
  locator.registerLazySingleton(
    () => WeatherRepository(http: locator<HttpAbstraction>()),
  );
}
