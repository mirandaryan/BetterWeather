

class MyUser {

  final String uid;

  MyUser({required this.uid});

}

class UserData {
  final String? uid;
  final String location;
  final List<dynamic> widgetList;

  UserData({required this.location, required this.widgetList, required this.uid});
}