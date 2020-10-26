import 'package:babyland_optimised/components/category_card.dart';
import 'package:babyland_optimised/screens/p_list_screen.dart';
import 'package:babyland_optimised/shared/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:woocommerce/models/product_category.dart';

class SubCategoryScreen extends StatelessWidget {
  final int id;
  final String parentName;
  final List<WooProductCategory> subcategory;

  SubCategoryScreen({this.id, this.parentName, this.subcategory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(parentName)),
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
