import 'package:flutter/material.dart';

class GridBuilder extends StatefulWidget {


  const GridBuilder({Key key});
  @override
  GridBuilderState createState() => GridBuilderState();
}

class GridBuilderState extends State<GridBuilder> {
  //final List<Map> myProducts =
  //List.generate(100000, (index) => {"id": index, "name": "Product $index"})
     // .toList();

  List<String> userWidgets = ["temp"];
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;

    //builds grid of widgets UI
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        margin: EdgeInsets.all(10.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 1/ 1,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        itemCount: userWidgets.length,
        itemBuilder: (BuildContext ctx, index) {
          return GestureDetector(
            onLongPress: (){
              showDialog<void>(
                context: context,
                barrierDismissible: false, // user must tap button!
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Delete'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text('Would you like to delete the ${userWidgets.elementAt(index)} widget?',
                            style: TextStyle(color: Colors.red[400]),
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Yes'),
                        onPressed: () {
                          userWidgets.removeAt(index);
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
                  color:Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0,1),
                    ),
                  ],
                  // border: Border.all(
                  //   color: Colors.blue[200]
                  // ),
                  borderRadius: const BorderRadius.all(Radius.circular(20))
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ListTile(
                    title: Center(child: Text(userWidgets.elementAt(index),
                      style: const TextStyle(
                        fontSize: 30.0,
                      ),
                      ),
                    ),
                    subtitle: Center(
                      child: Text(data[userWidgets.elementAt(index)]),
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
}
//https://blog.logrocket.com/how-to-create-a-grid-list-in-flutter-using-gridview/