import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';


class WeatherData {

  String location;
  String url;
  String? temp;
  String? conditionIcon;
  String? condition;
  String? windMPH;
  String? humidity;

  WeatherData({required this.location, required this.url});

  // factory WeatherData.fromJson(Map<String, dynamic> json) {
  //   return WeatherData(
  //     location: json['location'] as String,
  //     url: json['url'] as String,
  //   );
  // }

  Future<void> getWeather() async {
    //make the request
    try {
      Response response = await get(Uri.parse(
          'http://api.weatherapi.com/v1/current.json?key=1839160156f14892882223935231407&q=$url&aqi=no'));
      Map data = jsonDecode(response.body);
      temp = data['current']['temp_f'].toString();
      conditionIcon = data['current']['condition']['icon'];
      condition = data['current']['condition']['text'];
      windMPH = data['current']['wind_mph'].toString();
      humidity = data['current']['humidity'].toString();
    }
    catch (e) {
      print('caught error: $e');
      //temp = 'could not get data';
    }
  }
}
