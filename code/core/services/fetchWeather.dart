import 'dart:convert';

import 'package:madinati/constants.dart';
import 'package:madinati/core/models/locationPost_model.dart';
import 'package:http/http.dart' as http;
import 'package:madinati/core/models/weatherForecast_model.dart';

Future<WeatherForecast> fetchWeather() async {
  final response = await http.get(Uri.parse(
      'http://api.weatherapi.com/v1/forecast.json?key=fcdd7b7e159349f089c141937222901%20&q=Rabat&days=7&aqi=no&alerts=no'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return WeatherForecast.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load weather');
  }
}
