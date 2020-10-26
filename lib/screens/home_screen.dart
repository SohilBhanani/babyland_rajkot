import 'package:babylandrajkot/components/app_drawer.dart';
import 'package:babylandrajkot/model/cart_bloc.dart';
import 'package:babylandrajkot/model/user.dart';
import 'package:babylandrajkot/screens/cart_page.dart';
import 'package:babylandrajkot/screens/cat_page.dart';
import 'package:babylandrajkot/screens/featured_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final AppUser newUser;
  final Function func;
  HomePage(this.newUser,this.func);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final kTabPages = <Widget>[
    FeaturedPage(),
//    CategoryPage(),
  WooCategoryPage()
  ];

  final kTabs = <Tab>[
    Tab(
      child: Text(
        'Featured',
        style: GoogleFonts.openSans(
          textStyle: TextStyle(
//            color: Color(0xff0D7591),
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    ),
    Tab(
      child: Text(
        'Categories',
        style: GoogleFonts.openSans(
          textStyle: TextStyle(
//            color: Color(0xff0D7591),
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<CartBloc>(context);
    StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where('userid', isEqualTo: widget.newUser.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Text("Loading..");
        return Text(snapshot.data.documents[0]['name'],style: TextStyle(fontSize: 22,color: Colors.white),);
      },
    );
    return DefaultTabController(
      length: kTabs.length,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Column(
            children: [
              Text(
                'Babyland',
                style: GoogleFonts.abhayaLibre(
                  textStyle: TextStyle(
                      color: Color(0xff8ACADF),
                      fontWeight: FontWeight.bold,
                      fontSize: 28),
                ),
              ),
            ],
          ),
          centerTitle: true,
          elevation: 0,
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Color(0xff8acadf),
                ),
                onPressed: () {
                  print('Newuser is : ${widget.newUser.uid}');
                  Scaffold.of(context).openDrawer();},
              );
            },
          ),
          actions: <Widget>[
            Row(
              children: <Widget>[

                IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Color(0xff8ACADF),

                  ),
                  onPressed: () {
                    print('into the cart icon: ${widget.newUser.uid}');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CartPage(widget.func)));
                  },
                ),
                Card(
                  elevation: 5,
                  color: Colors.green[100],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  child: Container(
                    height: 25,
                    width: 30,
//                    child: Padding(
//                      padding: const EdgeInsets.only(right:28.0),
//                      child: CartIcon(bloc:bloc,currentUser: AuthService().getCurrentUser,),
//                    ),
                    child: Center(child: Text(bloc.cart.length.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                  ),
                )
              ],
            ),
//            CartIcon(bloc: bloc, newUser: newUser)
          ],
//                    color: Color(0xff8acadf),
          backgroundColor: Color(0xff0D7591),
          bottom: TabBar(
            labelStyle: TextStyle(fontSize: 18, color: Colors.white),
            indicatorColor: Color(0xff8ACADF),
            indicatorWeight: 6,
            tabs: kTabs,
          ),
        ),
        drawer: AppDrawer(newUser: widget.newUser,),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: kTabPages,
        ),
      ),
    );
  }
}
