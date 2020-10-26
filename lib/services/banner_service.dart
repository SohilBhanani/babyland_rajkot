import 'package:firebase_storage/firebase_storage.dart';

class BannerService {

  String image1;
  String image2;
  String image3;

  Future<dynamic> getBannerUrl() async {

    final reference = FirebaseStorage.instance.ref().child('Banners');
    final image1 = await reference.child('1.jpg').getDownloadURL();
    final image2 = await reference.child('2.jpg').getDownloadURL();
    final image3 = await reference.child('3.jpg').getDownloadURL();
    List images = [image1,image2,image3];
    print('Inside Banner Service');
    return images;
  }
}
