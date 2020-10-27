import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:woocommerce/models/products.dart';
import 'package:woocommerce/woocommerce.dart';

import '../../components/product_photo.dart';
import '../../components/upsells.dart';
import '../../services/cart_service.dart';
import '../../services/variable_service.dart';
import '../../shared/colors.dart';
import '../../shared/ui_helpers.dart';

class VariableProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<WooProduct>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(product.name),
        ),
        body: Consumer<VariableService>(
          builder: (context, value, _) => FutureBuilder(
            future: value.getVariations(product),
            builder: (BuildContext context, snapshot) {
              return snapshot.hasData
                  ? SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          value.varImage != ''
                              ? ProductPhoto([value.varImage, ...value.images])
                              : ProductPhoto(value.images),
                          lrPadding(
                            child: Text(
                              product.name,
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ),
                          lrPadding(
                            child: Text(
                              value.statusString,
                              style: TextStyle(
                                  color: value.stockStatus == 'outofstock'
                                      ? Colors.red
                                      : Colors.green),
                            ),
                          ),
                          value.regularPrice == ''
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Starting at ${product.price}',
                                        style: myTextTheme(context).bodyText1,
                                      ),
                                      horizontalSpaceMedium,
                                      Text(
                                        'Select Size/Color to know more',
                                        style: TextStyle(color: kRed),
                                      ),
                                    ],
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: myPriceBundle(
                                      context,
                                      value.regularPrice,
                                      value.salePrice,
                                      product.price),
                                ),
                          verticalSpaceSmall,
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButtonFormField(
                                value: value.currentSize,
                                hint: Text('Available Size'),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: roundedCorner(12))),
                                items: product.attributes[1].options
                                    .map((e) => DropdownMenuItem(
                                          child: Text(e),
                                          value: e,
                                        ))
                                    .toList(),
                                onChanged: (val) {
                                  value.currentSize = val;
                                  value.stockStatus = '';

                                  value.resetPriceAndColor();

                                  value.clearColorItem();

                                  value.sizeChanged(ksize: val);
                                },
                                validator: (val) {
                                  if (value.currentSize.toString().length < 1)
                                    return 'Please select Color';
                                  return '';
                                }),
                          ),
                          value.colorItems.length == 0
                              ? Text('')
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DropdownButtonFormField(
                                    value: value.currentColor,
                                    hint: Text('Select a color'),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: roundedCorner(12),
                                      ),
                                    ),
                                    items: value.colorItems,
                                    onChanged: (val) {
                                      value.currentColor = val;
                                      value.colorChanged(val);
                                    },
                                    validator: (val) {
                                      print('ss ' + val);
                                      if (value.currentColor.length < 1)
                                        return 'Please select Color';
                                      return '';
                                    },
                                  ),
                                ),
                          ExpansionTile(
                            initiallyExpanded: true,
                            title: Text('description'),
                            children: [myHtmlParser(product.description)],
                          ),
                          verticalSpaceSmall,
                          Visibility(
                            visible: value.stockStatus == 'instock' ||
                                value.stockStatus == '',
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                OutlineButton(
                                  padding: EdgeInsets.all(20),
                                  shape: roundedCornerShape(12),
                                  highlightedBorderColor: kPrim,
                                  splashColor: kSec,
                                  onPressed: () {
                                    if (value.currentSize == null) {
                                      Fluttertoast.showToast(
                                          backgroundColor: kRed,
                                          msg: '❕ Please Enter Size');
                                      return;
                                    }
                                    if (value.colorItems.length != 0 &&
                                        value.currentColor == null) {
                                      Fluttertoast.showToast(
                                          backgroundColor: kRed,
                                          msg: '❕ Please Enter Color');
                                      return;
                                    }
                                    Fluttertoast.showToast(
                                            backgroundColor: kPrim,
                                            msg: '🛒 Item added to your cart')
                                        .then((_) => Provider.of<CartService>(
                                                    context,
                                                    listen: false)
                                                .addToCart(
                                              product: product,
                                              regularPrice: value.regularPrice,
                                              salePrice: value.salePrice,
                                              size: value.currentSize,
                                              color: value.currentColor,
                                              quantity: 1,
                                            ));
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
                          product.upsellIds.length > 0
                              ? leftPadding(
                                  left: 8,
                                  child: Text(
                                    'Also have a look at 🔽 ',
                                    style: myTextTheme(context)
                                        .bodyText1
                                        .apply(color: kPrim),
                                  ),
                                )
                              : Container(),
                          Upsells(
                            ids: product.upsellIds,
                          )
                        ],
                      ),
                    )
                  : Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
