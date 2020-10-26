
import 'package:babylandrajkot/model/user.dart';
import 'package:babylandrajkot/screens/authentication/authentication.dart';
import 'package:babylandrajkot/screens/home_screen.dart';
import 'package:babylandrajkot/service/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<AppUser>(context);
    print(user);

    // return either the Home or Authenticate widget
    if (user == null){
      return Authenticate();
    } else {
      return HomePage(user,AuthService().getCurrentUser);
    }

  }
}