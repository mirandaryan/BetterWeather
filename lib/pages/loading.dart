import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:better_weather/services/weather_data.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String temp = 'loading';

  void setupWeatherData() async {
    WeatherData instance = WeatherData(location: 'london', url: 'london');
    await instance.getWeather();
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'temp': instance.temp,
      'conditionIcon': instance.conditionIcon,
      'condition': instance.condition,
      'location':instance.location,
      'windMPH':instance.windMPH,
      'humidity':instance.humidity
    });
  }

  @override
  void initState() {
    super.initState();
    setupWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: EdgeInsets.all(50.0),
          child: Text(temp),
        ),
    );
  }
}