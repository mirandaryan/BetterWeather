import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:better_weather/services/weather_data.dart';
import 'package:provider/provider.dart';

import '../models/User.dart';
import '../services/database.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String temp = 'loading';
  String location = 'london';
  List<String> userWidgetList = [''];



  void setupWeatherData() async {
    WeatherData instance = WeatherData(location: location, url: location);

    await instance.getWeather();

    Navigator.pushReplacementNamed(context, '/myhome', arguments: {
      'Location': instance.location,
      'Temp' : instance.temp,
      'Temp Celsius' : instance.temp,
      'conditionIcon' : instance.conditionIcon,
      'Condition' : instance.condition,
      'Wind Speed' : instance.windMPH,
      'Wind Direction' : instance.wind_dir,
      'Humidity' : instance.humidity,
      'Precipitation' : instance.precip_in,
      'Pressure' : instance.pressure_in,
      'Cloud Coverage' : instance.cloud,
      'Feels-Like' : instance.feelslike_f,
      'Visibility' : instance.vis_miles,
      'UV Index' : instance.uv,


    });
  }

  @override
  void initState() {
    super.initState();
    print('1');

  }

  @override
  Widget build(BuildContext context) {
    MyUser? myUser = Provider.of<MyUser?>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: myUser?.uid).userData,
    builder: (context,snapshot) {
    if (snapshot.hasData) {
    UserData? userData = snapshot.data;
    location = userData!.location;
    setupWeatherData();
        return Container(
          child: Center(
            child: SpinKitChasingDots(
              color: Colors.blue,
              size: 50.0,
            ),
          ),
        );
      }
      else{ return Container();
      }
    }
    );
  }
}