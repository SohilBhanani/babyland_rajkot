import 'package:babylandrajkot/model/cart_bloc.dart';
import 'package:babylandrajkot/screens/cart_page.dart';
import 'package:flutter/material.dart';

class CartIcon extends StatelessWidget {
  final CartBloc bloc;
  final Function currentUser;
  const CartIcon({
    Key key,
    @required this.bloc,
    this.currentUser
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right:8.0),
      child: Row(
        children: <Widget>[

          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Color(0xff8ACADF),

            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CartPage(currentUser)));
            },
          ),
          Card(
            elevation: 5,
            color: Colors.green[100],
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: Container(
              height: 25,
              width: 30,
              child: Center(child: Text(bloc.cart.length.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
            ),
          )
        ],
      ),
    );
  }
}
