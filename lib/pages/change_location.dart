import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/User.dart';
import '../services/database.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../shared/loading.dart';

class ChangeLocation extends StatefulWidget {
  const ChangeLocation({Key? key}) : super(key: key);
  //list of all possible locations, add to database onPressed

  @override
  State<ChangeLocation> createState() => _ChangeLocationState();
}


class _ChangeLocationState extends State<ChangeLocation> {
  final _controller = TextEditingController();
  String location = '';
  Map? data;
  static const List<String> _cities = <String>[
    'Amsterdam','Chicago', 'New York', 'London', 'Paris',

  ];

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
    data = ModalRoute.of(context)?.settings.arguments as Map?;
    MyUser? myUser = Provider.of<MyUser?>(context);

  return StreamBuilder<UserData>(
        stream: DatabaseService(uid: myUser?.uid).userData,
    builder: (context,snapshot) {
    if (snapshot.hasData) {
      UserData? userData = snapshot.data;
      return Scaffold(
        appBar: AppBar(
          title: const Text("Change Location"),
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
                    hintText: 'Search City...',
                  ),
                ),
                suggestionsCallback: (pattern) {
                  return _cities
                      .where((city) => city.toLowerCase().contains(pattern.toLowerCase()))
                      .toList();
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text(suggestion.toString()),
                  );
                },
                onSuggestionSelected: (suggestion) {
                  // Handle when a suggestion is selected.
                  showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    // user must tap button!
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Change Location?'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text(
                                'Would you like to change your location to ${suggestion.toString()}',
                                style: TextStyle(
                                    color: Colors.red[400]),
                              ),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Yes'),
                            onPressed: () async{
                              _controller.text = suggestion.toString();
                              await DatabaseService(uid: myUser?.uid).updateUserData(
                                  _controller.text, userData!.widgetList
                              );
                              Navigator.pushNamed(context, '/loading');
                            },
                          ),
                          TextButton(
                            child: const Text('No'),
                            onPressed: () {
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
