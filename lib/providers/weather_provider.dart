import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/current_weather_response.dart';
import '../utils/constants.dart';

class WeatherProvider extends ChangeNotifier {
  CurrentWeatherResponse? currentWeatherResponse;
  double latitude = 0.0;
  double longitude = 0.0;
  String tempUnit = metric;

  void getData() {
    _getCurrentWeatherData();
  }

  bool get hasDataLoaded => currentWeatherResponse != null;

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
}
