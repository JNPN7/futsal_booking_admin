import 'package:flutter/material.dart';
import 'package:futsal_admin/models/user.dart';
import 'package:futsal_admin/screens/autheticate/authenticate.dart';
import 'package:futsal_admin/screens/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null){
      return Authenticate();
    }else{
      return Home();
    }
  }
}