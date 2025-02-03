class Weather {
  final double temperature;
  final String condition;
  final String location;

  Weather({
    required this.temperature,
    required this.condition,
    required this.location,
  });

  factory Weather.fromWttrIn(Map<String, dynamic> json) {
    // wttr.in returns temperature in both Celsius and Fahrenheit
    // We'll use Celsius which is the first number
    final tempStr = json['current_condition'][0]['temp_C'];
    final weatherDesc = json['current_condition'][0]['weatherDesc'][0]['value'];
    final location = json['nearest_area'][0]['areaName'][0]['value'];

    return Weather(
      temperature: double.parse(tempStr),
      condition: weatherDesc,
      location: location,
    );
  }
}