import 'package:babyland_optimised/shared/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:woocommerce/models/products.dart';

class PTile extends StatelessWidget {
  const PTile({Key key, @required this.products}) : super(key: key);

  final WooProduct products;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
        child: Card(
          elevation: 3,
          shape: roundedCornerShape(8),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 120,
                  width: 90,
                  child: ClipRRect(
                      borderRadius: roundedCorner(8),
                      child: products.images.length == 0
                          ? Container()
                          : Image.network(
                              products.images[0].src,
                              fit: BoxFit.cover,
                            )),
                ),
              ),
              horizontalSpaceSmall,
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      products.name,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    // Text(
                    //   products.shortDescription,
                    //   style: Theme.of(context).textTheme.headline5,
                    // ),
                    myHtmlParser(
                      products.shortDescription,
                    ),
                    // verticalSpaceSmall,
                    myPriceBundle(context, products.regularPrice,
                        products.salePrice, products.price),
                    // products.salePrice == ''
                    //     ? MyRegularPrice(context,products) : MyStrikedPrice(context, products)
                    // : Row(
                    //     children: [
                    //       Text(
                    //         products.regularPrice == ''
                    //             ? 'Starting at ₹ ${products.price}'
                    //             : '₹ ' + products.salePrice.toString(),
                    //         style: Theme.of(context).textTheme.bodyText1,
                    //       ),
                    //       horizontalSpaceSmall,
                    //       Text(
                    //         products.regularPrice == ''
                    //             ? 'Starting at ₹ ${products.price}'
                    //             : '₹ ' + products.regularPrice.toString(),
                    //         style: Theme.of(context)
                    //             .textTheme
                    //             .bodyText1
                    //             .apply(
                    //                 color: Colors.grey,
                    //                 decoration: TextDecoration.lineThrough),
                    //       )
                    //     ],
                    //   ),
                  ],
                ),
              ),
            ],
          ),
          color: Colors.orangeAccent[50],
        ),
      ),
    );
  }
}
