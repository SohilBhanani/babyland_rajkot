import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

import '../screens/drawer_screens/about_us.dart';
import '../screens/drawer_screens/my_orders.dart';
import '../services/auth_service.dart';
import '../services/database_service.dart';
import '../shared/colors.dart';
import '../shared/social_media.dart';
import '../shared/ui_helpers.dart';

class DrawerComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

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
                FutureBuilder(
                    future: getVersionNumber(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        // var yaml = loadYaml(snapshot.data);

                        var version = snapshot.data;
                        print('version isssssssss $version');
                        return Container(
                          child: Text(
                            'Version: $version',
                            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black26),
                          ),
                        );
                      }
                      return Text('Loading...');
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<String> getVersionNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version+'+'+ packageInfo.buildNumber;

    // Other data you can get:
    //
    // 	String appName = packageInfo.appName;
    // 	String packageName = packageInfo.packageName;
    // 	String buildNumber = packageInfo.buildNumber;
  }

}
