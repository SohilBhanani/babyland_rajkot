import '../shared/colors.dart';
import '../shared/ui_helpers.dart';
import 'package:flutter/material.dart';

class FeaturedCard extends StatelessWidget {
  final String imagepath;
  final String title;
  final String price;

  const FeaturedCard({this.imagepath, this.title, this.price});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8.0, top: 10.0),
      child: Card(
        elevation: 4.0,
        color: kSec,
        shape: roundedCornerShape(12),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 250,
            width: 300,
            decoration: BoxDecoration(
              color: kSec,
//              color: Color(0xff98DBD0),
              borderRadius: roundedCorner(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Center(
                      child: ClipRRect(
                        borderRadius: roundedCorner(10),
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
                verticalSpaceSmall,
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    title,
                    textAlign: TextAlign.end,
                    style: myTextTheme(context).bodyText1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    '₹ ' + price,
                    style: myTextTheme(context).bodyText1,
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
