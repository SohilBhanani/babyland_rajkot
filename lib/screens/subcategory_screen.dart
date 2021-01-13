import 'package:babylandrajkot/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woocommerce/models/product_category.dart';

import '../components/category_card.dart';
import '../screens/p_list_screen.dart';
import '../shared/ui_helpers.dart';
import 'cart_screen.dart';

class SubCategoryScreen extends StatelessWidget {
  final int id;
  final String parentName;
  final List<WooProductCategory> subcategory;

  SubCategoryScreen({this.id, this.parentName, this.subcategory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(parentName),
      ),
      body: GridView.builder(
        itemCount: subcategory.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) {
            WooProductCategory subCat = subcategory[index];
            return GestureDetector(
                onTap: (){
                  myNavigation(context, PListScreen(categoryId: subCat.id.toString(),categoryName: subCat.name,));
                },
                child: CategoryCard(name: subCat.name, imgpath: subCat.image.src));
          }),
    );
  }
}
