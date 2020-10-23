import 'package:flutter/material.dart';
// import 'package:futsal_admin/screens/drashboard.dart';
// import 'package:futsal_admin/screens/menu.dart';
import 'package:futsal_admin/services/auth.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService(); 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          IconButton(         
            onPressed: () async{
              await _auth.signOut();
              
              // print(result);
            },
            icon: Icon(Icons.security), 
          )
        ],
      ),
    );
  }
}

// class Home extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         Menu(),
//         Drashboard(),

//       ],
//     );
//   }
// }