import 'package:flutter/material.dart';
import 'package:futsal_admin/imports/constants.dart';
import 'package:futsal_admin/imports/loading.dart';
import 'package:futsal_admin/models/user.dart';
import 'package:futsal_admin/services/auth.dart';
import 'package:futsal_admin/services/listofAdmin.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey =  GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  String email;
  String password;
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      body: Stack(
        children: <Widget>[
          signInBackground('Welcome Back,', 'Log In!'), //decoration text for sign in
          SizedBox(height: 50,),
          signInForm(widget.toggleView),
        ],
      ),
    );
  }
 
  //sign in form
  Widget signInForm(Function toogleView){
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 300, left: 30, right: 30),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: inputDecoration.copyWith(labelText: 'Email'),
                validator: (val) => val.isEmpty ? 'Please enter your email' : null,
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                decoration: inputDecoration.copyWith(labelText: 'Password'),
                validator: (val) => val.isEmpty ? 'Please enter your password' : null,
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
              ),
              SizedBox(height: 30),
              SizedBox(
                width: 200,
                child: RaisedButton(
                  color: Color(0XFF00ff00),
                  onPressed: () async{
                    if(_formKey.currentState.validate()){
                      setState(() => loading = true);
                      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                      // print(result.uid);
                      // dynamic res =  await AdminService(uid: result.uid).getData();
                      // print(res);
                      // await _auth.signOut();
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => Hidden()),
                      // );

                      if (result == null){
                        print("Couldn't Sign in");
                        setState(() {
                          error = 'Please enter valid credentials';
                          loading = false;
                        });
                      }else{
                        ListofAdmin res =  await ListofAdminService().getData();
                        if ( !res.listofAdmin.contains(result.uid) ){
                          await _auth.signOut();
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => Hidden()),
                          // );
                        }
                      }
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('Log In'),
                ),
              ),
              SizedBox(height: 5,),
              Text(error, style: TextStyle(color: Colors.red),),
              SizedBox(height: 75,),
              Text("Don't have an Account?"),
              GestureDetector(
                onTap: (){
                  toogleView();
                },
                child: Text(
                  'Create Account', 
                  style:TextStyle(color: Colors.lightGreen, decoration: TextDecoration.underline,)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}