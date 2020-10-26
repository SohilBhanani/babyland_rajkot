import 'package:woocommerce/models/products.dart';

class CartModel {
  WooProduct product;
  String regularPrice;
  String salePrice;
  String size;
  String color;
  int qty;
  CartModel(
      {this.product,
      this.regularPrice,
      this.salePrice,
      this.size,
      this.color,
      this.qty});
}
