import 'package:flutter/material.dart';


class WeatherCard extends StatefulWidget {
  const WeatherCard({Key key}) : super(key: key);

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;

    //builds weather card UI
    return Container(
      height: 200.0,
      padding: const EdgeInsets.all(20.0),
      margin: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color:Colors.white,
        boxShadow: [
      BoxShadow(
      color: Colors.grey.withOpacity(0.3),
      spreadRadius: 1,
      blurRadius: 2,
      offset: const Offset(0,1),
      ),
        ],
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ListTile(
            leading: Image(image: NetworkImage(data['conditionIcon']),),
            title: Center(
              child: Text(
                data['temp'],
                style: TextStyle(
                  fontSize: 80.0,
                ),
              ),
            ),
            subtitle: Center(
              child: Text(data['location'] + 'Rain', style: TextStyle(fontSize: 20.0),),
            ),
          ),
        ],

      ),

          );
  }
}
// https://api.flutter.dev/flutter/widgets/ListView-class.html