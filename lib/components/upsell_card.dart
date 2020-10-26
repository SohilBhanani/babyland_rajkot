import 'package:babyland_optimised/shared/ui_helpers.dart';
import 'package:flutter/material.dart';

class UpsellCard extends StatelessWidget {
  final String imgSrc;
  final String prodName;
  final String price;
  UpsellCard({this.imgSrc, this.prodName, this.price});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      child: Card(
        elevation: 4.0,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 250,
                height: 160,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    imgSrc,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    prodName,
                    softWrap: true,
                    textAlign: TextAlign.start,
                    style: myTextTheme(context).subtitle1,
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 8.0),
              //   child:
              //       Text('₹ ' + price, style: myTextTheme(context).bodyText1),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
