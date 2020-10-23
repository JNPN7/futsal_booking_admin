import 'package:flutter/material.dart';

class Hidden extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Who are you'),
      ),
      body: Stack(
        children: <Widget>[
          Stack(
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
                      'Hahahah :)', 
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    Text(
                      'Hidden Page',
                      style: TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}