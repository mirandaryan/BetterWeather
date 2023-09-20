import 'package:flutter/material.dart';
import 'package:better_weather/pages/home.dart';
import 'package:better_weather/pages/change_location.dart';
import 'package:better_weather/pages/add_widget.dart';
import 'package:better_weather/pages/loading.dart';
import 'package:better_weather/pages/wrapper.dart';

void main() => runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      //'/sign_up': (context) => const SignUp(),
      '/': (context) => Wrapper(),
      '/home': (context) => const MyHomePage(),
      '/location': (context) => const ChangeLocation(),
      '/add_widget': (context) => const AddWidget(key: null,),
      '/loading': (context) => const Loading(),
    }
));



