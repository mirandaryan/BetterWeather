import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';


class WeatherData {

  String location;
  String url;
  String? temp;
  String? temp_c;
  String? conditionIcon;
  String? condition;
  String? windMPH;
  String? wind_dir;
  String? humidity;
  String? precip_in;
  String? pressure_in;
  String? cloud;
  String? feelslike_f;
  String? vis_miles;
  String? uv;


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
      temp = data['current']['temp_f'].toString() + ' F';
      temp_c = data['current']['temp_c'].toString() + ' C';
      conditionIcon = data['current']['condition']['icon'];
      condition = data['current']['condition']['text'];
      windMPH = data['current']['wind_mph'].toString() + ' MPH';
      wind_dir = data['current']['wind_dir'].toString();
      humidity = data['current']['humidity'].toString()+ ' %';
      precip_in = data['current']['precip_in'].toString() + ' In';
      pressure_in = data['current']['pressure_in'].toString() + ' psi';
      cloud = data['current']['cloud'].toString() + ' %';
      feelslike_f = data['current']['feelslike_f'].toString() + ' F';
      vis_miles = data['current']['vis_miles'].toString() + ' Miles';
      uv = data['current']['uv'].toString();

    }
    catch (e) {
      print('caught error: $e');
      //temp = 'could not get data';
    }
  }
}
