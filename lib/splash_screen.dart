import 'dart:async';
import 'package:babylandrajkot/model/user.dart';
import 'package:babylandrajkot/service/auth.dart';
import 'package:babylandrajkot/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
//  int pageIndex = 0;
//
//  List<Widget> pageList = <Widget>[
////    SplScreen(),
//    HomePage(),
//  ];

  startTime() async {
    var _duration = new Duration(seconds: 4);
    return Timer(_duration, navigationPage);
  }

  navigationPage() {
    setState(() {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return StreamProvider<AppUser>.value(value: AuthService().user,child: Wrapper(),);
        }),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(58.0),
        child: Center(
          child: Container(
              height: 200,
              width: 200,
              child: Image.asset(
                'assets/babyland.png',
              )),
        ),
      ),
    );
  }
}
