import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:yaml/yaml.dart';

import '../screens/drawer_screens/about_us.dart';
import '../screens/drawer_screens/my_orders.dart';
import '../services/auth_service.dart';
import '../services/database_service.dart';
import '../shared/colors.dart';
import '../shared/social_media.dart';
import '../shared/ui_helpers.dart';

class DrawerComponent extends StatelessWidget {
  String appName;
  String packageName;
  String version;
  String buildNumber;
  @override
  Widget build(BuildContext context) {
  PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
    appName = packageInfo.appName;
    packageName = packageInfo.packageName;
   version = packageInfo.version;
  buildNumber = packageInfo.buildNumber;
  });
  // Future<Map> conf = loadConfig("../pubspec.yaml");
  // conf.then((Map config) {
  //   print(config['name']);
  //   print(config['description']);
  //   print(config['version']);
  //   print(config['author']);
  //   print(config['homepage']);
  //   print(config['dependencies']);
  // });
  // PackageInfo packageInfo = await PackageInfo.fromPlatform();
    FireUser user = Provider.of<FireUser>(context);
    return Drawer(
      child: Theme(
        data: Theme.of(context),
        child: Column(
          children: <Widget>[
            Container(
              height: 100,
              width: 100,
              child: Image.asset('assets/babyland.png'),
            ),
            FutureBuilder(
              future: Provider.of<DbService>(context).getUserDetails(user.uid),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Text(
                        snapshot.data['name'],
                        style:
                            myTextTheme(context).bodyText1.apply(color: kPrim),
                      ),
                      Text(
                        user.email,
                        style:
                            myTextTheme(context).bodyText1.apply(color: kPrim),
                      ),
                      Text(
                        snapshot.data['contact'],
                        style:
                            myTextTheme(context).bodyText1.apply(color: kPrim),
                      ),
                      FlatButton(
                        onPressed: () {
                          Provider.of<AuthService>(context, listen: false)
                              .signOut();
                        },
                        splashColor: kSec,
                        child: Text('Sign Out',
                            style:
                                myTextTheme(context).button.apply(color: kRed)),
                      )
                    ],
                  );
                }
                return CircularProgressIndicator();
              },
            ),
            verticalSpace(50),
            Divider(),
            Expanded(
              child: Column(
                children: [
                  InkWell(
                      onTap: () {
                        myNavigation(context, MyOrders(user.uid));
                      },
                      child: myDrawerTile(context, 'My Orders')),
                  verticalSpaceMedium,
                  InkWell(
                      onTap: () {
                        myNavigation(context, AboutUs());
                      },
                      child: myDrawerTile(context, 'About Us')),
                ],
              ),
            ),
            Column(
              children: [
                FutureBuilder(

                    future: rootBundle.loadString("pubspec.yaml"),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var yaml = loadYaml(snapshot.data);
                        version = yaml["version"];
                      }

                      return Container(
                        child: Text(
                            'Version: $version+$buildNumber'
                        ),
                      );
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    email,
                    SizedBox(
                      width: 20,
                    ),
                    instaIcon,
                    SizedBox(
                      width: 20,
                    ),
                    facebook,
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
