import 'package:flutter/material.dart';

class LoadingComponent extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(

        children: <Widget>[
          Container(
              height: 400,
              width: 600,
              child: Image.asset("assets/loadingBalloon_cropped.gif")),
          SizedBox(height: 10,),
          Text("Whoooshhh..",style: TextStyle(fontSize: 28,color: Colors.grey),)
        ],
      ),
    );
  }
}
