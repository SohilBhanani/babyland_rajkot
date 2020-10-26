import 'package:babylandrajkot/components/featured_item.dart';
import 'package:babylandrajkot/model/product_model.dart';
import 'package:babylandrajkot/screens/item_page.dart';
import 'package:babylandrajkot/service/woocommerce_bridge.dart';
import 'package:flutter/material.dart';

class GetFeatured extends StatefulWidget {


  @override
  _GetFeaturedState createState() => _GetFeaturedState();
}

bool loadingFeatured = false;

class _GetFeaturedState extends State<GetFeatured> {
  var responseProducts;
  List<ProductModel> _featuredItems = [];

  bool loading = false;

  Future<Null> getFeaturedItem() async {
    responseProducts = await wooCommerceAPI.getAsync("products?featured=true");
    if (!mounted) return;
    setState(() {
      loading = true;
      for (Map i in responseProducts) {
        _featuredItems.add(ProductModel.fromJson(i));
      }
      loading = false;
//      products.add(json.decode(response));
    });
  }

  @override
  void initState() {
    loading = true;
    getFeaturedItem();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
//      itemExtent: 32,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemPage(_featuredItems[index]))),
          child: FeaturedItem(
            color: Color(0xff8ACADF),
            title: _featuredItems[index].name,
            price: _featuredItems[index].regularPrice,
            imagepath: _featuredItems[index].images[0].src,
          ),
        );
      },
      itemCount: _featuredItems.length,
    );
  }
}
