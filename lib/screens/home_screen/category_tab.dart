import 'package:babylandrajkot/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woocommerce/woocommerce.dart';

import '../../components/category_card.dart';
import '../../services/woocommerce_service.dart';
import '../../shared/ui_helpers.dart';
import '../p_list_screen.dart';
import '../subcategory_screen.dart';

class CategoryTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('----CategoryTabView---');
    // return FutureBuilder(
    //     future:
    //         Provider.of<WooService>(context, listen: false).getWooPCategory(),
    //     builder: (context, snapshot) {
    //       return snapshot.hasData
    //           ? GridView.builder(
    //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //                   crossAxisCount: 2),
    //               itemCount: snapshot.data.length,
    //               itemBuilder: (context, index) {
    //                 WooProductCategory category = snapshot.data[index];
    //                 return FutureBuilder<List<WooProductCategory>>(
    //                   future: Provider.of<WooService>(context, listen: false)
    //                       .getWooSCategory(category.id),
    //                   builder: (context, subSnapshot) {
    //                     return GestureDetector(
    //                       onTap: () {
    //                         if (subSnapshot.hasData) {
    //                           subSnapshot.data.length > 0
    //                               ? myNavigation(context, SubCategoryScreen(id: category.id,parentName: category.name,subcategory: subSnapshot.data,),)
    //                               : myNavigation(
    //                                   context,
    //                                   PListScreen(
    //                                       categoryId: category.id.toString(),
    //                                       categoryName:
    //                                           snapshot.data[index].name),
    //                                 );
    //                         } else {
    //                           CircularProgressIndicator();
    //                         }
    //                       },
    //                       child: CategoryCard(
    //                         name: category.name,
    //                         imgpath: category.image.src,
    //                       ),
    //                     );
    //                   },
    //                 );
    //               },
    //             )
    //           : Center(child: CircularProgressIndicator());
    //     });
    return FutureBuilder(
        future:
            Provider.of<WooService>(context, listen: false).getWooCategory(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            List<WooProductCategory> category = snapshot.data;
            List<WooProductCategory> onlyCategory =
                category.where((element) => element.parent == 0).toList();
            return GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: onlyCategory.length,
              itemBuilder: (BuildContext context, index) {
                List<WooProductCategory> subCategory = category
                    .where(
                        (element) => element.parent == onlyCategory[index].id)
                    .toList();
                return GestureDetector(
                  onTap: () {
                    subCategory.length > 0
                        ? myNavigation(
                            context,
                            SubCategoryScreen(
                              id: onlyCategory[index].id,
                              parentName: onlyCategory[index].name,
                              subcategory: subCategory,
                            ),
                          )
                        : myNavigation(
                            context,
                            PListScreen(
                                categoryId: onlyCategory[index].id.toString(),
                                categoryName: onlyCategory[index].name),
                          );
                  },
                  child: CategoryCard(
                    imgpath: onlyCategory[index].image.src,
                    name: onlyCategory[index].name,
                  ),
                );
                return Container();
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: kPrim,
            ),
          );
        });
  }
}
