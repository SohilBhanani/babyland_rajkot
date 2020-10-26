import 'package:babyland_optimised/services/woocommerce_service.dart';
import 'package:flutter/widgets.dart';
import 'package:woocommerce/models/products.dart';

import '../shared/ui_helpers.dart';
import '../woocommerce_api.dart';

class PaginationService extends ChangeNotifier {
  static const int ItemRequestThreshold = 10;

  List<WooProduct> _items;
  List<WooProduct> get items => _items;

  int _currentPage = 0;

  // HomeViewModel() {
  //   _items = List<String>.generate(15, (index) => 'Title $index');
  // }

  getProducts(String categoryId) async {
    try {
      _items = await WooService().getWooProducts(categoryId);
      return _items;
    } catch (e) {
      print('Error in getProducts of pagination $e');
      return [];
    }
  }

  Future handleItemCreated(int index, String categoryId) async {
    var itemPosition = index + 1;
    var requestMoreData =
        itemPosition % ItemRequestThreshold == 0 && itemPosition != 0;
    var pageToRequest = itemPosition ~/ ItemRequestThreshold;

    if (requestMoreData && pageToRequest > _currentPage) {
      print('handleItemCreated | pageToRequest: $pageToRequest');
      _currentPage = pageToRequest;
      // _showLoadingIndicator();

      // await Future.delayed(Duration(seconds: 5));
      // var newFetchedItems = List<String>.generate(
      //     15, (index) => 'Title page:$_currentPage item: $index');
      List<WooProduct> newFetchedItems = await woo.getProducts(
        category: categoryId,
        page: _currentPage,
      );
      _items.addAll(newFetchedItems);

      // _removeLoadingIndicator();
    }
  }

  // void _showLoadingIndicator() {
  //   _items.add(LoadingIndicatorTitle);
  //   notifyListeners();
  // }

  // void _removeLoadingIndicator() {
  //   _items.remove(LoadingIndicatorTitle);
  //   notifyListeners();
  // }
}
