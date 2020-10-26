import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:html/parser.dart';

import 'colors.dart';

const String LoadingIndicatorTitle = '^';

const Widget horizontalSpaceTiny = SizedBox(width: 5.0);
const Widget horizontalSpaceSmall = SizedBox(width: 10.0);
const Widget horizontalSpaceMedium = SizedBox(width: 25.0);

Widget horizontalSpace(double width) => SizedBox(width: width);

const Widget verticalSpaceTiny = SizedBox(height: 5.0);
const Widget verticalSpaceSmall = SizedBox(height: 10.0);
const Widget verticalSpaceMedium = SizedBox(height: 25.0);

Widget verticalSpace(double height) => SizedBox(height: height);

Widget leftPadding({double left, Widget child}) => Padding(
      padding: EdgeInsets.only(left: left),
      child: child,
    );

Widget lrPadding({Widget child}) => Padding(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: child,
    );

BorderRadiusGeometry roundedCorner(double radius) =>
    BorderRadius.circular(radius);

ShapeBorder roundedCornerShape(double radius) =>
    RoundedRectangleBorder(borderRadius: roundedCorner(radius));

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;

double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

TextTheme myTextTheme(BuildContext context) => Theme.of(context).textTheme;

Future myNavigation(BuildContext context, Widget child) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => child));

Html myHtmlParser(String data) => Html(
      shrinkWrap: true,
      data: '''${parse(data).documentElement.innerHtml}''',
      style: {"p": Style(padding: EdgeInsets.all(0))},
    );

Container myDrawerTile(BuildContext context, String title) => Container(
      width: double.infinity,
      child: leftPadding(
          left: 12,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: myTextTheme(context).headline1.apply(
                  color: kPrim,
                ),
          )),
    );

Text myRegularPrice(BuildContext context, String regularPrice, String price) =>
    Text(
      regularPrice == '' ? 'Starting at ₹ $price' : '₹ ' + regularPrice,
      style: Theme.of(context).textTheme.bodyText1,
    );

Row myStrikedPrice(BuildContext context, String regularPrice, String salePrice,
        String price) =>
    Row(
      children: [
        Text(
          regularPrice == ''
              ? 'Starting at ₹ $price'
              : '₹ ' + salePrice.toString(),
          style: Theme.of(context).textTheme.bodyText1,
        ),
        horizontalSpaceSmall,
        Text(
          regularPrice == ''
              ? 'Starting at ₹ $price'
              : '₹ ' + regularPrice.toString(),
          style: Theme.of(context).textTheme.bodyText2.apply(
              color: Colors.grey, decoration: TextDecoration.lineThrough),
        )
      ],
    );

myPriceBundle(BuildContext context, String regularPrice, String salePrice,
        String price) =>
    salePrice == ''
        ? myRegularPrice(context, regularPrice, price)
        : myStrikedPrice(context, regularPrice, salePrice, price);
