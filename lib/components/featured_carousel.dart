import '../services/banner_service.dart';
import '../shared/ui_helpers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeaturedCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('Featured Carousal');

    List<Container> imageList(List images) => [
          Container(
            width: double.infinity,
            child: ClipRRect(
                borderRadius: roundedCorner(8),
                child: Image.network(
                  images[0],
                  fit: BoxFit.cover,
                )),
          ),
          Container(
            width: double.infinity,
            child: ClipRRect(
                borderRadius: roundedCorner(8),
                child: Image.network(
                  images[1],
                  fit: BoxFit.cover,
                )),
          ),
          Container(
            width: double.infinity,
            child: ClipRRect(
                borderRadius: roundedCorner(8),
                child: Image.network(
                  images[2],
                  fit: BoxFit.cover,
                )),
          ),
        ];

    return FutureBuilder(

      future: Provider.of<BannerService>(context, listen: false)
          .getBannerUrl(),
      builder: (BuildContext context, snapshot) {
        List images = snapshot.data;
        return snapshot.hasData
            ? CarouselSlider(
                items: imageList(images),
                options: CarouselOptions(
                    autoPlay: true,
                    autoPlayAnimationDuration: Duration(seconds: 2),
                    pageSnapping: true,
                    pauseAutoPlayOnTouch: true,
                    height: 250,
                    enlargeCenterPage: true),
              )
            : Center(heightFactor: 7, child: CircularProgressIndicator());
      },
    );
  }
}
