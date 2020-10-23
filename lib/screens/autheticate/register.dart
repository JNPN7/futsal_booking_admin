import 'package:flutter/material.dart';
import 'package:futsal_admin/imports/constants.dart';
import 'package:futsal_admin/imports/loading.dart';
import 'package:futsal_admin/imports/location.dart';
import 'package:futsal_admin/services/auth.dart';
import 'package:geolocator/geolocator.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKeyform_1 =  GlobalKey<FormState>();
  final _formKeyformContacts =  GlobalKey<FormState>();
  final _formKeyformFeatures =  GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  List<bool> isSelectedParking = [false, false];
  List<bool> isSelectedCafeteria = [false, false];
  String error = '';
  String errorLoc = '';
  String email = '';
  String password = '';
  String futsalName = '';
  String location = '';
  Map<String,double> latlong;
  String primaryPhoneNo = '';
  String primaryName = '';
  String secondaryPhoneNo;
  String secondaryName;
  String price = '';
  bool isParkingAvailable;
  bool isCafeteriaAvailable;

  bool loading = false;
  bool loadingNotFullScreen = false;
  bool gotLocation = false;


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      body: Stack(
        children: <Widget>[
          signInBackground('Hello,', 'Sign Up!'), //decoration text for sign in
          SizedBox(height: 50,),
          registerForm(widget.toggleView),
        ],
      ),
    );
  }

  Widget registerForm(Function toggleView){
    PageController _pageController = PageController();
    void onTap(int index){
      _pageController.animateToPage(index, duration: Duration(milliseconds: 1000), curve: Curves.easeInOutCubic);
      // _pageController.jumpToPage(index);
    }
    List<Widget> _screen = [
      form_1(toggleView, onTap), formContacts(onTap), formFeatures(onTap), formLatLong(onTap)
      // Container(color: Colors.red,),Container(color: Colors.black,)
    ];
    
    return PageView(
      pageSnapping: true,
      controller: _pageController,
      children: _screen,
      physics: NeverScrollableScrollPhysics(),
    );
  }

  Widget form_1(Function toggleView, Function onTap){
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 250, left: 30, right: 30),
        child: Form(
          key: _formKeyform_1,
          child: Column(
            children: [
              TextFormField(
                initialValue: futsalName,
                textCapitalization: TextCapitalization.sentences,
                decoration: inputDecoration.copyWith(labelText: 'Futsal Name'),
                validator: (val) => val.isEmpty ? 'Please enter Name' : null,
                onChanged: (val) {
                  setState(() {
                    futsalName = val;
                  });
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                initialValue: location,
                textCapitalization: TextCapitalization.sentences,
                decoration: inputDecoration.copyWith(labelText: 'District'),
                validator: (val) => val.isEmpty ? 'Please enter District' : null,
                onChanged: (val) {
                  setState(() {
                    location = val;
                  });
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                initialValue: email,
                decoration: inputDecoration.copyWith(labelText: 'Email'),
                validator: (val) => val.isEmpty ? 'Please enter email' : null,
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                initialValue: password,
                obscureText: true,
                decoration: inputDecoration.copyWith(labelText: 'Password'),
                validator: (val) => (val.length < 6) ? 'Password is weak. Must be more than 6 charecter' : null,
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
              ),
              SizedBox(height: 30),
              Align(
                alignment: Alignment.bottomRight,
                child: RaisedButton(
                  color: Color(0XFF00ff00),
                  onPressed: () async{
                    if(_formKeyform_1.currentState.validate()){
                      onTap(1);
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('Next'),
                ),
              ),
              SizedBox(height: 5,),
              Text(error, style: TextStyle(color: Colors.red),),
              SizedBox(height: 10,),
              Text("Already have an Account?"),
              GestureDetector(
                onTap: (){
                  toggleView();
                },
                child: Text('Log In', 
                  style:TextStyle(color: Colors.lightGreen, decoration: TextDecoration.underline,)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget formContacts(Function onTap){
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 250, left: 30, right: 30),
        child: Form(
          key: _formKeyformContacts,
          child: Column(
            children: [
              Text('Contacts', style: TextStyle(fontSize: 30, color: Color(0XFF00ff00), fontWeight: FontWeight.bold) ),
              SizedBox(height: 20,),
              Align(
                alignment: Alignment.topLeft,
                child: Text('Primary Contacts', style: TextStyle(fontSize: 15))
              ),
              SizedBox(height: 5,),
              TextFormField(
                initialValue: primaryName,
                textCapitalization: TextCapitalization.sentences,
                decoration: inputDecoration.copyWith(labelText: 'Name'),
                validator: (val) => val.isEmpty ? 'Please enter Name' : null,
                onChanged: (val) {
                  setState(() {
                    primaryName = val;
                  });
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                initialValue: primaryPhoneNo,
                keyboardType: TextInputType.number,
                decoration: inputDecoration.copyWith(labelText: 'Phone no'),
                validator: (val) { 
                  final isDigitsOnly = int.tryParse(val);
                  if(isDigitsOnly != null && val.length == 10){
                    return null;
                  }else{
                    return 'Please enter Valid Phone no';
                  }
                },
                onChanged: (val) {
                  setState(() {
                    primaryPhoneNo = val;
                  });
                },
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.topLeft,
                child: Text('Secondary Contacts(optional)', style: TextStyle(fontSize: 15))
              ),
              SizedBox(height: 5,),
              TextFormField(
                initialValue: secondaryName,
                textCapitalization: TextCapitalization.sentences,
                decoration: inputDecoration.copyWith(labelText: 'Name'),
                // validator: (val) => val.isEmpty ? 'Please enter Name' : null,
                onChanged: (val) {
                  setState(() {
                    secondaryName = val;
                  });
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                initialValue: secondaryPhoneNo,
                keyboardType: TextInputType.number,
                decoration: inputDecoration.copyWith(labelText: 'Phone no'),
                validator: (val) {
                  final isDigitsOnly = int.tryParse(val);
                  if(val == '' || (isDigitsOnly != null && val.length == 10)){
                    return null;
                  }else{
                    return 'Please enter Valid Phone no';
                  }
                },
                onChanged: (val) {
                  setState(() {
                    secondaryPhoneNo = val;
                  });
                },
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      onTap(0);
                    },
                    child: Text('Go Back', 
                      style:TextStyle(color: Colors.lightGreen, decoration: TextDecoration.underline,)
                    ),
                  ),
                  RaisedButton(
                    color: Color(0XFF00ff00),
                    onPressed: () async{
                      if(_formKeyformContacts.currentState.validate()){
                        onTap(2);
                      }
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('Next'),
                  ),
                ]
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget formFeatures(Function onTap){
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 250, left: 30, right: 30),
        child: Form(
          key: _formKeyformFeatures,
          child: Column(
            children: [
              Text('Information', style: TextStyle(fontSize: 30, color: Color(0XFF00ff00), fontWeight: FontWeight.bold) ),
              SizedBox(height: 20,),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: inputDecoration.copyWith(labelText: 'Price'),
                validator: (val) { 
                  final isDigitsOnly = int.tryParse(val);
                  if(isDigitsOnly != null){
                    return null;
                  }else{
                    return 'Please enter Valid Phone no';
                  }
                },
                onChanged: (val) {
                  setState(() {
                    price = val;
                  });
                },
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.topLeft,
                child: Text('Is Parking Available?', style: TextStyle(fontSize: 15))
              ),
              SizedBox(height: 10),
              ToggleButtons(
                isSelected: isSelectedParking,
                // selectedColor: Colors.green,
                fillColor: Colors.green[200],
                onPressed: (index){
                  setState(() {
                    if (index == 0){
                      isSelectedParking[0] = true;
                      isSelectedParking[1] = false;
                      isParkingAvailable = false;
                    }else{
                      isSelectedParking[0] = false;
                      isSelectedParking[1] = true;
                      isParkingAvailable = false;
                    }
                  });
                },
                children: [
                  Text('Yes'),
                  Text('No')
                ],
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.topLeft,
                child: Text('Is Cafeteria Available?', style: TextStyle(fontSize: 15))
              ),
              SizedBox(height: 10),
              ToggleButtons(
                isSelected: isSelectedCafeteria,
                // selectedColor: Colors.green,
                fillColor: Colors.green[200],
                onPressed: (index){
                  setState(() {
                    if (index == 0){
                      isSelectedCafeteria[0] = true;
                      isSelectedCafeteria[1] = false;
                      isCafeteriaAvailable = false;
                    }else{
                      isSelectedCafeteria[0] = false;
                      isSelectedCafeteria[1] = true;
                      isCafeteriaAvailable = true;
                    }
                  });
                },
                children: [
                  Text('Yes'),
                  Text('No')
                ],
              ),
              SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      onTap(1);
                    },
                    child: Text('Go Back', 
                      style:TextStyle(color: Colors.lightGreen, decoration: TextDecoration.underline,)
                    ),
                  ),
                  RaisedButton(
                    color: Color(0XFF00ff00),
                    onPressed: () async{
                      // if(_formKeyformFeatures.currentState.validate()){
                      //   Map<String, dynamic> contacts = {
                      //     'primaryName': primaryName,
                      //     'primaryPhoneNo': primaryPhoneNo,
                      //     'secondaryName': secondaryName,
                      //     'secondaryPhoneNo': secondaryPhoneNo,
                      //   }; 
                      //   setState(() => loading = true);
                      //   dynamic result = await _auth.registerWithEmailAndPassword(email, password, futsalName, location, price, isParkingAvailable, isCafeteriaAvailable, contacts);
                      //   if (result == null){
                      //     print("Couldn't Sign in");
                      //     setState(() {
                      //       error = 'Please enter valid email';
                      //       loading = false;
                      //     });
                      //   }
                      // }
                      if (_formKeyformFeatures.currentState.validate()){
                        onTap(3);
                      }
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('Next'),
                  ),
                ]
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget formLatLong(Function onTap){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Needed Exact Location of Futsal', style: TextStyle(color: Color(0XFF00ff00), fontSize: 20)),
          Text('Turn on Location', style: TextStyle(color: Color(0XFF00ff00), fontSize: 20)),
          SizedBox(height: 20,),
          !gotLocation ? loadingNotFullScreen ? LoadingNotFullScreen(): FlatButton(
            color: Color(0XFF00ff00),
            onPressed: () async{
              setState(() => loadingNotFullScreen = true);
              Position position = await Location().getLocation();
              if (position != null){
                print('${position.latitude.toString()} , ${position.longitude.toString()}');
                latlong = {
                  'latitude': double.parse(position.latitude.toString()), 
                  'longitude': double.parse(position.longitude.toString())
                };
                setState(() {
                  gotLocation = true;
                  loadingNotFullScreen = true;
                });
              }else{
                setState(() { 
                  errorLoc = 'Error while getting location Try again!';
                  loadingNotFullScreen = false;
                });
              }
            },
            child: Text('Get Location')
          ) : Text('You are ready to go'),
          SizedBox(height: 5,),
          Text(errorLoc, style: TextStyle(color: Colors.red),),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: (){
                  onTap(2);
                },
                child: Text('Go Back', 
                  style:TextStyle(color: Colors.lightGreen, decoration: TextDecoration.underline,)
                ),
              ),
              gotLocation ? RaisedButton(
                color: Color(0XFF00ff00),
                onPressed: () async{
                  Map<String, dynamic> contacts = {
                    'primaryName': primaryName,
                    'primaryPhoneNo': primaryPhoneNo,
                    'secondaryName': secondaryName,
                    'secondaryPhoneNo': secondaryPhoneNo,
                  }; 
                  setState(() => loading = true);
                  dynamic result = await _auth.registerWithEmailAndPassword(email, password, futsalName, location, price, isParkingAvailable, isCafeteriaAvailable, contacts, latlong);
                  if (result == null){
                    print("Couldn't Sign in");
                    setState(() {
                      error = 'Please enter valid email';
                      loading = false;
                    });
                  }
                  // onTap(3);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text('Next'),
              ): Text(''),
            ]
          ),
        ],
      )
    );
  }
 
  //sign in form
  // Widget signInForm(Function toggleView){
  //   return SingleChildScrollView(
  //     child: Padding(
  //       padding: const EdgeInsets.only(top: 270, left: 30, right: 30),
  //       child: Form(
  //         key: _formKey,
  //         child: Column(
  //           children: <Widget>[
  //             TextFormField(
  //               decoration: inputDecoration.copyWith(labelText: 'Name'),
  //               validator: (val) => val.isEmpty ? 'Please enter Name' : null,
  //               onChanged: (val) {
  //                 setState(() {
  //                   name = val;
  //                 });
  //               },
  //             ),
  //             SizedBox(height: 20),
  //             TextFormField(
  //               decoration: inputDecoration.copyWith(labelText: 'Phone no'),
  //               validator: (val) => (val.length != 10) ? 'Please enter Valid Phone no' : null,
  //               onChanged: (val) {
  //                 setState(() {
  //                   phoneNo = val;
  //                 });
  //               },
  //             ),
  //             SizedBox(height: 20),
  //             TextFormField(
  //               decoration: inputDecoration.copyWith(labelText: 'Email'),
  //               validator: (val) => val.isEmpty ? 'Please enter email' : null,
  //               onChanged: (val) {
  //                 setState(() {
  //                   email = val;
  //                 });
  //               },
  //             ),
  //             SizedBox(height: 20),
  //             TextFormField(
  //               obscureText: true,
  //               decoration: inputDecoration.copyWith(labelText: 'Password'),
  //               validator: (val) => (val.length < 6) ? 'Password is weak. Must be more than 6 charecter' : null,
  //               onChanged: (val) {
  //                 setState(() {
  //                   password = val;
  //                 });
  //               },
  //             ),
  //             SizedBox(height: 30),
  //             SizedBox(
  //               width: 200,
  //               child: RaisedButton(
  //                 color: Color(0XFF00ff00),
  //                 onPressed: () async{
  //                   if(_formKey.currentState.validate()){
  //                     setState(() => loading = true);
  //                     dynamic result =  await _auth.registerWithEmailAndPassword(email, password, name, phoneNo);
  //                     if(result == null){
  //                       setState(() {
  //                         error = 'Please enter valid email';
  //                         loading = false;
  //                       });
  //                     }
  //                   }
  //                 },
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(20),
  //                 ),
  //                 child: Text('Sign Up'),
  //               ),
  //             ),
  //             SizedBox(height: 5,),
  //             Text(error, style: TextStyle(color: Colors.red),),
  //             SizedBox(height: 10,),
  //             Text("Already have an Account?"),
  //             GestureDetector(
  //               onTap: (){
  //                 toggleView();
  //               },
  //               child: Text('Log In', 
  //                 style:TextStyle(color: Colors.lightGreen, decoration: TextDecoration.underline,)
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}