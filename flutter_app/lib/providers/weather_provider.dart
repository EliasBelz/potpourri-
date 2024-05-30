import 'package:flutter/material.dart';
import 'package:flutter_app/models/weather_conditions.dart';

/// Manages weather state
class WeatherProvider extends ChangeNotifier {
  /// Temperature in fahrenheit
  int tempInFarenheit = 0;

  /// Weather condition
  WeatherCondition condition = WeatherCondition.unknown;

  /// Whether the weather has been updated
  bool weatherUpdated = false;

  /// Gets the current condition formatted as a string
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

  /// Gets the current condition formatted as an emoji
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

  /// Updates the weather
  /// parameters:
  /// newTempFarenheit (int): the new temperature in fahrenheit
  /// newCondition (WeatherCondition): the new weather condition
  updateWeather(int newTempFarenheit, WeatherCondition newCondition) {
    weatherUpdated = true;
    tempInFarenheit = newTempFarenheit;
    condition = newCondition;
    notifyListeners();
  }
}
