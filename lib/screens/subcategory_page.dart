import 'package:babylandrajkot/components/category_card.dart';
import 'package:babylandrajkot/model/category_model_api.dart';
import 'package:babylandrajkot/screens/product_list.dart';
import 'package:babylandrajkot/service/woocommerce_bridge.dart';
import 'package:flutter/material.dart';

class SubcategoryList extends StatefulWidget {
  final id;
  final name;

  SubcategoryList(this.id,this.name);

  @override
  _SubcategoryListState createState() => _SubcategoryListState();
}

class _SubcategoryListState extends State<SubcategoryList> {
  List<CategoryModel> _subcategories = List<CategoryModel>();
  bool _loading = false;

  Future<Null> getSubCategoryData() async {
    if (!mounted) return;
    setState(() {
      _loading = true;
    });

    final responseData = await wooCommerceAPI
        .getAsync("products/categories?parent=${widget.id}");

    final data = responseData;
    if (!mounted) return;
    setState(() {
      for (Map i in data) {
        _subcategories.add(CategoryModel.fromJson(i));
      }
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loading = true;
    getSubCategoryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0D7591),
        title: Text(widget.name),
      ),
      backgroundColor: Colors.white,
      body: _loading
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/loadingBalloon_cropped.gif')
              ],
            )
          : GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                CategoryModel subcategory = _subcategories[index];

                return GestureDetector(
                    onTap: () =>Navigator.push(context, MaterialPageRoute(builder:(context)=>ProductList(catId: subcategory.id,catName: subcategory.name,))),
                    child: CategoryCard(
                      name: subcategory.name,
                      imgpath: subcategory.image.src,
                    ));
              },
              itemCount: null == _subcategories ? 0 : _subcategories.length,
            ),
    );
  }
}
