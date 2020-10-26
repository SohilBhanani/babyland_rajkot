import './auth_widget.dart';
import './services/auth_service.dart';
import './services/banner_service.dart';
import './services/cart_service.dart';
import './services/database_service.dart';
import './services/scrolling_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/woocommerce_service.dart';
import 'shared/theme.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthService>(
          create: (_) => AuthService(),
        ),
        Provider<BannerService>(
          create: (_) => BannerService(),
        ),
        Provider<WooService>(
          create: (_) => WooService(),
        ),
        Provider<DbService>(
          create: (_) => DbService(),
        ),
        ChangeNotifierProvider<CartService>(
          create: (_) => CartService(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: babyTheme(),
        home: AuthWidget(),
      ),
    );
  }
}
