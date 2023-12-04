import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:better_weather/services/database.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:better_weather/pages/home.dart';

import '../models/User.dart';
import '../shared/loading.dart';

class GridBuilder extends StatefulWidget {
  const GridBuilder({Key? key}) : super(key: key);



  @override
  GridBuilderState createState() => GridBuilderState();
}

class GridBuilderState extends State<GridBuilder> {

  String location = '';
  Map? data;

  @override
  Widget build(BuildContext context) {
   data = ModalRoute.of(context)?.settings.arguments as Map?;
   MyUser? myUser = Provider.of<MyUser?>(context);
   List<dynamic>? currentWidgetList;

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: myUser?.uid).userData,
        builder: (context,snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            currentWidgetList = userData?.widgetList;
            return Expanded(
              child: Container(
                  height: 100,
                  padding: const EdgeInsets.all(10.0),
                  margin: EdgeInsets.all(10.0),
                  child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 150,
                          childAspectRatio: 1 / 1,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20),
                      itemCount: userData?.widgetList.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return GestureDetector(
                          onLongPress: () {
                            showDialog<void>(
                              context: context,
                              barrierDismissible: false,
                              // user must tap button!
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Delete'),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        Text(
                                          'Would you like to delete the ${userData?.widgetList.elementAt(index)} widget?',
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
                                        currentWidgetList?.removeAt(index);
                                        await DatabaseService(uid: myUser?.uid).updateUserData(
                                          userData?.location ?? snapshot.data!.location,
                                          currentWidgetList ?? snapshot.data!.widgetList
                                        );

                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },

                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                                // border: Border.all(
                                //   color: Colors.blue[200]
                                // ),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20))
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ListTile(
                                  title: Center(
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                    child: Text(

                                      userData?.widgetList.elementAt(index),
                                      style: const TextStyle(
                                        fontSize: 15.0,
                                      ),
                                      ),
                                    ),
                                  ),
                                  subtitle: Center(
                                    child: Text(
                                        data?[userData?.widgetList.elementAt(index)]),
                                  ),
                                ),
                              ],

                            ),


                          ),


                        );
                      })
              ),
            );
          }
          else {
            return Container(

            );
          }
        }
    );
  }
}
