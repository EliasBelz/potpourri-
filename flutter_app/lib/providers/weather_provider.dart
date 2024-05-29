import 'package:flutter/material.dart';
import 'package:flutter_app/weather_conditions.dart';

class WeatherProvider extends ChangeNotifier {
  int tempInFarenheit = 0;
  WeatherCondition condition = WeatherCondition.unknown;
  bool weatherUpdated = false;

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

  updateWeather(int newTempFarenheit, WeatherCondition newCondition) {
    weatherUpdated = true;
    tempInFarenheit = newTempFarenheit;
    condition = newCondition;
    notifyListeners();
  }
}
