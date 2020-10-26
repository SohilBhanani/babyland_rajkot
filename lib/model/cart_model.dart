import 'package:babylandrajkot/model/product_model.dart';

class CartModel{
  ProductModel product;
  var size;
  var color;
  int qty;
  CartModel(this.product,this.size,this.color,this.qty);
}