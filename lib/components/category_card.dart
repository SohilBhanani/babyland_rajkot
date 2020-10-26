import '../shared/ui_helpers.dart';
import 'package:flutter/material.dart';

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
          borderRadius: roundedCorner(12)),
      elevation: 5,
      child: ClipRRect(
        borderRadius: roundedCorner(12),
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
                        style:myTextTheme(context).bodyText1,
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