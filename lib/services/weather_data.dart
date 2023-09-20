import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';


class WeatherData {

  String location;
  String temp;
  String condition;
  String conditionIcon;
  double windMPH;
  String windDirection;
  double precipitation;
  int humidity;
  int cloudCoverage;
  double feelsLike;
  double visibility;
  double uv;
  int epaIndex;
  String url;

  WeatherData({this.location, this.url});

  Future<void> getWeather() async {
    //make the request
    try {
      Response response = await get(Uri.parse(
          'http://api.weatherapi.com/v1/current.json?key=1839160156f14892882223935231407&q=$url&aqi=no'));
      Map data = jsonDecode(response.body);

      temp = data['current']['temp_f'].toString();
      conditionIcon = data['current']['condition']['icon'];
    }
    catch (e) {
      print('caught error: $e');
      temp = 'could not get data';
    }
  }
}
