import 'dart:convert';
import 'package:flutter_app/providers/weather_provider.dart';
import 'package:flutter_app/weather_conditions.dart';
import 'package:http/http.dart' as http;

class WeatherChecker {
  final WeatherProvider weatherProvider;
  double _latitude = 47.65302029352272;
  double _longitude = -122.30502699657404;

  WeatherChecker(this.weatherProvider);

  updateLocation({required double latitude, required double longitude}) {
    _latitude = latitude;
    _longitude = longitude;
  }

  fetchAndUpdateCurrentSeattleWeather() async {
    var client = http.Client();
    try {
      final gridResponse = await client.get(Uri.parse(
          'https://api.weather.gov/points/${_latitude.toString()},${_longitude.toString()}'));
      final gridParsed = (jsonDecode(gridResponse.body));
      final String? forecastURL = gridParsed['properties']?['forecast'];
      if (forecastURL == null) {
        // do nothing
      } else {
        final weatherResponse = await client.get(Uri.parse(forecastURL));
        final weatherParsed = jsonDecode(weatherResponse.body);
        final currentPeriod = weatherParsed['properties']?['periods']?[0];
        if (currentPeriod != null) {
          final temperature = currentPeriod['temperature'];
          final shortForecast = currentPeriod['shortForecast'];
          if (temperature != null && shortForecast != null) {
            final condition = _shortForecastToCondition(shortForecast);
            weatherProvider.updateWeather(temperature, condition);
          }
        }
      }
    } catch (_) {
    } finally {
      client.close();
    }
  }

  WeatherCondition _shortForecastToCondition(String shortForecast) {
    final lowercased = shortForecast.toLowerCase();
    if (lowercased.startsWith('rain')) return WeatherCondition.rainy;
    if (lowercased.startsWith('sun') || lowercased.startsWith('partly')) {
      return WeatherCondition.sunny;
    }
    return WeatherCondition.gloomy;
  }
}
