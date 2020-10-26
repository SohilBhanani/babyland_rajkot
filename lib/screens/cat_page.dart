import 'package:babylandrajkot/components/category_card.dart';
import 'package:babylandrajkot/components/loading_component.dart';
import 'package:babylandrajkot/screens/product_list.dart';
import 'package:babylandrajkot/screens/subcategory_page.dart';
import 'package:babylandrajkot/service/woocommerce_bridge.dart';
import 'package:flutter/material.dart';
import 'package:woocommerce/models/product_category.dart';

class WooCategoryPage extends StatefulWidget {
  @override
  _WooCategoryPageState createState() => _WooCategoryPageState();
}

class _WooCategoryPageState extends State<WooCategoryPage> {
  List<WooProductCategory> _categories = List<WooProductCategory>();
  List<WooProductCategory> _parentcategories = List<WooProductCategory>();
  List<WooProductCategory> _subcategories = List<WooProductCategory>();

  getCat() async {

    try {
      _parentcategories =
      await woo.getProductCategories(perPage: 30, parent: 0);
      _categories = await woo.getProductCategories(perPage: 30);
    }catch(e){
      print('Following Error Occured: '+ e.toString());

    }
    if (!mounted) return;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCat();
  }

  @override
  Widget build(BuildContext context) {
    return _parentcategories.length == 0
        ? Scaffold(
            body: LoadingComponent(),
          )
        : GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  _subcategories = _categories
                      .where((category1) =>
                          category1.parent == _categories[index].id)
                      .toList();
                  print(_subcategories.length);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => _subcategories.length==0?ProductList(
                        catId: _parentcategories[index].id,
                        catName: _parentcategories[index].name,
                      ):SubcategoryList(_parentcategories[index].id, _parentcategories[index].name),
                    ),
                  );
                },
                child: CategoryCard(name: _parentcategories[index].name,imgpath: _parentcategories[index].image.src,),
              );
            },
            itemCount: _parentcategories.length,
          );
  }
}
