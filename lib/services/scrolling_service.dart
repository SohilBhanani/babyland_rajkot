import 'dart:async';

import 'package:woocommerce/models/products.dart';

import '../woocommerce_api.dart';

Future<List<WooProduct>> _getProductData(String catId, int page) async {
  return await woo.getProducts(category: catId, page: page);
}

class ScrollingService {
  Stream<List<WooProduct>> stream;
  bool hasMore;

  bool _isLoading;
  List<WooProduct> _data;
  StreamController<List<WooProduct>> _controller;
  int page;
  String catId;

  ScrollingService(this.catId) {
    _data = List<WooProduct>();
    _controller = StreamController<List<WooProduct>>.broadcast();
    _isLoading = false;
    page = 1;

    stream = _controller.stream;
    hasMore = true;
    refresh();
  }

  Future<void> refresh() {
    return loadMore(clearCachedData: true);
  }

  Future<void> loadMore({bool clearCachedData = false}) {
    if (clearCachedData) {
      _data = List<WooProduct>();
      hasMore = true;
      page = 1;
    }
    if (_isLoading || !hasMore) {
      return Future.value();
    }
    _isLoading = true;

    return _getProductData(catId, page).then((value) {
      _isLoading = false;
      page++;
      _data.addAll(value);
      hasMore = (value.length >= 10);
      // hasMore = (_data.length < 30);
      _controller.add(_data);
    });
  }
}
