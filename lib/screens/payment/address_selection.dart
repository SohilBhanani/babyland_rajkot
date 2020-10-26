import 'package:babylandrajkot/components/alert/cod_alert.dart';
import 'package:babylandrajkot/model/cart_bloc.dart';
import 'package:babylandrajkot/model/payment_choice.dart';
import 'package:babylandrajkot/screens/my_orders/my_orders.dart';
import 'package:babylandrajkot/screens/payment/card_select.dart';
import 'package:babylandrajkot/service/payment_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:core';

class AddressPage extends StatefulWidget {
  final String uid;

  AddressPage(this.uid);

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final _formkey = GlobalKey<FormState>();
  String address = '';
  String whatsapp = '';
  String email = '';
  String personName = '';
  String newAdd = '';
  String defaultChoice = 'COD';
  int defaultIndex = 0;
  // var concatenate = StringBuffer();
  List<PaymentChoice> choices = [
    PaymentChoice(index: 0, choice: 'Cash on Delivery'),
    PaymentChoice(index: 1, choice: 'Credit/Debit Card'),
  ];

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<CartBloc>(context);
    Future<String> fetchAddress() async {
      var result = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
      if (result != null) {
        address = await result.data()['address'];
        String person = await result.data()['name'];
        String wp = await result.data()['contact'];
        String mail = await result.data()['email'];
        setState(() {
          whatsapp = wp;
          email = mail;
          personName = person;
        });
      }
      return address;
    }

    String getAddress() {
      fetchAddress().then((value) {
        setState(() {
          address = value;
        });
      });
      return address;
    }

    Future orderCOD() async {
      List<String> names = [];
      names = bloc.cart.map((cartItem) {
        return cartItem.qty.toString() +
            ' - (' +
            cartItem.product.name +
            ", " +
            cartItem.size +
            ", " +
            cartItem.color +
            ')';
      }).toList();
      try {
        var a = await FirebaseFirestore.instance.collection('orders').doc().set({
          'timestamp': Timestamp.now(),
          'name': names,
          'uid': widget.uid,
          'person': personName,
          'whatsapp': whatsapp,
          'email': email,
          'amount': bloc.totalPrice(),
          'address': newAdd == '' ? getAddress() : newAdd,
          'payment': 'cod',
          'status': 'Processing'
        }).then((value) {

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MyOrders(widget.uid)),
            );});
//      .then((value) {
//        Scaffold.of(context)
//            .showSnackBar(
//              SnackBar(
//                content: Text('Order Confirmed: Thankyou for shopping with us'),
//                duration: Duration(milliseconds: 3200),
//              ),
//            )
//            .closed
//            .then((value) {
//          bloc.cart.removeRange(0, bloc.cart.length);
//          Navigator.pushReplacement(context,
//              MaterialPageRoute(builder: (context) => MyOrders(widget.uid)));
//        });
//        concatenate.clear();
//      });
      } catch (e) {
        print(e.toString());
      }
    }

//    Future<String> fetchPerson() async {
//      var result = await Firestore.instance
//          .collection('users')
//          .document(widget.uid)
//          .get();
//      if (result != null) {
//        personName = await result['name'];
////      setState(() {
////        print(address);
////        print('new new' + address);
////      });
//      }
//      return personName;
//    }

//    String getPerson() {
//      fetchPerson().then((value) {
//        setState(() {
//          personName = value;
//        });
//      });
//      return personName;
//    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Address'),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: bloc.cart.length.toDouble() * 60,
            child: ListView.builder(
              itemBuilder: (context, index) {
                var cart = bloc.cart[index];
                String price = cart.product.salePrice==''?cart.product.regularPrice:cart.product.salePrice;
                return ListTile(
                  title: Row(
                    children: [
                      Expanded(
                          child: Text(cart.product.name +
                              ' ' +
                              ' ₹' +
                              price +
                              " x " +
                              cart.qty.toString())),
                      Text((double.parse(cart.product.salePrice==''?cart.product.regularPrice:cart.product.salePrice.toString()) *
                              cart.qty)

                          .toString())
                    ],
                  ),
                );
              },
              itemCount: bloc.cart.length,
            ),
          ),
          Card(
              child: Container(
                  height: 50,
                  padding: EdgeInsets.only(right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.black,
                      ),
                      Text(
                        'Total Amount : ${bloc.totalPrice()}',
                        style: TextStyle(fontSize: 24, color: Colors.black),
                      ),
                    ],
                  ))),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  'Your Current Address',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  getAddress() == '' ? 'Enter Address Below' : getAddress(),
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 150,
                  child: Form(
                    key: _formkey,
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          newAdd = value;
                        });
                      },
                      validator: (val) =>
                          (getAddress().length < 1) && (newAdd.length < 1)
                              ? 'Please Enter Address'
                              : null,
//                    initialValue: getAddress(),
                      decoration: InputDecoration(

                          labelStyle: TextStyle(color: Colors.black),
                          labelText: 'Enter/Update Address',
                          hintText:
                              'Write here if you are new to the app or you want to update your address',
                          hintMaxLines: 2,
                          border: InputBorder.none),
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Presently our products are limited for Rajkot users only : Sorry for the inconvinience',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text('Mode of Payment', style: TextStyle(fontSize: 22)),
          ),
          Column(
            children: [
              Wrap(
                children: [
                  Container(
                    child: Column(
                      children: choices
                          .map(
                            (e) => RadioListTile(
                                title: e.index == 0
                                    ? Text(e.choice)
                                    : Row(
                                        children: [
                                          Expanded(child: Text(e.choice)),
                                          Image.asset(
                                            'assets/payments/visa.png',
                                            scale: 12,
                                          ),
                                          SizedBox(width: 10),
                                          Image.asset(
                                            'assets/payments/mastercard.png',
                                            scale: 12,
                                          ),
                                        ],
                                      ),
                                value: e.index,
                                groupValue: defaultIndex,
                                onChanged: (value) {
                                  setState(() {
                                    defaultChoice = e.choice;
                                    defaultIndex = e.index;
                                  });
                                }),
                          )
                          .toList(),
                    ),
                  ),
                  Center(
                    child: Builder(
                      builder: (context) {
                        return RaisedButton(
                          child: Text('Confirm Order'),
                          onPressed: () async {
                            if (_formkey.currentState.validate()) {
                              newAdd == ''
                                  ? null
                                  : FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(widget.uid)
                                      .update({'address': newAdd});

                              switch (defaultIndex) {
                                case 0:
                                  _alertDialog(context, orderCOD);

//
                                  break;
                                case 1:
                                  List<String> names = [];
                                  names = bloc.cart.map((cartItem) {
                                    return cartItem.qty.toString() +
                                        ' - (' +
                                        cartItem.product.name +
                                        ", " +
                                        cartItem.size +
                                        ", " +
                                        cartItem.color +
                                        ')';
                                  }).toList();
                                  var response =
                                      await StripeService.payWithNewCard(
                                          amount: bloc.totalPrice().toStringAsFixed(2).replaceAll('.', '')
//                                          amount: (44).toStringAsFixed(2).replaceAll('.', '')
                                              ,
                                          currency: 'INR');
                                  print(response.message);
                                  Scaffold.of(context)
                                      .showSnackBar(
                                        SnackBar(
                                          content: Text(response.message),
                                          duration: Duration(
                                              milliseconds:
                                                  response.success == true
                                                      ? 1200
                                                      : 3200),
                                        ),
                                      )
                                      .closed
                                      .then((value) {
                                    if (response.message.compareTo(
                                            'Transaction Successful') ==
                                        0) {
                                      FirebaseFirestore.instance
                                          .collection('orders')
                                          .doc()
                                          .set({
                                        'timestamp': DateTime.now(),
                                        'name': names,
                                        'uid': widget.uid,
                                        'person': personName,
                                        'whatsapp': whatsapp,
                                        'email': email,
                                        'amount': bloc.totalPrice(),
                                        'address': newAdd == ''
                                            ? getAddress()
                                            : newAdd,
                                        'payment': 'card',
                                        'status': 'Processing'
                                      }).then((value) => Scaffold.of(context)
                                                  .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                          'Order Confirmed: Thankyou for shopping with us'),
                                                      duration: Duration(
                                                          milliseconds: 3200),
                                                    ),
                                                  )
                                                  .closed
                                                  .then((value) {
                                                bloc.removeAll();
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            MyOrders(
                                                                widget.uid)));
                                              }));
                                    } else {

                                      Scaffold.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Please Try Again or Prefer COD'),
                                          duration:
                                              Duration(milliseconds: 3200),
                                        ),
                                      );
                                    }
                                  });
                                  break;
                              }
                            }
//                            defaultIndex == 0
//                                ? Firestore.instance.collection('orders').document(widget.uid).collection(widget.uid).document().setData({
//                              'name' : names.toString(),
//                            })
////              : Navigator.push(context,
////                  MaterialPageRoute(builder: (context) => CardSelect(uid:widget.uid,amount:bloc.totalPrice())));
//                                : Container();
                          },
                        );
                      },
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  _alertDialog(BuildContext context, var order) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CodDialog(order);
      },
    );
  }
}
