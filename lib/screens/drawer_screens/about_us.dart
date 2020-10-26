import 'package:babyland_optimised/shared/social_media.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Center(
            child: Container(
              height: 100,
              width: 100,
//            color: Colors.red,
              child: Image.asset('assets/babyland.png'),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Babyland',
            style: TextStyle(fontSize: 20),
          ),
          Text('Since 1999'),
          SizedBox(
            height: 20,
          ),
          Card(
            borderOnForeground: true,
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'We believe in innovation. We always bring comfortable, innovative and affordable baby garments and baby products for your cuties.',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(58.0),
                  child: Image.asset(
                    'assets/aboutUs.png',
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                email,
                SizedBox(
                  width: 20,
                ),
                instaIcon,
                SizedBox(
                  width: 20,
                ),
                facebook
              ],
            ),
          )
        ],
      ),
    );
  }
}
