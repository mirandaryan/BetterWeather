
import 'package:better_weather/services/weather_data.dart';
import 'package:flutter/material.dart';

class ChangeLocation extends StatefulWidget {
  const ChangeLocation({Key key}) : super(key: key);
  //list of all possible locations, add to database onPressed

  @override
  State<ChangeLocation> createState() => _ChangeLocationState();
}


class _ChangeLocationState extends State<ChangeLocation> {
  final List<String> locations = <String>['Chicago', 'Minneapolis', 'London'];
  final int listLength = 3;
  final _cityTextController = TextEditingController();

  void updateWeather(index) async {
    WeatherData instance = WeatherData(location: locations[index], url: locations[index]);
    await instance.getWeather();
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'temp': instance.temp,
      'conditionIcon': instance.conditionIcon,
      'location':instance.location
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Location"),
      ),
      body: ListView.builder(
          itemCount: locations.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
              child: Card(
                child: ListTile(
                  onTap: () {
                    updateWeather(index);
                  },
                  title: Text(locations[index],
                ),
              ),
              ),
            );
          }
      ),
    );
  }



}
//https://api.flutter.dev/flutter/widgets/ListView-class.html
//https://api.flutter.dev/flutter/material/AlertDialog-class.html