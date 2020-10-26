import 'package:babylandrajkot/model/cart_bloc.dart';
import 'package:babylandrajkot/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return ChangeNotifierProvider<CartBloc>(
      create: (BuildContext context) => CartBloc(),
      child: MaterialApp(
        home: SplashScreen(),
//      home: AboutUs()
      ),
    );
  }
}
