import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../services/database_service.dart';
import '../../shared/ui_helpers.dart';

class MyOrders extends StatelessWidget {
  final String uid;
  MyOrders(this.uid);

  Color getColor(String s) {
    switch (s) {
      case 'Processing':
        return Colors.yellow;
        break;
      case 'Order Approved':
        return Colors.orange;
        break;
      case 'Out for Delivery':
        return Colors.blue;
        break;
      case 'Delivered':
        return Colors.green;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // FireUser user = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      body: StreamBuilder(
        stream: Provider.of<DbService>(context).getOrderDetails(uid),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemBuilder: (context, index) {
                    var order = snapshot.data.documents[index].data();
                    String orderId = order['whatsapp'].substring(
                          order['whatsapp'].length - 3,
                        ) +
                        order['orderId'].substring(
                          order['orderId'].length - 6,
                        );
                    List<Widget> names = order['name']
                        .map<Widget>((name) => Row(
                              children: [
                                Text(name),
                              ],
                            ))
                        .toList();
                    // var id = snapshot.data.id.toString();
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: SelectableText(
                                    'Order #$orderId',
                                    style: myTextTheme(context).button,
                                  ),
                                ),
                                Text(
                                  '₹ ' + order['amount'].toString(),
                                  style: myTextTheme(context).button,
                                )
                              ],
                            ),
                            verticalSpaceSmall,
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    order['name'].length.toString() + ' Item/s',
                                    style: myTextTheme(context).bodyText1.apply(
                                        fontWeightDelta: 3, color: Colors.grey),
                                  ),
                                ),
                                Text(
                                  DateFormat.yMd()
                                      .add_jm()
                                      .format(order['timestamp'].toDate()),
                                  style: myTextTheme(context).bodyText1.apply(
                                      fontWeightDelta: 3, color: Colors.grey),
                                )
                              ],
                            ),
                            verticalSpaceSmall,
                            Column(
                              children: names,
                            ),
                            verticalSpaceSmall,
                            Divider(),
                            Row(
                              children: [
                                Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                      color: getColor(order['status']),
                                      borderRadius: roundedCorner(7.5)),
                                ),
                                horizontalSpaceTiny,
                                Expanded(child: Text(order['status'])),
                                // OutlineButton(
                                //   textColor: kPrim,
                                //   onPressed: () {},
                                //   child: Text('Details'),
                                // )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: snapshot.data.documents.length,
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
