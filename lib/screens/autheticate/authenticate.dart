// import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:futsal_admin/screens/autheticate/register.dart';
import 'package:futsal_admin/screens/autheticate/signin.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> with SingleTickerProviderStateMixin {
  bool showSignin = true;
  void toggleView(){
    // if (!showSignin){
    //   _animationController.forward();
    // }else{
    //   _animationController.reverse();
    // }
    setState(() {
      showSignin = !showSignin;
    });
  }

  // // for animation
  // AnimationController _animationController;
  // @override
  // void initState() {
  //   super.initState();
  //   _animationController = AnimationController(
  //     vsync: this,
  //     duration: Duration(seconds: 600)
  //   );
  // }
  // void toggle() => _animationController.isDismissed
  //   ? _animationController.forward()
  //   : _animationController.reverse();
  
  @override
  Widget build(BuildContext context) {
    if (showSignin){
      return SignIn(toggleView: toggleView);
    }else{
      return Register(toggleView: toggleView);
    }
    
    // Size size = MediaQuery.of(context).size;
    // return AnimatedBuilder(
    //   animation: _animationController,
    //   builder: (context, snapshot){ 
    //     return Stack(
    //       children: <Widget>[
    //         Transform.translate(
    //           offset: Offset(size.width * (_animationController.value - 1), 0),
    //           child: Transform(
    //             transform: Matrix4.identity()
    //               ..setEntry(3, 2, 0.001)
    //               ..rotateY(3.1415 / 2 * (1 - _animationController.value)),
    //             alignment: Alignment.centerRight,
    //             child: Register(toggleView: toggle),
    //           ),
    //         ),
    //         // Register(toggleView: toggle),
    //         Transform.translate(
    //           offset: Offset(size.width * _animationController.value, 0),
    //           child: Transform(
    //             transform: Matrix4.identity()
    //               ..setEntry(3, 2, 0.001)
    //               ..rotateY(-math.pi * _animationController.value / 2),
    //             alignment: Alignment.centerLeft,
    //             child: SignIn(toggleView: toggle),
    //           ),
    //         ),
    //         // SignIn(toggleView: toggle),
    //       ],
    //     );
    //   },
      
    // );
  }
}