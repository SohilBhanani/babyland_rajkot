import 'package:babyland_optimised/shared/colors.dart';
import 'package:flutter/material.dart';

ThemeData babyTheme() => ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: kPrim,
      accentColor: kSec,
      fontFamily: 'Lato',
      textTheme: const TextTheme(
        headline1: const TextStyle(
          fontSize: 28,
          fontFamily: 'Pacifico',
        ),
        headline3: const TextStyle(
          fontSize: 28,
          fontFamily: 'Lato',
          fontWeight: FontWeight.bold,
        ),
        headline5: const TextStyle(
          fontSize: 24,
          fontFamily: 'Lato',
        ),
        headline6: const TextStyle(
          fontFamily: 'Lato',
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        bodyText1: const TextStyle(fontFamily: 'Lato', fontSize: 18),
        button: const TextStyle(
          fontFamily: 'Lato',
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
