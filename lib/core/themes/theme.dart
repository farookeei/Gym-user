import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'accentTexttheme.dart';
import 'primaryTextTheme.dart';
import 'textTheme.dart';

final scaffoldSecondaryColor = Color.fromRGBO(246, 246, 246, 1);

final secondaryColor = getThemeIntFromEnv("SECONDARY_COLOR");
final primaryColor = getThemeIntFromEnv("PRIMARY_COLOR");
final bodyText2 = getThemeIntFromEnv("BODYTEXT2");
final textformfieldfillcolor = getThemeIntFromEnv('PRIMARY_INPUT_BG');
final textformfieldShadowcolor = getThemeIntFromEnv('PRIMARY_INPUT_SHADOW');

final scaffoldBg = getThemeIntFromEnv('SCAFFOLD_BG');
final shimmerLine = getThemeIntFromEnv("SHIMMERLINE");
final dangerColor = Colors.red;

final changeBtn = getThemeIntFromEnv("CHANGEBUTTON");
final timerGGradient1 = getThemeIntFromEnv("TIMERGRADIENT1");
final successColor = getThemeIntFromEnv("SUCCESSCOLOR");
final courseItemShadow = getThemeIntFromEnv("COURSEITEMSHADOW");
final basicShadow = [
  BoxShadow(
    color: textformfieldShadowcolor,
    blurRadius: 20,
    spreadRadius: 0,
    offset: const Offset(0, 4),
  ),
];

//* Many containers have same design
// var globalMargin = const EdgeInsets.symmetric(vertical: 10);
// var globalPadding = const EdgeInsets.symmetric(
//   vertical: 15,
//   horizontal: 15,
// );
// var globalBorderRadius = BorderRadius.circular(10);

getThemeIntFromEnv(String envTitle) {
  if (dotenv.env['$envTitle'].toString().length < 7)
    return Color(int.parse('0xFF${dotenv.env['$envTitle']}'));
  else
    return Color(int.parse('0x${dotenv.env['$envTitle']}'));
}

ThemeData themes() {
  return ThemeData(
    primarySwatch: Colors.blue,
    primaryTextTheme: primaryTextTheme(),
    accentTextTheme: accentTextTheme(),
    textTheme: texttheme(),
    // primaryColor: primaryColor,
    primaryColor: changeBtn,

    accentColor: secondaryColor,
    scaffoldBackgroundColor: scaffoldBg,
    // appBarTheme: appBarTheme()
  );
}
