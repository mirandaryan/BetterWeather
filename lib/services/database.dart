import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:better_weather/models/User.dart';


class DatabaseService {

  final CollectionReference weatherInfoCollection = FirebaseFirestore.instance.collection('weatherInfo');
  final String? uid;
  DatabaseService({this.uid});

  Future<void> updateUserData(String location, List<dynamic> widgetList) async{
    return await weatherInfoCollection.doc(uid).set({
      'location' : location,
      'widgetList': widgetList
    });
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return UserData(
        uid: uid,
        location: data['location'],
        widgetList: data['widgetList'],
    );
  }

  Stream<UserData> get userData {
    return weatherInfoCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

}