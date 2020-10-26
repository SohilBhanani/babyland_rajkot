import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woocommerce/models/products.dart';

import '../../components/baby_wall.dart';
import '../../components/featured_card.dart';
import '../../components/featured_carousel.dart';
import '../../screens/product/product_screen.dart';
import '../../services/woocommerce_service.dart';
import '../../shared/colors.dart';
import '../../shared/ui_helpers.dart';

class FeaturedTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('Featured Tab Rebuild');
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpaceSmall,
          leftPadding(
              left: 8,
              child: Text(
                'Hot Picks',
                style: myTextTheme(context).headline6.apply(color: kPrim),
              )),
          verticalSpaceSmall,
          FeaturedCarousel(),
          verticalSpaceSmall,
          leftPadding(
            left: 8,
            child: Text(
              'A Bundle of Joy',
              style: myTextTheme(context).headline6.apply(color: kPrim),
            ),
          ),
          verticalSpaceSmall,
          Babywall(
            img1: 'assets/baby2.jpg',
            img2: 'assets/baby1.jpg',
            img3: 'assets/baby4.jpg',
            img4: 'assets/baby3.jpg',
            img5: 'assets/baby5.jpeg',
          ),
          verticalSpaceSmall,
          leftPadding(
            left: 8,
            child: Text(
              'New Arrivals',
              style: myTextTheme(context).headline6.apply(color: kPrim),
            ),
          ),
          verticalSpaceSmall,
          Container(
              height: 250,
              child: FutureBuilder(
                  future: Provider.of<WooService>(context).getWooFeatured(),
                  builder: (BuildContext context, snapshot) {
                    return snapshot.hasData
                        ? ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              WooProduct featured = snapshot.data[index];
                              return GestureDetector(
                                onTap: () => myNavigation(
                                  context,
                                  Provider<WooProduct>.value(
                                      value: featured, child: ProductScreen()),
                                ),
                                child: FeaturedCard(
                                  imagepath: featured.images[0].src,
                                  price: featured.salePrice,
                                  title: featured.name,
                                ),
                              );
                            },
                            itemCount: snapshot.data.length,
                          )
                        : Center(child: CircularProgressIndicator());
                  }))
        ],
      ),
    );
  }
}
