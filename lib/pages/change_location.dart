
import 'package:better_weather/services/weather_data.dart';
import 'package:flutter/material.dart';

class ChangeLocation extends StatefulWidget {
  const ChangeLocation({Key? key}) : super(key: key);
  //list of all possible locations, add to database onPressed

  @override
  State<ChangeLocation> createState() => _ChangeLocationState();
}


class _ChangeLocationState extends State<ChangeLocation> {
  final List<String> locations = <String>['Chicago', 'Minneapolis', 'London'];
  final int listLength = 3;
  final _cityTextController = TextEditingController();
  String location = '';


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
                    onTap: () {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Change Location'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text('Would you like to change your loction to ${locations.elementAt(index)} ?'),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                  child: const Text('Yes'),
                                  onPressed: () async{
                                    location = locations.elementAt(index);
                                  }
                                //Navigator.pop(context, userWidgets);
                              ),
                            ],
                          );
                        },
                      );
                      //add widget to userdata
                      //return to home and reload
                    };
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