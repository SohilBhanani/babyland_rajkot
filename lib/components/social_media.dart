import 'package:boxicons_flutter/boxicons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

IconButton instaIcon = IconButton(
  icon: Icon(
    Boxicons.bxlInstagram,
    size: 30,
    color: Color(0xff8ACADF),
  ),
  onPressed: () async {
    const url =
        'https://instagram.com/babyland_rajkot?igshid=1493de0xz2quo';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  },
);

IconButton facebook = IconButton(
  icon: Icon(
    Boxicons.bxlFacebook,
    size: 30,
    color: Color(0xff8ACADF),
  ),
  onPressed: () async {
    const url = 'https://www.facebook.com/208338539376760/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  },
);

IconButton email = IconButton(
  icon: Icon(
    Boxicons.bxEnvelope,
    size: 30,
    color: Color(0xff8ACADF),
  ),
  onPressed: () {
    launch(Uri(
        scheme: 'mailto',
        path: 'babylandrajkot@gmail.com',
        queryParameters: {'subject': 'App:Inquiry'})
        .toString());
  },
);