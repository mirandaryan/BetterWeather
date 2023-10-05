import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:better_weather/pages/home.dart';
import 'package:better_weather/pages/change_location.dart';
import 'package:better_weather/pages/add_widget.dart';
import 'package:better_weather/pages/loading.dart';
import 'package:better_weather/pages/wrapper.dart';
import 'firebase_options.dart';

void main() async {
      await Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
      );
      runApp(MaterialApp(
          initialRoute: '/',
          routes: {
                //'/sign_up': (context) => const SignUp(),
                '/': (context) => Wrapper(),
                '/home': (context) => const MyHomePage(),
                '/location': (context) => ChangeLocation(),
                '/add_widget': (context) => AddWidget(),
                '/loading': (context) => const Loading(),
          }
      ));
}



