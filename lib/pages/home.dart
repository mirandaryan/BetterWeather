import 'package:flutter/material.dart';
import 'package:better_weather/weather_card.dart';
import 'package:better_weather/pages/grid_builder.dart';
enum Menu { location, add_widget }

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}): super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".



  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final String title = 'Better Weather';
  String route = '';
  List<String> userWidgets = <String>[];



  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: const Text("Better Weather"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: const [
            WeatherCard(),
            Flexible(
              child: GridBuilder(),
            )
          ],
        ),
       ),

      drawer: Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        ListTile(
          title: const Text('Change Location'),
          onTap: () {
            // Update the state of the app
            // ...
            // Then close the drawer
            Navigator.pushNamed(context, '/location');
          },
        ),
        ListTile(
          title: const Text('Add Widget'),
          onTap: () {
            // Update the state of the app
            // ...
            // Then close the drawer
            Navigator.pushNamed(context, '/add_widget');

          },
        ),
      ],
    ),
      ),

    );
  }


}
//https://api.flutter.dev/flutter/material/PopupMenuButton-class.html
//https://docs.flutter.dev/cookbook/design/drawer
//https://docs.flutter.dev/cookbook/effects/drag-a-widget
