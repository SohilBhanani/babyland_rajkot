import 'package:babylandrajkot/screens/payment/address_selection.dart';
import 'package:flutter/material.dart';

class CheckoutSection extends StatelessWidget {
  final BuildContext context;
  final bloc;
  final String uid;
  CheckoutSection({this.context,this.bloc,this.uid});
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.only(topLeft: Radius.circular(12.0),topRight: Radius.circular(12.0)),
      color: Color(0xff0D7591),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                left: 18.0, right: 18.0, bottom: 10, top: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Total : ',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                ),
                Text(
                  '₹ '+ bloc.totalPrice().toString(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28,color: Colors.white),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddressPage(uid)));
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Colors.teal[200],
              height: 60,
              minWidth: MediaQuery.of(context).size.width,
              elevation: 5,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(

                      'Checkout',
                      style: TextStyle(fontSize: 25, color: Colors.blue[800]),
                    ),
                  ),
                  Icon(Icons.keyboard_tab,size: 32.0, color: Colors.blue[800])
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
