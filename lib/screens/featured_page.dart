import 'package:babylandrajkot/components/featured_babywall.dart';
import 'package:babylandrajkot/components/featured_item.dart';
import 'package:babylandrajkot/components/get_featured.dart';
import 'package:babylandrajkot/components/image_carousal.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeaturedPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 22.0),
          child: Text(
            'Hot Picks',
            style: GoogleFonts.abhayaLibre(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.lightBlue[800]),
          ),
        ),
        ImageCarousal(),
        Padding(
          padding: const EdgeInsets.only(left: 22.0),
          child: Text(
            'A Bundle of Joy.',
            style: GoogleFonts.abhayaLibre(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.lightBlue[800]),
          ),
        ),
        Babywall(
          img1: 'assets/baby2.jpg',
          img2: 'assets/baby1.jpg',
          img3: 'assets/baby4.jpg',
          img4: 'assets/baby3.jpg',
          img5: 'assets/baby5.jpeg',
        ),
        SizedBox(
          height: 30,
        ),
        Divider(),
        Center(
          child: Text(
            'New Arrivals',
            style: GoogleFonts.abhayaLibre(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.lightBlue[800]),
          ),
        ),
        Divider(),
        SizedBox(
          height: 300,
          child:GetFeatured(),
        ),
        SizedBox(
          height: 30,
        ),
        Divider(),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Created with ',style: TextStyle(fontSize: 12),),
              Icon(
                Icons.favorite,
                color: Colors.red,
                size: 22,
              ),
              Text(' by ',style: TextStyle(fontSize: 12),),
              Text(
                'Sohil Bhanani',
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),
              ),
            ],
          ),
        )
      ],
    );
  }
}
