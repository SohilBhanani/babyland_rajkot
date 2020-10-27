import 'package:flutter/cupertino.dart';
import 'package:woocommerce/models/products.dart';

import '../models/cart_model.dart';

class CartService with ChangeNotifier {
  List<CartModel> _cart = [];
  List<CartModel> get cart => _cart;

  void addToCart(
      {@required WooProduct product,
      @required String regularPrice,
      @required String salePrice,
      @required String size,
      @required String color,
      @required int quantity}) {
    _cart.add(
      CartModel(
        product: product,
        regularPrice: regularPrice,
        salePrice: salePrice,
        size: size,
        color: color ?? '',
        qty: quantity,
      ),
    );
    notifyListeners();
  }

  clearItem(int index) {
    _cart.removeAt(index);
    notifyListeners();
  }

  clearCart() {
    _cart.clear();
    notifyListeners();
  }

  totalPrice() {
    double sum = 0;
    for (int i = 0; i < _cart.length; i++) {
      String sPrice =
          _cart[i].salePrice == '' ? _cart[i].regularPrice : _cart[i].salePrice;
      double dPrice = double.parse(sPrice);
      sum += dPrice * _cart[i].qty;
      // notifyListeners();
    }
    return sum;
  }

  addQty(index) {
    _cart[index].qty++;
    notifyListeners();
  }

  removeQty(index) {
    _cart[index].qty--;
    if (_cart[index].qty == 0) {
      clearItem(index);
    }
    notifyListeners();
  }

  removeAll() {
    _cart.removeRange(0, _cart.length);
    notifyListeners();
  }
}
