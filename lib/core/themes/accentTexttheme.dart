import 'package:flutter/material.dart';
import 'package:gym_user/core/themes/theme.dart';

TextTheme accentTextTheme() => TextTheme(
      headline6:
          TextStyle(fontSize: 16, fontFamily: 'poppins', color: Colors.white),
      headline5: TextStyle(
          fontFamily: 'poppins',
          color: secondaryColor,
          fontWeight: FontWeight.w500),
      headline4: TextStyle(
          fontFamily: 'poppins',
          color: secondaryColor,
          fontWeight: FontWeight.w500),
      bodyText1: TextStyle(
          fontSize: 12,
          fontFamily: 'poppins',
          color: secondaryColor,
          fontWeight: FontWeight.w300),
      bodyText2: TextStyle(
          fontFamily: 'poppins',
          color: secondaryColor,
          fontSize: 12,
          fontWeight: FontWeight.w300),
      caption: TextStyle(
          fontFamily: 'poppins',
          color: secondaryColor,
          fontWeight: FontWeight.w300),
    );
