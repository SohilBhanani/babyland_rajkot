import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  final String image;

  ImageView(this.image);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: InteractiveViewer(
        panEnabled: true,
        boundaryMargin: EdgeInsets.all(100),
        minScale: 1,
        maxScale: 2.5,
        child: Image.network(image),
      ),
    ));
  }
}
