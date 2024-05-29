import 'package:flutter/material.dart';
import 'package:flutter_app/weather_conditions.dart';

/// Represents a provider that stores weather information
class WeatherProvider extends ChangeNotifier {
  int tempInFarenheit = 0;
  WeatherCondition condition = WeatherCondition.unknown;
  bool weatherUpdated = false;

  /// Returns a string for the current weather condition.
  get formattedCondition {
    switch (condition) {
      case WeatherCondition.gloomy:
        return 'Gloomy';
      case WeatherCondition.sunny:
        return 'Sunny';
      case WeatherCondition.rainy:
        return 'Rainy';
      case WeatherCondition.unknown:
        return 'Unknown';
    }
  }

  /// Returns emoji for the current weather condition.
  get conditionEmoji {
    switch (condition) {
      case WeatherCondition.gloomy:
        return '☁️';
      case WeatherCondition.sunny:
        return '🌞';
      case WeatherCondition.rainy:
        return '🌧️';
      case WeatherCondition.unknown:
        return '❓';
    }
  }

  /// Updates the weather with the given new temperature and new weather condition.
  updateWeather(int newTempFarenheit, WeatherCondition newCondition) {
    weatherUpdated = true;
    tempInFarenheit = newTempFarenheit;
    condition = newCondition;
    notifyListeners();
  }
}
