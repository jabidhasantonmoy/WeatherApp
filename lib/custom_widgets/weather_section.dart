import 'package:flutter/material.dart';

import '../providers/weather_provider.dart';
import '../utils/constants.dart';
import '../utils/helper_functions.dart';

Widget currentWeatherSection(WeatherProvider weatherProvider) {
  final current = weatherProvider.currentWeatherResponse;
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        Text(
          getFormattedDate(current!.dt!, pattern: 'MMM dd yyyy'),
          style: txtColorWhite54Font16Normal,
        ),
        Text(
          '${current.main!.temp!.round()}$degree${weatherProvider.tempUnitSymbol}',
          style: txtColorWhiteFontBig80,
        ),
        Text(
          'Feels like ${current.main!.feelsLike!.round()}$degree${weatherProvider.tempUnitSymbol}',
          style: txtColorWhiteFontSmall18,
        ),
        Image.network('$iconPrefix${current.weather![0].icon}$iconSuffix'),
        Text(
          current.weather![0].description!,
          style: txtColorWhiteFont16Normal,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Wrap(
            children: [
              Text(
                'Humidity ${current.main!.humidity}%  ',
                style: txtColorWhite54Font16Normal,
              ),
              Text(
                'Pressure ${current.main!.pressure} hPa  ',
                style: txtColorWhite54Font16Normal,
              ),
              Text(
                'Wind ${current.wind!.speed} m/s  ',
                style: txtColorWhite54Font16Normal,
              ),
              Text(
                'Wind Degree ${current.wind!.deg}$degree  ',
                style: txtColorWhite54Font16Normal,
              ),
              Text(
                'Visibility ${current.visibility} meter  ',
                style: txtColorWhite54Font16Normal,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Wrap(
            children: [
              Text(
                'Sunrise ${getFormattedDate(current.sys!.sunrise!, pattern: weatherProvider.timePattern)}  ',
                style: txtColorWhiteFont16Normal,
              ),
              Text(
                'Sunset ${getFormattedDate(current.sys!.sunset!, pattern: weatherProvider.timePattern)}  ',
                style: txtColorWhiteFont16Normal,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
