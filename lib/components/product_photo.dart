import '../shared/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woocommerce/models/products.dart';

import 'photo_view.dart';

class ProductPhoto extends StatefulWidget {
  List<String> images;
  ProductPhoto(this.images);
  @override
  _ProductPhotoState createState() => _ProductPhotoState();
}

class _ProductPhotoState extends State<ProductPhoto> {
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    WooProduct product = Provider.of<WooProduct>(context);

    return product.images.length > 0
        ? Row(
            children: <Widget>[
              SizedBox(
                  height: screenHeight(context) * 0.4,
                  width: screenWidth(context) * 0.20,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: widget.images.length,
                            itemBuilder: (context, index) {
                              return AnimatedContainer(
                                margin: EdgeInsets.all(8),
                                height: 80,
                                duration: Duration(milliseconds: 200),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _pageController.animateToPage(index,
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.ease);
                                    });
                                  },
                                  child: ClipRRect(
                                      borderRadius: roundedCorner(12),
                                      child: Image.network(
                                        widget.images[index],
                                        fit: BoxFit.cover,
                                      )),
                                ),
                              );
                            }),
                        // child: ListView(
                        //     children: List<AnimatedContainer>.generate(
                        //   product.images.length,
                        //   (index) => AnimatedContainer(
                        //     margin: EdgeInsets.all(8),
                        //     height: 80,
                        //     duration: Duration(milliseconds: 200),
                        //     child: GestureDetector(
                        //       onTap: () {
                        //         setState(() {
                        //           _pageController.animateToPage(index,
                        //               duration: Duration(milliseconds: 300),
                        //               curve: Curves.ease);
                        //         });
                        //       },
                        //       child: ClipRRect(
                        //           borderRadius: roundedCorner(12),
                        //           child: Image.network(
                        //             product.images[index].src,
                        //             fit: BoxFit.cover,
                        //           )),
                        //     ),
                        //   ),
                        // )),
                      ),
                      Icon(Icons.arrow_drop_down)
                    ],
                  )),
              Stack(
                alignment: Alignment.topRight,
                children: [
                  SizedBox(
                    height: screenHeight(context) * 0.4,
                    width: screenWidth(context) * 0.80,
                    child: PageView.builder(
                        pageSnapping: true,
                        scrollDirection: Axis.vertical,
                        controller: _pageController,
                        itemCount: widget.images.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              myNavigation(context,
                                  MyPhotoView(photo: widget.images[index]));
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              child: ClipRRect(
                                borderRadius: roundedCorner(12),
                                child: Image.network(
                                  widget.images[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  Container(
                    width: 50,
                    child: Column(
                      children: [
                        verticalSpaceSmall,
                        Icon(Icons.arrow_drop_up),
                        Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ],
              )
            ],
          )
        : Container(
            child: Text('Images not Provided'),
          );
  }
}
