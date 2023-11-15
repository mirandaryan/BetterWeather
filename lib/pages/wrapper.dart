import 'package:better_weather/pages/authenticate.dart';
import 'package:better_weather/pages/home.dart';
import 'package:better_weather/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/User.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser?>(context);
    print(user);

    if (user == null){
      return Authenticate();
    } else {
      return Loading();
    }

    // return either the Home or Authenticate widget

  }
}