import 'package:woocommerce/woocommerce.dart';
import '../woocommerce_api.dart';

class WooService {
  List<WooProductCategory> pCategories;

  List<WooProductCategory> sCategories;

  List<WooProduct> products;

  List<WooProduct> featuredProducts;

  List<WooProductVariation> variables;

  getWooPCategory() async {
    try {
      pCategories = await woo.getProductCategories(perPage: 75, parent: 0);
      return pCategories;
    } catch (e) {
      print('Error in getWooPCategory: ' + e.toString());
      return [];
    }
  }

  Future<List<WooProductCategory>> getWooSCategory(int parentId) async {
    try {
      sCategories =
          await woo.getProductCategories(perPage: 50, parent: parentId);
      return sCategories;
    } catch (e) {
      print('Error in getWooSCategory: ' + e.toString());
      return [];
    }
  }

  getWooProducts(String categoryId) async {
    try {
      products = await woo.getProducts(category: categoryId);
      return products;
    } catch (e) {
      print('error in getWooProducts: $e');
      return [];
    }
  }

  getWooUpsells(List<int> ids) async {
    List upsells;
    List<WooProduct> upsellp = [];
    // print(ids);
    try {
      String upsellCSV = ids.join(',');

      upsells = await woo.get("products?include=$upsellCSV");
      // upsells = await woo.get("products/47");

      for (Map i in upsells) {
        upsellp.add(WooProduct.fromJson(i));
      }
      // print(upsellp.length);
      return upsellp;
    } catch (e) {
      print('error in getWooUpsells: $e');
      return [];
    }
  }

  getWooFeatured() async {
    try {
      featuredProducts = await woo.getProducts(featured: true);
      return featuredProducts;
    } catch (e) {
      print('Error in getWooFeatured: $e');
      return [];
    }
  }

  Future<List<WooProductVariation>> getWooVariable(int productId) async {
    try {
      List<WooProductVariation> variables =
          await woo.getProductVariations(productId: productId);
      return variables;
    } catch (e) {
      print('Error in getWooVariable: $e');
      return [];
    }
  }
}
