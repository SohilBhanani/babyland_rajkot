import 'package:babylandrajkot/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart';

class ItemListTile extends StatelessWidget {
  const ItemListTile({Key key, @required this.products, @required this.index})
      : super(key: key);

  final List<ProductModel> products;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 120,
                  width: 90,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        products[index].images[0].src,
                        fit: BoxFit.cover,
                      )),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      products[index].name,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
//                    Text(
//                      products[index].shortDescription,
//                      style: TextStyle(fontSize: 20),
//                    ),

                    Html(
                      data:
                          '''${parse(products[index].shortDescription).documentElement.innerHtml}''',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    products[index].salePrice == ''
                        ? Text(
                            products[index].regularPrice==''?'Starting at ₹ ${products[index].price}':'₹ ' + products[index].regularPrice.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 22.0,
                              color: Colors.black,
                            ),
                          )
                        : Row(
                            children: [
                              Text(
                                products[index].regularPrice==''?'Starting at ₹ ${products[index].price}':'₹ ' + products[index].salePrice.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 22.0,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                products[index].regularPrice==''?'Starting at ₹ ${products[index].price}':'₹ ' + products[index].regularPrice.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.0,
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey[500],
                                ),
                              )
                            ],
                          ),
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
