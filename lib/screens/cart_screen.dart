import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart_model.dart';
import '../screens/checkout_screen.dart';
import '../services/cart_service.dart';
import '../services/payment_service.dart';
import '../shared/colors.dart';
import '../shared/ui_helpers.dart';

class CartScreen extends StatelessWidget {
  final uid;
  const CartScreen({this.uid});
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<CartService>(context);
    // List<CartModel> cart = bloc.cart;
    String totalPrice = bloc.totalPrice().toString();
    // print('SS' + bloc.cart[0].color.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<CartService>(builder: (ctx, value, _) {
              List<CartModel> cart = value.cart;
              return ListView.builder(
                itemCount: cart.length,
                itemBuilder: (BuildContext context, index) {
                  return Card(
                    elevation: 5,
                    shape: roundedCornerShape(12.0),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 120,
                            width: 100,
                            child: ClipRRect(
                              borderRadius: roundedCorner(12),
                              child: Image.network(
                                cart[index].product.images[0].src,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        horizontalSpaceSmall,
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        cart[index].product.name,
                                        style: myTextTheme(context).bodyText1,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.clear,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      value.clearItem(index);
                                    },
                                  )
                                ],
                              ),
                              myHtmlParser(
                                  cart[index].product.shortDescription),
                              Text(
                                cart[index].size + " / " + cart[index].color,
                                style: myTextTheme(context).bodyText1,
                              ),
                              verticalSpaceSmall,
                              Row(
                                children: <Widget>[
                                  Expanded(
                                      child: cart[index].salePrice == ''
                                          ? Text(
                                              '₹ ' + cart[index].regularPrice,
                                              style: myTextTheme(context)
                                                  .bodyText1,
                                            )
                                          : Text(
                                              '₹ ' + cart[index].salePrice,
                                              style: myTextTheme(context)
                                                  .bodyText1,
                                            )
                                      // ? myRegularPrice(
                                      //     context,
                                      //     cart[index].product.regularPrice,
                                      //     cart[index].product.price,
                                      //   )
                                      // : myStrikedPrice(
                                      //     context,
                                      //     cart[index].product.regularPrice,
                                      //     cart[index].product.salePrice,
                                      //     cart[index].product.price,
                                      //   )
                                      ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.green,
                                      size: 28,
                                    ),
                                    onPressed: () {
                                      value.addQty(index);
                                    },
                                  ),
                                  Text(
                                    cart[index].qty.toString(),
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.remove,
                                      color: Colors.red,
                                      size: 25,
                                    ),
                                    onPressed: () {
                                      bloc.removeQty(index);
                                    },
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
          bloc.cart.length == 0
              ? Container()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 50,
                      width: screenWidth(context),
                      child: FlatButton(
                        onPressed: () {
                          myNavigation(
                              context,
                              ChangeNotifierProvider<PaymentService>(
                                  create: (_) => PaymentService(),
                                  child: CheckoutScreen(uid: uid)));
                        },
                        color: kPrim,
                        child: Text(
                          '🚛  Checkout (₹ $totalPrice)',
                          style: myTextTheme(context)
                              .button
                              .apply(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                )
        ],
      ),
    );
  }
}
