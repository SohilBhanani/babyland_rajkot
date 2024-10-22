import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../components/address_bottom_sheet.dart';
import '../models/cart_model.dart';
import '../services/cart_service.dart';
import '../services/database_service.dart';
import '../services/payment_service.dart';
import '../shared/colors.dart';
import '../shared/ui_helpers.dart';

class CheckoutScreen extends StatelessWidget {
  final uid;

  CheckoutScreen({this.uid});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    List<CartModel> cart = Provider.of<CartService>(context).cart;
    CartService cartService = Provider.of<CartService>(context);
    PaymentService paymentService = Provider.of<PaymentService>(context);
    List<String> items = cart.map((cartItem) {
      return cartItem.qty.toString() +
          ' - (' +
          cartItem.product.name +
          ", " +
          cartItem.size +
          ", " +
          cartItem.color +
          ')';
    }).toList();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpaceSmall,
              Text(
                'Address',
                style: myTextTheme(context).headline3.apply(color: kPrim),
              ),
              verticalSpaceTiny,
              Divider(
                color: kPrim,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Current Address',
                      style: myTextTheme(context)
                          .subtitle1
                          .apply(fontWeightDelta: 4, color: kPrim),
                    ),
                  ),
                  FlatButton(
                    shape: roundedCornerShape(10),
                    onPressed: () {
                      _scaffoldKey.currentState
                          .showBottomSheet((context) => MyBottomSheet(
                                ctx: context,
                                uid: uid,
                              ));
                    },
                    child: Text(
                      'Edit',
                      style: myTextTheme(context)
                          .button
                          .apply(color: Colors.white),
                    ),
                    color: kPrim,
                  )
                ],
              ),
              SizedBox(
                height: screenHeight(context) * 0.1,
                child: StreamBuilder(
                  stream: Provider.of<DbService>(context).getUserAddress(uid),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return snapshot.hasData
                        ? Text(
                            snapshot.data['address'],
                            style: myTextTheme(context).bodyText1,
                          )
                        : Center(child: CircularProgressIndicator());
                  },
                ),
              ),
              verticalSpaceMedium,
              Text(
                'Summery',
                style: myTextTheme(context).headline3.apply(color: kPrim),
              ),
              verticalSpaceTiny,
              Divider(
                color: kPrim,
              ),
              SizedBox(
                height: screenHeight(context) * 0.35,
                child: ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (BuildContext context, index) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Card(
                              color: Colors.transparent,
                              elevation: 0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cart[index].product.name,
                                    style: myTextTheme(context).bodyText1,
                                  ),
                                  Text(
                                    cart[index].size +
                                        " / " +
                                        cart[index].color,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  cart[index].salePrice == ''
                                      ? Text(
                                          'Amount: ' + cart[index].regularPrice,
                                          style: TextStyle(color: Colors.grey),
                                        )
                                      : Text(
                                          'Amount: ' + cart[index].salePrice,
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                  Text(
                                    'Qty: ' + cart[index].qty.toString(),
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          cart[index].salePrice == ''
                              ? Text(
                                  (double.parse(cart[index].regularPrice) *
                                          cart[index].qty)
                                      .toString(),
                                  style: myTextTheme(context).headline5,
                                )
                              : Text(
                                  (double.parse(cart[index].salePrice) *
                                          cart[index].qty)
                                      .toString(),
                                  style: myTextTheme(context).headline5,
                                )
                        ],
                      );
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: screenWidth(context) - 16,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text('Total : ',
                                  style: myTextTheme(context)
                                      .headline6
                                      .apply(color: kPrim)),
                            ),
                            Text(cartService.totalPrice().toString(),
                                style: myTextTheme(context)
                                    .headline6
                                    .apply(color: kPrim)),
                          ],
                        ),
                      ),
                      //   Container(
                      //   width: screenWidth(context)-16,
                      //   child: Row(
                      //     children: [
                      //       Expanded(
                      //         child: Text('Total (Incl. GST): ',
                      //             style: myTextTheme(context)
                      //                 .button
                      //                 .apply(color: Colors.grey[600])),
                      //       ),
                      //       Text(cartService.totalPrice().toString(),
                      //           style: myTextTheme(context)
                      //               .button
                      //               .apply(color: Colors.grey[600])),
                      //     ],
                      //   ),
                      // ),
                      //   Container(
                      //     width: screenWidth(context)-16,
                      //     child: Row(
                      //       children: [
                      //         Expanded(
                      //           child: Text('Shipping:',
                      //               style: myTextTheme(context)
                      //                   .button
                      //                   .apply(color: Colors.grey[600])),
                      //         ),
                      //         Text('400',
                      //             style: myTextTheme(context)
                      //                 .button
                      //                 .apply(color: Colors.grey[600])),
                      //       ],
                      //     ),
                      //   ),
                      //   Container(
                      //     width: screenWidth(context)-16,
                      //     child: Row(
                      //       children: [
                      //         Expanded(
                      //           child: Text('Grand Total:',
                      //               style: myTextTheme(context)
                      //                   .headline6
                      //                   .apply(color: kPrim)),
                      //         ),
                      //         Text('40',
                      //             style: myTextTheme(context)
                      //                 .headline6
                      //                 .apply(color: kPrim)),
                      //       ],
                      //     ),
                      //   ),
                      // Text(
                      //   'Total (Incl GST): ' +
                      //       cartService.totalPrice().toString(),
                      //   style:
                      //       myTextTheme(context).headline6.apply(color: kPrim),
                      // ),
                      // Text('${paymentService.paymentStatus}'),
                      verticalSpaceSmall,
                      FutureBuilder(
                          future: Provider.of<DbService>(context)
                              .getUserDetails(uid),
                          builder: (context, snapshot) {
                            return snapshot.hasData
                                ? Container(
                                    padding: EdgeInsets.all(16),
                                    width: screenWidth(context) - 16,
                                    child: StreamBuilder(
                                        stream: Provider.of<DbService>(context)
                                            .getUserAddress(uid),
                                        builder: (context, stream) {
                                          var itemString = StringBuffer();
                                          items.forEach((element) {
                                            itemString.write(element + "\n");
                                          });
                                          return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                FlatButton(
                                                  color: kSec,
                                                  // shape: roundedCornerShape(12),
                                                  onPressed:
                                                      stream.data['address'] ==
                                                              ""
                                                          ? () {
                                                              Fluttertoast
                                                                  .showToast(
                                                                msg:
                                                                    'Please add your Address 🏠',
                                                                backgroundColor:
                                                                    kRed,
                                                              );
                                                            }
                                                          : () async {
                                                              Provider.of<DbService>(context, listen: false).generateOrder(
                                                                  names: items,
                                                                  uid: uid,
                                                                  personName:
                                                                      snapshot.data[
                                                                          'name'],
                                                                  whatsapp: snapshot
                                                                          .data[
                                                                      'contact'],
                                                                  email: snapshot
                                                                          .data[
                                                                      'email'],
                                                                  amount: cartService
                                                                      .totalPrice(),
                                                                  address: stream
                                                                          .data[
                                                                      'address'],
                                                                  payment:
                                                                      'Cod',
                                                                  status:
                                                                      'Processing',
                                                                  context:
                                                                      context,
                                                                  orderId: '/');
                                                            },
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: screenWidth(
                                                                context) *
                                                            0.005,
                                                        vertical: 15),
                                                    child: Text(
                                                      'Pay on Delivery',
                                                      style: TextStyle(
                                                          color: kPrim),
                                                    ),
                                                  ),
                                                ),
                                                FlatButton(
                                                  color: kPrim,
                                                  // shape: roundedCornerShape(12),
                                                  onPressed: stream.data[
                                                              'address'] ==
                                                          ""
                                                      ? () {
                                                          Fluttertoast
                                                              .showToast(
                                                            msg:
                                                                'Please add your Address 🏠',
                                                            backgroundColor:
                                                                kRed,
                                                          );
                                                        }
                                                      : () async {
                                                          paymentService
                                                              .setPaymentDetails(
                                                            items,
                                                            uid,
                                                            snapshot
                                                                .data['name'],
                                                            snapshot.data[
                                                                'contact'],
                                                            snapshot
                                                                .data['email'],
                                                            cartService
                                                                .totalPrice(),
                                                            stream.data[
                                                                'address'],
                                                            'Paid',
                                                            'Processing',
                                                            context,
                                                          );
                                                          paymentService
                                                              .launchRazorPay(
                                                                  email: snapshot
                                                                          .data[
                                                                      'email'],
                                                                  contact: snapshot
                                                                          .data[
                                                                      'contact'],
                                                                  amount: cartService
                                                                      .totalPrice(),
                                                                  // description: items
                                                                  //     .toString());
                                                                  description:
                                                                      itemString
                                                                          .toString());
                                                          // print(
                                                          // 'Status of Payment -- ${paymentService.paymentStatus}');
                                                        },
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: screenWidth(
                                                                context) *
                                                            0.005,
                                                        vertical: 15),
                                                    child: Text(
                                                      'Proceed To Pay ',
                                                      style: TextStyle(
                                                          color: kSec),
                                                    ),
                                                  ),
                                                )
                                              ]);
                                        }))
                                : Container(
                                    width: screenWidth(context) - 16,
                                    child: Center(
                                        child: CircularProgressIndicator()));
                          })
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
