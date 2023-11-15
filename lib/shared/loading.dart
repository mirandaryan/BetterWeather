import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  String location = 'london';

  void setupWeatherData() async {
    WeatherData instance = WeatherData(location: 'london', url: 'london');

    await instance.getWeather();
    print('3');
    print(instance.temp);
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': instance.location,
      'temp' : instance.temp,
      'conditionIcon' : instance.conditionIcon,
      'condition' : instance.condition,
      'wind mph' : instance.windMPH,
      'humidity' : instance.humidity

    });
  }

  @override
  void initState() {
    super.initState();
    print('1');
    setupWeatherData();
    print('2');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown[100],
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.brown,
          size: 50.0,
        ),
      ),
    );
  }
}