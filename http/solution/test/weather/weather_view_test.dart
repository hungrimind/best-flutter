import 'package:demo/core/http_abstraction.dart';
import 'package:demo/core/locator.dart';
import 'package:demo/weather/weather_repository.dart';
import 'package:demo/weather/weather_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeHttpAbstraction implements HttpAbstraction {
  @override
  Future<String> get(String url) async {
    // Return mock wttr.in JSON response
    return '''
    {
      "current_condition": [{
        "temp_C": "20",
        "weatherDesc": [{"value": "Sunny"}]
      }],
      "nearest_area": [{
        "areaName": [{"value": "London"}]
      }]
    }
    ''';
  }
}

void main() {
  setUp(() {
    locator.registerSingleton<HttpAbstraction>(FakeHttpAbstraction());
    locator.registerLazySingleton(
      () => WeatherRepository(http: locator<HttpAbstraction>()),
    );
  });

  tearDown(() {
    locator.reset();
  });

  testWidgets('WeatherView displays weather data', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: WeatherView(),
      ),
    );

    expect(find.text('No weather data available'), findsOneWidget,
        reason:
            'No weather data available should be displayed prior to fetching data');

    // Wait for the async operation to complete and rebuild
    await tester.pumpAndSettle();

    // Try both possible temperature formats with 'c' suffix
    expect(
      find.byWidgetPredicate((widget) {
        if (widget is Text) {
          return widget.data == '20.0 c' || widget.data == '20 c';
        }
        return false;
      }),
      findsOneWidget,
      reason: 'Temperature should be displayed',
    );

    expect(find.text('Sunny'), findsOneWidget,
        reason: 'Weather condition should be displayed');
    expect(
      find.byWidgetPredicate((widget) {
        if (widget is Text) {
          return widget.data == 'London' && widget.style?.fontSize == 24;
        }
        return false;
      }),
      findsOneWidget,
      reason: 'Location should be displayed',
    );
  });
}
