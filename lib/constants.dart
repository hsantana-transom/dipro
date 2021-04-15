import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// Padding
const double paddingZero = 0.0;
const double paddingXS = 2.0;
const double paddingS = 4.0;
const double paddingM = 8.0;
const double paddingL = 16.0;
const double paddingXL = 32.0;
const double paddingXXL = 48.0;
// Margin
const double marginZero = 0.0;
const double marginXS = 2.0;
const double marginS = 4.0;
const double marginM = 8.0;
const double marginL = 16.0;
const double marginXL = 32.0;
const double marginXXL = 48.0;
// Spacing
const double spaceXS = 2.0;
const double spaceS = 4.0;
const double spaceM = 8.0;
const double spaceL = 16.0;
const double spaceXL = 32.0;
const double spaceXXL = 48.0;
// Radius
const double radiusXS = 2.0;
const double radiusS = 4.0;
const double radiusM = 8.0;
const double radiusL = 16.0;
const double radiusXL = 32.0;
const double radiusXXL = 48.0;
// Assets
const String imagesPath = 'assets/images/';
//MaterialTheme of the app
ThemeData customThemeData = ThemeData(
  primarySwatch: Colors.red,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(),
    errorStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
  ),
  appBarTheme: AppBarTheme(
    elevation: 0,
    color: Colors.transparent,
  ),
  textTheme: TextTheme(
    headline1: GoogleFonts.quicksand(),
    headline2: GoogleFonts.quicksand(),
    headline3: GoogleFonts.quicksand(),
    headline4: GoogleFonts.openSans(fontWeight: FontWeight.w700),
    headline5: GoogleFonts.openSans(fontWeight: FontWeight.w700),
    headline6: GoogleFonts.openSans(fontWeight: FontWeight.w700),
    subtitle1: GoogleFonts.quicksand(fontWeight: FontWeight.bold),
    subtitle2: GoogleFonts.quicksand(),
    bodyText1: GoogleFonts.quicksand(),
    bodyText2: GoogleFonts.quicksand(),
    caption: GoogleFonts.quicksand(),
    button: GoogleFonts.openSans(fontWeight: FontWeight.w700),
  ),
);
