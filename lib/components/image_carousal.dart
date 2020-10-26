import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class ImageCarousal extends StatefulWidget {


  @override
  _ImageCarousalState createState() => _ImageCarousalState();
}

class _ImageCarousalState extends State<ImageCarousal> {
  var img1;
  var img2;
  var img3;
  var lg = 'https://firebasestorage.googleapis.com/v0/b/babylandrajkot-4f85c.appspot.com/o/babyland.png?alt=media&token=254ac252-46ff-47d8-b72f-5156310af47f';
  Future<void> getURL() async {
    var result1 = await FirebaseStorage.instance.ref().child('Banners').child('1.jpg').getDownloadURL();
    var result2 = await FirebaseStorage.instance.ref().child('Banners').child('2.jpg').getDownloadURL();
    var result3 = await FirebaseStorage.instance.ref().child('Banners').child('3.jpg').getDownloadURL();
    var logo = await FirebaseStorage.instance.ref().child('babyland.png').getDownloadURL();
//    print(result);
    if (!mounted) return;
    setState(() {
      img1 = result1;
      img2 = result2;
      img3 = result3;
      lg = logo;
    });

  }

  @override
  Widget build(BuildContext context) {
//    final List<String> images = [img1, widget._image2, widget._image3];
    final List<String> images = [img1, img2, img3];
    getURL();
    return Container(
      height: 300,
      color: Colors.transparent,
      padding: EdgeInsets.all(18.0),
      child: Swiper(
        itemCount: images.length,
        autoplay: true,
        autoplayDelay: 6000,
        itemWidth: 380,
        layout: SwiperLayout.STACK,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: FadeInImage.assetNetwork(
                placeholder: "assets/ripple.gif",
                placeholderScale: 2,
                image: images[index]==null?lg:images[index],
                fit: BoxFit.cover,
              ));
        },
      ),
    );
  }
}
