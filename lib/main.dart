import 'package:better_weather/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:better_weather/pages/home.dart';
import 'package:better_weather/pages/change_location.dart';
import 'package:better_weather/pages/add_widget.dart';
import 'package:better_weather/pages/loading.dart';
import 'package:better_weather/pages/wrapper.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:better_weather/models/User.dart';

void main() async {
      await Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
      );
      runApp(const MyApp(

      ));


}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
  }


