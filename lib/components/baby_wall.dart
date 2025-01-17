import 'package:flutter/material.dart';

import '../shared/ui_helpers.dart';

class Babywall extends StatelessWidget {
  final String img1;
  final String img2;
  final String img3;
  final String img4;
  final String img5;
  Babywall({this.img1,this.img2,this.img3,this.img4,this.img5});
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 450,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(

              shape: roundedCornerShape(12),
              child: Container(
                height: 418,
                width: screenWidth(context) / 3 - 24,
                decoration: BoxDecoration(
                    borderRadius: roundedCorner(12.0),
                    color: Color(0xff8ACADF),
                    image: DecorationImage(
                        image: AssetImage(img1),
                        fit: BoxFit.cover)),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Card(
                      shape: roundedCornerShape(12.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: roundedCorner(12.0),
                            color: Color(0xff98DBD0),
                            image: DecorationImage(
                                image: AssetImage(img2),
                                fit: BoxFit.cover)),
                        height: 200,
                        width: screenWidth(context) / 3 - 24,
                      ),
                    ),
                    Card(
                      shape: roundedCornerShape(12),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: roundedCorner(12),
                            color: Color(0xffE7A2AE),
                            image: DecorationImage(
                                image: AssetImage(img3),
                                fit: BoxFit.cover)),
                        height: 200,
                        width: screenWidth(context) / 3 - 24,
                      ),
                    )
                  ],
                ),
                Card(
                  shape: roundedCornerShape(12),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: roundedCorner(12),
                        color: Color(0xff98DBD0),
                        image: DecorationImage(
                            image: AssetImage(img4),
                            fit: BoxFit.cover)),
                    height: 100,
                    width: screenWidth(context) / 2 + 30,
                  ),
                ),
                Card(
                  shape: roundedCornerShape(12),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: roundedCorner(12),
                        color: Color(0xff8ACADF),
                        image: DecorationImage(
                            image: AssetImage(img5),
                            fit: BoxFit.cover)),
                    height: 100,
                    width: screenWidth(context) / 2 + 30,
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
