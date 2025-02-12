import 'package:demo/core/locator.dart';
import 'package:demo/core/ui/primary_button.dart';
import 'package:demo/weather/weather.dart';
import 'package:flutter/material.dart';
import 'weather_repository.dart';
import 'weather_view_model.dart';

class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  late final WeatherViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = WeatherViewModel(
      weatherRepository: locator<WeatherRepository>(),
    );
    _viewModel.fetchWeather();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      body: SafeArea(
        child: Center(
          child: ValueListenableBuilder<Weather?>(
            valueListenable: _viewModel.weatherNotifier,
            builder: (context, weather, _) {
              if (weather == null) {
                return const Text('No weather data available');
              }

              return Container(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Location selector
                    Theme(
                      data: Theme.of(context).copyWith(
                        popupMenuTheme: PopupMenuThemeData(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(13),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ValueListenableBuilder<String>(
                          valueListenable: _viewModel.selectedLocationNotifier,
                          builder: (context, selectedLocation, _) {
                            return DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: selectedLocation,
                                isExpanded: true,
                                icon: const Icon(
                                  Icons.location_on_outlined,
                                  color: Color(0xFF6B4EFF),
                                ),
                                dropdownColor: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                elevation: 8,
                                items: _viewModel.availableLocations
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: const TextStyle(
                                        color: Color(0xFF1A1A1A),
                                        fontSize: 16,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    _viewModel.updateLocation(newValue);
                                  }
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Weather info card
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 32, horizontal: 62),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(13),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            weather.location,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF1A1A1A),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${weather.temperature.toStringAsFixed(1)} c',
                            style: const TextStyle(
                              fontSize: 64,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1A1A1A),
                            ),
                          ),
                          Text(
                            weather.condition,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Color(0xFF666666),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Refresh button
                    PrimaryButton(
                      text: 'Refresh',
                      onPressed: () async {
                        await _viewModel.fetchWeather();
                      },
                      width: 160,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
