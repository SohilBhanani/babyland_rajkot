import 'package:babylandrajkot/components/image_view.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class ItemCarousal extends StatelessWidget {
  final String _image1;
  final String _image2;
  final String _image3;


  ItemCarousal(this._image1, this._image2, this._image3);

  @override
  Widget build(BuildContext context) {
    final List<String> images = [_image1,_image2,_image3];

    return Container(
      height: 300,
      color: Colors.transparent,
      padding: EdgeInsets.all(18.0),
      child: Swiper(
          onTap: (index) {
            print('${images[index]}');
          return Navigator.push(context, MaterialPageRoute(builder:(context)=>ImageView(images[index])));
          } ,
          itemCount: images.length,
          autoplay: true,
          autoplayDelay: 6000,
          itemWidth: 380,
          layout: SwiperLayout.STACK,
          itemBuilder: (BuildContext context, int index) {
            return
               ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                 child:FadeInImage.assetNetwork(
                   placeholder: "assets/ripple.gif",
                   placeholderScale: 2,
                   image: images[index],
                   fit: BoxFit.cover,
                 ),
            );
          },
        ),

    );
  }
}
