import 'package:flutter/material.dart';
import 'package:futsal_admin/services/auth.dart';
// import 'package:futsal_admin/screens/home.dart';
import 'package:futsal_admin/wrapper.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
