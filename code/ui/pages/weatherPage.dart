import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:madinati/constants.dart';
import 'package:madinati/core/models/articleList_model.dart';
import 'package:madinati/core/models/newsItem_model.dart';
import 'package:madinati/core/models/weatherForecast_model.dart';
import 'package:madinati/core/services/fetchWeather.dart';

import 'articlePage.dart';

class WeatherPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late Future<WeatherForecast> futureWeather;

  @override
  void initState() {
    super.initState();
    futureWeather = fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Expanded(
        child: FutureBuilder<WeatherForecast>(
            future: futureWeather,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data;
                return Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          "Meteo d'aujourd'hui à Rabat",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        Image.network("http:" + data!.currentIcon),
                        Text(data.currentTemp + " °C",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(
                            child: ListView.builder(
                                itemCount: data.forecast.length,
                                itemBuilder: (context, int) {
                                  return Row(
                                    children: [
                                      Text(data.forecast[int][0],
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Image.network(
                                          "http:" + data.forecast[int][2]),
                                      Text(data.forecast[int][1] + " °C"),
                                    ],
                                  );
                                }))
                      ],
                    ));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}
