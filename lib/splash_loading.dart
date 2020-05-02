import 'dart:async';

import 'package:flutter/material.dart';
import 'package:formvalidation/DropDownExample.dart';
import 'package:formvalidation/TableDemo.dart';

class SplashSceen extends StatefulWidget {
  @override
  SplashSceenState createState() => SplashSceenState();
}

class SplashSceenState extends State<SplashSceen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => DropDownExample())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage("assets/images/payowners.jpeg"),
              width: 150.0,
              height: 150.0,
            ),
            Text("PAYOWNERS")
          ],
        ),
      ),
    );
  }
}
