import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/forecast_weather_response.dart';

import '../models/current_weather_response.dart';
import '../utils/constants.dart';

class WeatherProvider extends ChangeNotifier {
  CurrentWeatherResponse? currentWeatherResponse;
  ForecastWeatherResponse? forecastWeatherResponse;
  double latitude = 0.0;
  double longitude = 0.0;
  String tempUnit = metric;
  String tempUnitSymbol = celsius;
  String timePattern = timePatternAmPm;

  void getData() {
    _getCurrentWeatherData();
    _getForecastWeatherData();
  }

  bool get hasDataLoaded =>
      currentWeatherResponse != null && forecastWeatherResponse != null;

  Future<void> _getCurrentWeatherData() async {
    final urlString =
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&units=$tempUnit&appid=$weatherApiKey';
    try {
      final response = await http.get(Uri.parse(urlString));
      final map = json.decode(response.body);
      if (response.statusCode == 200) {
        currentWeatherResponse = CurrentWeatherResponse.fromJson(map);
        notifyListeners();
      } else {
        print(map['message']);
      }
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> _getForecastWeatherData() async {
    final urlString =
        'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&units=$tempUnit&appid=$weatherApiKey';
    try {
      final response = await http.get(Uri.parse(urlString));
      final map = json.decode(response.body);
      if (response.statusCode == 200) {
        forecastWeatherResponse = ForecastWeatherResponse.fromJson(map);
        notifyListeners();
      } else {
        print(map['message']);
      }
    } catch (error) {
      print(error.toString());
    }
  }
}
