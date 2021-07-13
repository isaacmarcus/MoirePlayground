import 'package:flutter/material.dart';
import 'package:moire_app/screens/moire_page.dart';

const kScreenTitlePadding = EdgeInsets.all(15);
const kMasterPaddingL = EdgeInsets.all(60);
const kMasterPaddingS = EdgeInsets.all(28);
const kAppBarHeightL = Size.fromHeight(100);
const kAppBarHeightS = Size.fromHeight(60);
const kSymPadLarge = EdgeInsets.symmetric(horizontal: 60);
const kSymPadSmall = EdgeInsets.symmetric(horizontal: kSymPadValueS);
const double kSymPadValueS = 28;
const double kSymPadValueL = 60;

const kMenuTitles = [
  ['RESET', MoirePage.id],
];

ThemeData themeData = ThemeData(
  fontFamily: "RobotoMono",
  canvasColor: Color(0xff393e46),
  scaffoldBackgroundColor: Color(0xff393e46),
  primaryColor: Color(0xff393e46),
  primaryColorLight: Color(0xFFaad8d3),
  accentColor: Color(0xFF00adb5),
  errorColor: Color(0xFFFF6933),
  backgroundColor: Color(0xFFeeeeee),
  cardColor: Colors.white,
  textTheme: TextTheme(
    headline1: TextStyle(
      color: Color(0xFFeeeeee),
      fontSize: 55,
      fontWeight: FontWeight.w500,
    ),
    headline2: TextStyle(
      color: Color(0xFFeeeeee),
      fontSize: 40,
      fontWeight: FontWeight.w500,
    ),
    headline3: TextStyle(
      color: Color(0xFFeeeeee),
      fontSize: 25,
      fontWeight: FontWeight.w500,
    ),
    headline5: TextStyle(
      color: Color(0xFFeeeeee),
      fontSize: 18,
      fontWeight: FontWeight.w200,
    ),
    bodyText1: TextStyle(
      color: Color(0xFFeeeeee),
      fontSize: 16,
      fontWeight: FontWeight.w100,
    ),
  ),
);
