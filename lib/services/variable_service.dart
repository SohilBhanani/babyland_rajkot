import 'package:flutter/material.dart';
import 'package:woocommerce/models/product_variation.dart';
import 'package:woocommerce/models/products.dart';

import '../services/woocommerce_service.dart';

class VariableService with ChangeNotifier {
  List<WooProductVariation> variationList = [];
  String regularPrice = '';
  String salePrice = '';

  String size = '';

  String sizeForColor = '';
  List<String> colors = [];
  List<DropdownMenuItem> colorItems = [];

  String currentColor;
  String currentSize;

  String varImage = '';
  List<String> images;

  String stockStatus = '';

  Future<List<WooProductVariation>> getVariations(WooProduct product) async {
    try {
      variationList = await WooService().getWooVariable(product.id);
      images = List<String>.generate(
          product.images.length, (index) => product.images[index].src);
      print("THis iss ssd" + variationList[0].toString());
      return variationList;
    } catch (e) {
      print('Error in Variable Service: $e');
      return [];
    }
  }

  String get statusString {
    switch (stockStatus) {
      case 'outofstock':
        return 'Currently Out of Stock';
        break;
      case 'instock':
        return 'In Stock';
        break;
      default:
        return '';
    }
  }

  resetPriceAndColor() {
    regularPrice = '';
    salePrice = '';
    currentColor = null;
    notifyListeners();
  }

  updateValue(String regular, String sale) {
    regularPrice = regular;
    notifyListeners();
    salePrice = sale;
    notifyListeners();
  }

  updateColorValue(String color) {
    colors.add(color);
    notifyListeners();
  }

  clearColorItem() {
    colors.clear();
    notifyListeners();
    colorItems.clear();
    sizeForColor = '';
    notifyListeners();
  }

  generateColorItems() {
    colorItems = colors
        .map((color) => DropdownMenuItem(
              child: Text(color),
              value: color,
            ))
        .toList();
    notifyListeners();
  }

  getImages({String size, String color, WooProductVariation i}) {
    if (i.attributes.length == 1) {
      if (i.attributes[0].option == size) varImage = i.image.src;
      notifyListeners();
    } else if (i.attributes.length == 2) {
      if ((i.attributes[0].option == size && i.attributes[1].option == color) ||
          (i.attributes[1].option == size && i.attributes[0].option == color)) {
        varImage = i.image.src;
        notifyListeners();
      }
    }
  }

  sizeChanged({String ksize}) async {
    sizeForColor = ksize;
    for (WooProductVariation i in variationList) {
      if (i.attributes.length == 1) {
        if (i.attributes[0].option == ksize) {
          print("variable_serviceee----" + i.image.name.toString());
          varImage = i.image.src;
          notifyListeners();
          stockStatus = i.stockStatus;
          notifyListeners();
          updateValue(i.regularPrice, i.salePrice);
        }
      } else if (i.attributes.length == 2) {
        if (i.attributes[0].option == ksize) {
          updateColorValue(i.attributes[1].option);
          generateColorItems();
        } else if (i.attributes[1].option == ksize) {
          updateColorValue(i.attributes[0].option);
          generateColorItems();
        }
      }
    }
  }

  colorChanged(String color) {
    print('$currentColor and $currentSize');
    for (WooProductVariation i in variationList) {
      if (i.attributes.length == 2) {
        if (i.attributes[0].option == sizeForColor &&
            i.attributes[1].option == color) {
          stockStatus = i.stockStatus;
          notifyListeners();
          updateValue(i.regularPrice, i.salePrice);
        } else if (i.attributes[1].option == sizeForColor &&
            i.attributes[0].option == color) {
          stockStatus = i.stockStatus;
          notifyListeners();
          updateValue(i.regularPrice, i.salePrice);
        }
      }

      getImages(color: currentColor, size: currentSize, i: i);
    }
  }
}
