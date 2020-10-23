import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:futsal_admin/models/user.dart';

class AdminService{
  final uid;
  AdminService({this.uid});

  //collection reference
  final CollectionReference userCollection = Firestore.instance.collection('futsalOwner');

  // set UserData
  Future setAdminData(String futsalId, String futsalname, String location, String price, bool isParkingAvailable, bool isCafeteriaAvailable, Map<String, dynamic> contacts, Map<String, double> latlong) async{
    try{
      return await userCollection.document(uid).setData({
        'futsalId': futsalId,
        'futsalName': futsalname,
        'contacts': contacts,
        'locationName': '${location[0].toUpperCase()}${location.substring(1).toLowerCase()}',
        'latlong': latlong,
        'price': price,
        'bookingsTime': null,
        'cafeteria': isCafeteriaAvailable,
        'parking': isParkingAvailable, 
      }
      );
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  UserData _userdatafromsnapshot(DocumentSnapshot snapshot){ 
    // snapshot == null ? print('isNull') : print('isNot Null');
    print('------------');
    try{ 
      return UserData(
        uid: uid,
        futsalName: snapshot.data['name'],
        location: snapshot.data['location'],
        price: snapshot.data['price'],
        isParkingAvailable: snapshot.data['isParkingAvailable'],
        isCafeteriaAvailable: snapshot.data['isCafeteriaAvailable'],
        contacts: snapshot.data['contacts']
      );
    }catch(e){
      return null;
    }
  }
  Future getData() async{
    try{
      return userCollection.document(uid).get().then((doc){
        if(doc.documentID.length > 0){
          return _userdatafromsnapshot(doc);
        }else{
          return null;
        }
    });
    }catch(e){
      print(e);
      return null;
    }
  }
}