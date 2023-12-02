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
  late List<dynamic> widgetList;



  void setupWeatherData() async {
    WeatherData instance = WeatherData(location: location, url: location);

    await instance.getWeather();
    print('3');
    print(instance.temp);
    String current;
    Navigator.pushReplacementNamed(context, '/myhome', arguments: {
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
    MyUser? myUser = Provider.of<MyUser?>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: myUser?.uid).userData,
    builder: (context,snapshot) {
      if (snapshot.hasData) {
        UserData? userData = snapshot.data;
        location = userData!.location;
        for (var i = 0; i <= userData.widgetList.length; i++) {
          widgetList.add(userData.widgetList.elementAt(i));
        }

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
      else{ return Container();
      }
    }
    );
  }
}