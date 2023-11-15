import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final CollectionReference weatherInfoCollection = FirebaseFirestore.instance.collection('weatherInfo');
  final String uid;
  DatabaseService({required this.uid});

  Future updateUserData(String location, List<String> widgetList) async{
    return await weatherInfoCollection.doc(uid).set({
      'location' : location,
      'widgetList': widgetList
    });
  }
}