import 'package:babylandrajkot/components/loading_component.dart';
import 'package:babylandrajkot/service/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyOrders extends StatelessWidget {
  final String uid;

  MyOrders(this.uid);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff0D7591),
          title: Text('Orders Status'),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('orders')
              .where('uid', isEqualTo: uid)
              .snapshots(),
          builder: (context, snapshot) {
            return !snapshot.hasData
                ? Center(child: LoadingComponent(),)
                : ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {

                      List<Widget> wid = snapshot.data.documents[index].data()['name']
                          .map<Widget>((name) => Padding(
                            padding: const EdgeInsets.only(left:8.0),
                            child: Row(
                              children: [
                                Container(color: Colors.lightBlueAccent,height: 10,width: 10,),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left:8.0),
                                    child: Text(
                                          name,
                                          style: TextStyle(fontSize: 18),
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ))
                          .toList();
                      return Card(
                        elevation: 5,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '₹ ' +
                                          snapshot
                                              .data.documents[index].data()['amount']
                                              .toString(),
                                      style: TextStyle(fontSize: 22),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right:8.0),
                                    child: Text(
                                      DateFormat.yMMMd().add_jm().format(snapshot
                                          .data.documents[index].data()['timestamp']
                                          .toDate()),
                                      textAlign: TextAlign.center,
                                      style:
                                          TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              ...wid,
                              SizedBox(
                                height: 10,
                              ),
//                    Text("Status: " + snapshot.data.documents[index]['status']),
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(getStatus(snapshot
                                      .data.documents[index].data()['status']))),
//                 Container(
//                   child: OutlineButton(onPressed: (){},child: Text('Cancel Order'),),
//                 )
                            ],
                          ),
                        ),
                      );
                    },
                  );
          },
        ));
  }

  String getStatus(String s) {
    switch (s) {
      case 'Processing':
        return 'assets/status/process.png';
        break;
      case 'Order Approved':
        return 'assets/status/approve.png';
        break;
      case 'Out for Delivery':
        return 'assets/status/out.png';
        break;
      case 'Delivered':
        return 'assets/status/deliver.png';
        break;
    }
  }
}
