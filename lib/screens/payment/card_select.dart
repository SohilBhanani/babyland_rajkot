import 'package:babylandrajkot/service/payment_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:stripe_payment/stripe_payment.dart';

class CardSelect extends StatefulWidget {
  int amount;
  String uid;



  CardSelect({this.uid, this.amount});

  @override
  _CardSelectState createState() => _CardSelectState();
}

class _CardSelectState extends State<CardSelect> {
  List cards = [
    {
      'cardNumber': '4242424242424242',
      'expiryDate': '04/24',
      'cardHolderName': 'Sohil Bhanani',
      'cvvCode': '424',
      'showBackView': 'false'
    },
    {
      'cardNumber': '4242424242424242',
      'expiryDate': '04/24',
      'cardHolderName': 'Sohil Bhanani',
      'cvvCode': '424',
      'showBackView': 'false'
    },
  ];
  List newcard = [{
    'cardNumber': '',
    'expiryDate': ''
  }];

  payViaExistingCard1(BuildContext context, String cardNumber, String expiry) async {
//    print(expiry+cardNumber);
    List<String> expiryArr = expiry.split('/');
    CreditCard stripeCard = CreditCard(
      number: cardNumber,
      expMonth: int.parse(expiryArr[0]),
      expYear: int.parse(expiryArr[1]),
    );
    var response = await StripeService.payViaExistingCard(
        amount: widget.amount.toString() + '00',
        currency: 'INR',
        card: stripeCard);
    print('This is Reeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee'+ response.success.toString());
    if (response.success == true) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(
            content: Text(response.message),
            duration: Duration(milliseconds: 1200),
          ))
          .closed
          .then((_) {
        Navigator.pop(context);
      });
    }
  }

  String number;
  String name;
  String expiry;
  String cvv;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pay through Card'),
      ),
      body: Column(
        children: [
          Text(widget.uid),
          Expanded(
              //888888888888888888888888888888888888888888888888888888888888888888
              child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection('users')
                .document(widget.uid)
                .collection('cards')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Text('Loading.. Please Wait');
                default:
                  return ListView(
                      children: snapshot.data.documents.map(
                    (DocumentSnapshot document) {
                      return Stack(
                        children: [
                          InkWell(
                            onTap: () {
                                payViaExistingCard1(context, document.data()['card_number'],document.data()['expiry']);
                            },
                            child: CreditCardWidget(
//                        cardNumber: document['card_number'],
                              cardNumber: document.data()['card_number'],
                              expiryDate: document.data()['expiry'],
                              cardHolderName: document.data()['name'],
                              cvvCode: document.data()['cvv'],
                              showBackView: false,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              icon: Icon(
                                Icons.clear,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                document.reference.delete();
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ).toList());
              }
            },
          )),
          //8888888888888888888888888888888888888888888888888888888888888888888
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (ctx) => Container(
                  height: 700,
                  padding: EdgeInsets.all(8),
                  child: ListView(
                    children: [
                      ListTile(
                        title: Text('Enter Card Details'),
                      ),
                      TextFormField(
//            controller: numberController,
                        onChanged: (num) {
                          setState(() {
                            number = num;
                          });
                        },
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly,
                          new LengthLimitingTextInputFormatter(19),
                        ],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Card Number'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
//            controller: nameController,
                        onChanged: (nam) {
                          setState(() {
                            name = nam;
                          });
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Name On Card'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
//                  controller: expiryController,
                              onChanged: (exp) {
                                setState(() {
                                  expiry = exp;
                                });
                              },
                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly,
                                new LengthLimitingTextInputFormatter(4),
                                new CardMonthInputFormatter()
                              ],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Expiry Date (MM/YY)'),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
//                  controller: cvvController,
                              onChanged: (cv) {
                                setState(() {
                                  cvv = cv;
                                });
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'CVV'),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: RaisedButton.icon(
                            onPressed: () {
                              print(name.toString() +
                                  number.toString() +
                                  cvv.toString() +
                                  expiry.toString());
                              Firestore.instance
                                  .collection('users')
                                  .document(widget.uid)
                                  .collection('cards')
                                  .document()
                                  .setData({
                                'card_number': number,
                                'name': name,
                                'expiry': expiry,
                                'cvv': cvv
                              }).then((_) => Navigator.pop(context));
                            },
                            color: Colors.teal,
                            icon: Icon(
                              Icons.save,
                              color: Colors.white,
                            ),
                            label: Text(
                              'Save',
                              style: TextStyle(color: Colors.white),
                            )),
                      )
                    ],
                  ),
                ),
              );
            },
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              color: Colors.orange,
              child: Center(
                  child: Text(
                'Save New Card',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              )),
            ),
          ),
          Builder(
            builder: (context) => InkWell(
              onTap: () async {
                var response = await StripeService.payWithNewCard(
                    amount: widget.amount.toString() + '00', currency: 'INR');
                Scaffold.of(context)
                    .showSnackBar(
                      SnackBar(
                        content: Text(response.message),
                        duration: Duration(
                            milliseconds:
                                response.success == true ? 1200 : 3200),
                      ),
                    )
                    .closed
                    .then((value) => Navigator.pop(context));
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                color: Colors.blue,
                child: Center(
                    child: Text(
                  'Pay without saving Card',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container _buildBottomSheet(BuildContext context) {
//    int number;
//    String name;
//    String expiry;
//    String cvv;

    return Container(
      //TODO: ALl values of firestore are not updating except CVV
      height: 700,
      padding: EdgeInsets.all(8),
      child: ListView(
        children: [
          ListTile(
            title: Text('Enter Card Details'),
          ),
          TextFormField(
//            controller: numberController,
            onChanged: (num) {
              setState(() {
                number = num;
              });
            },
            inputFormatters: [
              WhitelistingTextInputFormatter.digitsOnly,
              new LengthLimitingTextInputFormatter(19),
            ],
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Card Number'),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
//            controller: nameController,
            onChanged: (nam) {
              setState(() {
                name = nam;
              });
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Name On Card'),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
//                  controller: expiryController,
                  onChanged: (exp) {
                    setState(() {
                      expiry = exp;
                    });
                  },
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly,
                    new LengthLimitingTextInputFormatter(4),
                    new CardMonthInputFormatter()
                  ],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Expiry Date (MM/YY)'),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFormField(
//                  controller: cvvController,
                  onChanged: (cv) {
                    setState(() {
                      cvv = cv;
                    });
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'CVV'),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.center,
            child: RaisedButton.icon(
                onPressed: () {
                  print(name.toString() +
                      number.toString() +
                      cvv.toString() +
                      expiry.toString());
                  Firestore.instance
                      .collection('users')
                      .document(widget.uid)
                      .collection('cards')
                      .document(widget.uid)
                      .setData({
                    'card_number': number,
                    'name': name,
                    'expiry': expiry,
                    'cvv': cvv
                  }).then((_) => Navigator.pop(context));
                },
                color: Colors.teal,
                icon: Icon(
                  Icons.save,
                  color: Colors.white,
                ),
                label: Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                )),
          )
        ],
      ),
    );
  }
}

class CardMonthInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != newText.length) {
        buffer.write('/');
      }
    }

    // var string = buffer.toString();
    // return newValue.copyWith(
        // text: string,
        // selection: new TextSelection.collapsed(int: string.length));
  }
}
