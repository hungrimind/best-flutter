import 'package:demo/weather/weather.dart';
import 'package:flutter/foundation.dart';
import 'weather_repository.dart';

class WeatherViewModel {
  WeatherViewModel({required WeatherRepository weatherRepository})
      : _weatherRepository = weatherRepository;

  final WeatherRepository _weatherRepository;
  final ValueNotifier<Weather?> weatherNotifier = ValueNotifier(null);
  final ValueNotifier<String> selectedLocationNotifier =
      ValueNotifier('London');

  // Predefined list of cities
  final List<String> availableLocations = [
    'London',
    'New York',
    'Tokyo',
    'Paris',
    'Sydney',
    'Berlin',
    'Toronto',
    'Singapore',
  ];

  Future<void> fetchWeather({String? location}) async {
    try {
      final weather = await _weatherRepository.fetchWeather(
        city: location ?? selectedLocationNotifier.value,
      );
      weatherNotifier.value = weather;
    } catch (e) {
      // maybe show an indicator of a failed request
    }
  }

  void updateLocation(String newLocation) {
    selectedLocationNotifier.value = newLocation;
    fetchWeather(location: newLocation);
  }

  void dispose() {
    weatherNotifier.dispose();
    selectedLocationNotifier.dispose();
  }
}
