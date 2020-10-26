import 'package:babylandrajkot/model/cart_model.dart';
import 'package:babylandrajkot/model/product_model.dart';
import 'package:babylandrajkot/service/auth.dart';
import 'package:flutter/material.dart';
import 'dart:core';

class CartBloc with ChangeNotifier{
  List<CartModel> _cart = [];
  List<CartModel> get cart => _cart;
  var a = AuthService().getCurrentUser();


  void addToCart(ProductModel pro,var size, var color, int q){
        _cart.add(CartModel(pro,size,color,q));
    notifyListeners();
  }

  void clearItem(index){
    _cart.removeAt(index);
    notifyListeners();
  }

  double totalPrice(){
    double sum = 0;
    for(int i=0;i<_cart.length;i++){
    String price = _cart[i].product.salePrice == ""?_cart[i].product.regularPrice:_cart[i].product.salePrice;
      sum += double.parse(price) * _cart[i].qty;
    }
    return sum;
  }

  void addQty(index){
    _cart[index].qty++;
    notifyListeners();
  }

  removeQty(index){
    _cart[index].qty--;
    if(_cart[index].qty==0){
      clearItem(index);
    }
    notifyListeners();
  }

  void removeAll(){
    _cart.removeRange(0, _cart.length);
    notifyListeners();
  }
}