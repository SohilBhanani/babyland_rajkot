import '../components/upsell_card.dart';
import '../screens/product/product_screen.dart';
import '../services/woocommerce_service.dart';
import '../shared/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woocommerce/models/products.dart';

class Upsells extends StatelessWidget {
  final List<int> ids;

  Upsells({this.ids});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: FutureBuilder(
        future: Provider.of<WooService>(context).getWooUpsells(ids),
        builder: (BuildContext context, snapshot) {
          return snapshot.hasData
              ? snapshot.data.length != 0
                  ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        WooProduct upsell = snapshot.data[index];
                        return GestureDetector(
                            onTap: () => myNavigation(
                                  context,
                                  Provider<WooProduct>.value(
                                    value: upsell,
                                    child: ProductScreen(),
                                  ),
                                ),
                            child: UpsellCard(
                              imgSrc: upsell.images[0].src,
                              price: upsell.price,
                              prodName: upsell.name,
                            ));
                      },
                      itemCount: snapshot.data.length,
                    )
                  : Container()
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
