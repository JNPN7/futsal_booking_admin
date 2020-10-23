import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:futsal_admin/models/user.dart';
// import 'package:futsal_admin/models/user.dart';

class ListofAdminService{
  //collection reference
  final CollectionReference listofAdminCollection = Firestore.instance.collection('OwnerList');

  // set UserData
  Future updateAdminData(String uid) async{
    try{
      ListofAdmin listofAdmin = await getData();
      List list = listofAdmin.listofAdmin;
      list.add(uid);
      // print(list);
      return await listofAdminCollection.document('OwnerList').updateData({
        'OwnerList': list,
      });
    }catch(e){
      print(e.toString());
      return null;
    }
  }


  Future getData() async{
    try{
      return await listofAdminCollection.document('OwnerList').get().then((doc) {
        return ListofAdmin(listofAdmin: doc.data['OwnerList']);
      });
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}