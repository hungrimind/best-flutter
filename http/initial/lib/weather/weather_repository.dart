import 'dart:convert';
import 'dart:io';
import 'package:demo/core/http_abstraction.dart';
import 'package:demo/weather/weather.dart';

class WeatherRepository {
  WeatherRepository({required HttpAbstraction http}) : _http = http;

  final HttpAbstraction _http;
  static const baseUrl = 'https://wttr.in';

  Future<Weather> fetchWeather({
    String city = 'London', // Default city
  }) async {
    final response = await _http.get('$baseUrl/$city?format=j1');
    final json = jsonDecode(response);
    
    if (json != null) {
      throw UnimplementedError('We should parse the json response from the request');
    } else {
      throw HttpException('Failed to load weather data');
    }
  }
}
