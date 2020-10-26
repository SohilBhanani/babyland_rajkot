import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeaturedItem extends StatelessWidget {
  final String imagepath;
  final Color color;
  final String title;
  final String price;

  const FeaturedItem({this.imagepath, this.color, this.title, this.price});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 15.0, top: 10.0),
      child: Card(
        elevation: 4.0,
        color: color,
//        color: Color(0xff98DBD0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 250,
            width: 300,
            decoration: BoxDecoration(
              color: color,
//              color: Color(0xff98DBD0),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
//                        child: Image.network(
//                          imagepath,
//                          width: 380,
//                          height: 190,
//                          fit: BoxFit.cover,
//                        ),
                        child: FadeInImage.assetNetwork(
                          placeholder: "assets/ripple.gif",
                          image: imagepath,
                          width: 380,
                          height: 190,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    title,
                    textAlign: TextAlign.end,
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 25.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    '₹ ' + price,
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 22.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
