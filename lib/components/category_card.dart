import 'package:babylandrajkot/model/category_model_api.dart';
import 'package:flutter/material.dart';
import 'package:woocommerce/models/product_category.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key key,
    @required this.name,
    @required this.imgpath,
  }) : super(key: key);



//  final CategoryModel category;
  final String name;
  final String imgpath;


  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0)),
      elevation: 5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18.0),
        child: Container(
            child: Column(
              children: <Widget>[
                Expanded(
                    flex: 3,
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/ripple.gif',
//                      image: category.image.src,
                      image: imgpath,
                      fit: BoxFit.cover,
                    )),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.white,
                    child: Align(
                      alignment: AlignmentDirectional.center,
                      child: Text(
                        name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}