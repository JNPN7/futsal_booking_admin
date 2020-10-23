import 'package:firebase_auth/firebase_auth.dart';
import 'package:futsal_admin/models/user.dart';
import 'package:futsal_admin/services/admindatabase.dart';
import 'package:futsal_admin/services/listofAdmin.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // user based in firebase user
  User _userfromFirebaseUser(FirebaseUser user){
    // chech wether sign in is anonymous or not
    bool isAnon = true;
    if (user != null){
      if (user.email != null){
        isAnon  = false;
      }
    }
    return user != null ? User(uid: user.uid, isAnon: isAnon) : null;
  }

  Stream<User> get user{
    return _auth.onAuthStateChanged
      .map((FirebaseUser user) => _userfromFirebaseUser(user));
  }


  // register with email and password
  Future registerWithEmailAndPassword(String email, String password, String futsalname, String location, String price, bool isParkingAvailable, bool isCafeteriaAvailable, Map<String, dynamic> contacts, Map<String, double> latlong) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      //creates new documents for new user with user id
      await AdminService(uid: user.uid).setAdminData(user.uid, futsalname, location, price, isParkingAvailable, isCafeteriaAvailable, contacts, latlong);
      await ListofAdminService().updateAdminData(user.uid);
      return _userfromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // signin with email and password
  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userfromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}