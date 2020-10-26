import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class MyPhotoView extends StatelessWidget {
  final String photo;

  MyPhotoView({this.photo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PhotoView(
        imageProvider: NetworkImage(photo),
        // minScale: 0.5,
        maxScale: 2.0,

      ),
    );
  }
}
