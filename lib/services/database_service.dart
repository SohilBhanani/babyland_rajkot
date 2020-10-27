import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../screens/drawer_screens/my_orders.dart';

class DbService {
  final fstore = FirebaseFirestore.instance;

  getUserDetails(String uid) async {
    print(uid);
    try {
      var details = await fstore.collection('users').doc(uid).get();
      return details;
    } catch (e) {
      print(e);
    }
  }

  getUserAddress(String uid) {
    try {
      var details = fstore.collection('users').doc(uid).snapshots();
      return details;
    } catch (e) {
      print(e);
    }
  }

  updateUserAddress(String uid, String address) {
    try {
      fstore.collection('users').doc(uid).update({'address': address});
    } catch (e) {
      print('Error in updating address: $e');
    }
  }

  Stream<QuerySnapshot> getOrderDetails(String uid) {
    try {
      var orders =
          fstore.collection('orders').where('uid', isEqualTo: uid).snapshots();

      return orders;
    } catch (e) {
      print(e);
    }
  }

  generateOrder({
    @required List<String> names,
    @required String uid,
    @required String personName,
    @required String whatsapp,
    @required String email,
    @required double amount,
    @required String address,
    @required String payment,
    @required String status,
    String orderId,
    @required BuildContext context,
  }) {
    try {
      DocumentReference docRef =
          FirebaseFirestore.instance.collection('orders').doc();
      docRef.set({
        'timestamp': Timestamp.now(),
        'name': names,
        'uid': uid,
        'person': personName,
        'whatsapp': whatsapp,
        'email': email,
        'amount': amount,
        'address': address,
        'payment': payment,
        'status': status,
        'orderId': orderId == '/' ? docRef.id : orderId,
        // 'orderId': docRef.id
      }).then((value) {
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyOrders(uid)));
      });
    } catch (e) {
      print('Error in Generating Order(database_service): $e');
    }
  }
}
