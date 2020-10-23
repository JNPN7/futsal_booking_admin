class User{
  final String uid;
  final bool isAnon;
  User({this.uid, this.isAnon});
}

class UserData{
  final String uid;
  String futsalName;
  String location; 
  String price;
  bool isParkingAvailable;
  bool isCafeteriaAvailable;
  Map<String, dynamic> contacts;
  UserData({this.uid, this.futsalName, this.location, this.price, this.isParkingAvailable, this.isCafeteriaAvailable, this.contacts});
}

class ListofAdmin{
  List listofAdmin;
  ListofAdmin({this.listofAdmin});
}