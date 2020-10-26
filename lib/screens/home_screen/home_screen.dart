import 'package:babyland_optimised/components/drawer_component.dart';
import 'package:babyland_optimised/screens/cart_screen.dart';
import 'package:babyland_optimised/services/auth_service.dart';
import 'package:babyland_optimised/shared/ui_helpers.dart';
import 'package:flutter/material.dart';

import 'package:babyland_optimised/shared/colors.dart';
import 'package:provider/provider.dart';

import 'category_tab.dart';
import 'featured_tab.dart';

class HomeScreen extends StatelessWidget {
  final kTabs = <Tab>[
    Tab(
      child: Text(
        'Featured',
      ),
    ),
    Tab(
      child: Text(
        'Categories',
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    FireUser user = Provider.of<FireUser>(context);
    print('Inside HomeScreen');
    return SafeArea(
      child: DefaultTabController(
        length: kTabs.length,
        child: Scaffold(
          drawer: Drawer(
            child: DrawerComponent(),
          ),
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Babyland',
              style: myTextTheme(context).headline1.apply(
                    color: kSec,
                  ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.shopping_basket),
                onPressed: () =>
                    myNavigation(context, CartScreen(uid: user.uid)),
              )
            ],
            bottom: TabBar(
              labelStyle: myTextTheme(context).bodyText1,
              indicatorColor: kSec,
              indicatorWeight: 5,
              tabs: kTabs,
            ),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              FeaturedTabView(),
              CategoryTabView(),
            ],
          ),
        ),
      ),
    );
  }
}
