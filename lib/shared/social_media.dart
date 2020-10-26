import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:url_launcher/url_launcher.dart';

IconButton instaIcon = IconButton(
  icon: Icon(
    Boxicons.bxl_instagram,
    size: 30,
    color: Color(0xff8ACADF),
  ),
  onPressed: () async {
    const url = 'https://instagram.com/babyland_rajkot?igshid=1493de0xz2quo';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  },
);

IconButton facebook = IconButton(
  icon: Icon(
    Boxicons.bxl_facebook,
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
    Boxicons.bx_envelope,
    size: 30,
    color: Color(0xff8ACADF),
  ),
  onPressed: () {
    launch(Uri(
        scheme: 'mailto',
        path: 'babylandrajkot@gmail.com',
        queryParameters: {'subject': 'App:Inquiry'}).toString());
  },
);
