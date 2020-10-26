import 'package:babylandrajkot/components/upsell_card.dart';
import 'package:babylandrajkot/model/product_model.dart';
import 'package:babylandrajkot/screens/item_page.dart';
import 'package:babylandrajkot/service/woocommerce_bridge.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class GetUpsells extends StatefulWidget {
  var item;
  GetUpsells(this.item);
  @override
  _GetUpsellsState createState() => _GetUpsellsState();
}

class _GetUpsellsState extends State<GetUpsells> {
  final List<int> _upsells = [];

  final List<ProductModel> upsellProducts = [];

  bool loadingUpsells = false;

  Future<void> getUpsells() async {
    if (!mounted) return;
    setState(() {
      loadingUpsells = true;
    });
    for (int i = 0; i < widget.item.upsellIds.length; i++) {
      _upsells.add(widget.item.upsellIds[i]);
    }
    String s = _upsells.join(',');
    var responseUpsells = await wooCommerceAPI.getAsync("products?include=$s");
    for (Map i in responseUpsells) {

      upsellProducts.add(ProductModel.fromJson(i));
    }
    // print(upsellProducts);

    if (!mounted) return;
    setState(() {
      loadingUpsells = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getUpsells();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: loadingUpsells
          ? Center(
        child: CupertinoActivityIndicator(),
      )
          : Container(
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: upsellProducts.length,
              itemBuilder: (BuildContext context, int index) {
                print(upsellProducts.length);
                return GestureDetector(
                  onTap: ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ItemPage(upsellProducts[index]))),
                  child: UpsellCard(
                    imgSrc: upsellProducts[index].images[0].src,
                    prodName: upsellProducts[index].name,
                    price: upsellProducts[index].price,
                  ),
                );
              })),
    );
  }
}
