
import 'package:flutter/material.dart';

// TextFieldForm decoration
const inputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.green, width: 2),
  )
);

// Login / Register decoration
Widget signInBackground(String firstText, String secondText){
  return Stack(
    children: <Widget>[
      Image(
        image: AssetImage('assets/images/signIn.png'),
        height: 250,
      ),
      Positioned(
        top: 50,
        left: 30,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              firstText, 
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            Text(
              secondText,
              style: TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold),
            ),
            Text(
              'Futsal Owner', 
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            Text(
              'Only!!!!', 
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ],
        ),
      )
    ],
  );
}
