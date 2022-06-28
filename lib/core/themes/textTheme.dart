import 'package:flutter/material.dart';
import 'package:gym_user/core/themes/theme.dart';

TextTheme texttheme() => TextTheme(
      headline6: TextStyle(
          fontFamily: 'poppins',
          color: primaryColor,
          fontSize: 16,
          fontWeight: FontWeight.w600),
      headline5: TextStyle(
          fontFamily: 'poppins',
          color: primaryColor,
          // fontSize: 14,
          fontWeight: FontWeight.w600),
      headline4: TextStyle(
          fontFamily: 'poppins',
          color: primaryColor,
          fontWeight: FontWeight.bold),
      bodyText1: TextStyle(
          fontFamily: 'poppins',
          color: primaryColor,
          fontSize: 12,
          fontWeight: FontWeight.w100),
      bodyText2: TextStyle(
          fontFamily: 'poppins',
          color: Colors.blue,
          // fontSize: 12,
          fontWeight: FontWeight.w100),
      subtitle2: TextStyle(
          fontFamily: 'poppins',
          color: bodyText2,
          // fontSize: 10,
          fontWeight: FontWeight.w500),
      subtitle1: TextStyle(
          fontFamily: 'poppins',
          // fontSize: 11,
          color: bodyText2,
          fontWeight: FontWeight.w500),
      caption: TextStyle(
          fontFamily: 'poppins', fontSize: 10, fontWeight: FontWeight.w700),
    );
