import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/User.dart';
import '../services/database.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AddWidget extends StatefulWidget {
  const AddWidget({Key? key}) : super(key: key);
  //list of all possible locations, add to database onPressed

  @override
  State<AddWidget> createState() => _AddWidgetState();
}


class _AddWidgetState extends State<AddWidget> {
  final List<String> widgets = <String>[
    'Cloud Coverage', 'Feels-Like', 'Humidity', 'Precipitation', 'Pressure', 'Temp Celsius', 'UV Index', 'Visibility', 'Wind Direction', 'Wind Speed',
  ];
  final _controller = TextEditingController();
  Map? data;
  var chosenWidget = '';
  List<dynamic> currentWidgetList = [];


  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final String text = _controller.text.toLowerCase();
      _controller.value = _controller.value.copyWith(
        text: text,
        selection:
        TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute
        .of(context)
        ?.settings
        .arguments as Map?;
    MyUser? myUser = Provider.of<MyUser?>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: myUser?.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;

            return Scaffold(
              appBar: AppBar(
                title: const Text("Add Widget"),
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TypeAheadField(
                      textFieldConfiguration: TextFieldConfiguration(
                        autofocus: true,
                        controller: _controller,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Search Widget...',
                        ),
                      ),
                      suggestionsCallback: (pattern) {
                        return widgets
                            .where((widget) =>
                            widget.toLowerCase().contains(pattern.toLowerCase()))
                            .toList();
                      },
                      itemBuilder: (context, suggestion) {
                        return ListTile(
                          title: Text(suggestion.toString()),
                        );
                      },
                      onSuggestionSelected: (suggestion) {
                        showDialog (
                          context: context,
                          barrierDismissible: false,
                          // user must tap button!
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Add Widget?'),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text(
                                      'Would you like to add the widget ${suggestion.toString()}',
                                      style: TextStyle(
                                          color: Colors.red[400]),
                                    ),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Yes'),
                                  onPressed: () async {
                                    chosenWidget = suggestion.toString();
                                    if (userData!.widgetList.contains(suggestion.toString())){
                                    }
                                    else{
                                      currentWidgetList = userData!.widgetList;
                                      currentWidgetList.add(chosenWidget);
                                      await DatabaseService(uid: myUser?.uid).updateUserData(
                                          userData.location, currentWidgetList);

                                    };
                                    Navigator.popUntil(context, ModalRoute.withName('/myhome'));}

                                ),
                                TextButton(
                                  child: const Text('No'),
                                  onPressed: () async{
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }
          else {
            return Container();
          }
        }
    );
  }
}