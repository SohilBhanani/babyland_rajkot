import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:woocommerce/models/products.dart';

import '../../components/product_photo.dart';
import '../../components/radio_buttons.dart';
import '../../components/upsells.dart';
import '../../services/cart_service.dart';
import '../../services/color_size_choice.dart';
import '../../shared/colors.dart';
import '../../shared/ui_helpers.dart';

class SimpleProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WooProduct product = Provider.of<WooProduct>(context);
    List<String> images = List<String>.generate(
        product.images.length, (index) => product.images[index].src);
    // List<String> color = product.attributes[0].options??[];
    // List<String> size = product.attributes[1].options??[];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.name,
          softWrap: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductPhoto(images),
            lrPadding(
              child: Text(
                product.name,
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            verticalSpaceSmall,
            product.stockStatus == 'outofstock'
                ? Container(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      'Currently Out of Stock',
                      style: TextStyle(color: Colors.red),
                    ),
                  )
                : Container(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      'In Stock',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: myPriceBundle(context, product.regularPrice,
                  product.salePrice, product.price),
            ),
            Divider(),
            product.attributes.length > 0
                ? MyCustomRadio(
                    attr: product.attributes[0].options, //color
                    isColor: true,
                  )
                : Container(),
            product.attributes.length > 0
                ? MyCustomRadio(
                    attr: product.attributes[1].options, //size
                  )
                : Container(),
            ExpansionTile(
              initiallyExpanded: true,
              title: Text('description'),
              children: [myHtmlParser(product.description)],
            ),
            verticalSpaceSmall,
            Visibility(
              visible: product.stockStatus == 'instock',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlineButton(
                    padding: EdgeInsets.all(20),
                    shape: roundedCornerShape(12),
                    highlightedBorderColor: kPrim,
                    splashColor: kSec,
                    onPressed: () {
                      Fluttertoast.showToast(
                        msg: "🛒 Added to your Cart",
                        backgroundColor: kPrim,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                      ).then((value) =>
                          Provider.of<CartService>(context, listen: false)
                              .addToCart(
                                  product: product,
                                  regularPrice: product.regularPrice,
                                  salePrice: product.salePrice,
                                  size: Provider.of<ChoiceService>(context,
                                          listen: false)
                                      .size,
                                  color: Provider.of<ChoiceService>(context,
                                          listen: false)
                                      .color,
                                  quantity: 1));
                    },
                    child: Text(
                      'ADD TO CART 🛍',
                      style: myTextTheme(context).button,
                    ),
                  ),
                  horizontalSpaceSmall
                ],
              ),
            ),
            verticalSpaceSmall,
            product.upsellIds.length > 0
                ? leftPadding(
                    left: 8,
                    child: Text(
                      'Also have a look at 🔽 ',
                      style: myTextTheme(context).bodyText1.apply(color: kPrim),
                    ),
                  )
                : Container(),
            Upsells(
              ids: product.upsellIds,
            )
          ],
        ),
      ),
    );
  }
}
