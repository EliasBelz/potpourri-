import 'package:flutter/material.dart';
import 'package:flutter_app/weather_conditions.dart';

class WeatherProvider extends ChangeNotifier {
  int tempInFarenheit = 0;
  WeatherCondition condition = WeatherCondition.unknown;
  bool weatherUpdated = false;

  updateWeather(int newTempFarenheit, WeatherCondition newCondition){
    weatherUpdated = true;
    tempInFarenheit = newTempFarenheit;
    condition = newCondition;
    notifyListeners();
  }
}