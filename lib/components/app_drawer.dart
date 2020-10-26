import 'package:babylandrajkot/components/social_media.dart';
import 'package:babylandrajkot/model/user.dart';
import 'package:babylandrajkot/screens/my_orders/my_orders.dart';
import 'file:///D:/babyland_rajkot/babyland_rajkot/lib/screens/about_us/about_us.dart';
import 'package:babylandrajkot/screens/video_section/video_section.dart';
import 'package:babylandrajkot/service/auth.dart';
import 'package:boxicons_flutter/boxicons_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppDrawer extends StatelessWidget {
  final AppUser newUser;

  AppDrawer({this.newUser});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Color(0xff0D7591)),
      child: Drawer(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    decoration: BoxDecoration(
                        color: Color(0xff0D7591),
                        image: DecorationImage(
                          colorFilter: ColorFilter.mode(
                              Colors.black54, BlendMode.multiply),
                          image: AssetImage(
                            'assets/backgroundId.jpg',
                          ),
                          fit: BoxFit.cover,
                        )),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.blue,
                            maxRadius: 28.0,
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('users')
                                      .where('userid', isEqualTo: newUser.uid)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if(snapshot.data==null){ return CircularProgressIndicator();}
                                    var user = snapshot.data.documents[0].data();
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          user['name'],
                                          style: TextStyle(
                                              fontSize: 22, color: Colors.white),
                                        ),
                                        Text(
                                          user['email'],
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white70),
                                        ),
                                        Text(
                                          user['contact'].toString(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white70),
                                        )
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyOrders(newUser.uid))),
                      leading: Icon(
                        Icons.description,
                        color: Color(0xff8ACADF),
                      ),
                      title: Text(
                        'My Orders',
                        style: TextStyle(color: Colors.white),
                      )),
                  ListTile(
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AboutUs())),
                      leading: Icon(
                        Icons.info_outline,
                        color: Color(0xff8ACADF),
                      ),
                      title: Text(
                        'About us',
                        style: TextStyle(color: Colors.white),
                      )),
                  ListTile(
                    leading: Icon(
                      Icons.keyboard_tab,
                      color: Color(0xff8ACADF),
                    ),
                    title: Text(
                      'Logout',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      AuthService().signOut();
                    },
                  ),
                ],
              ),
            ),
            Text(
              'Feedback With #babylandrajkot',
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
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
      ),
    );
  }
}
