import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants/app_colors.dart';

ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(color: Colors.black),
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent),
    iconTheme: IconThemeData(color: kContentColorLightTheme),
    textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context)
            .textTheme
            .copyWith(bodyText1: TextStyle(letterSpacing: 0.8, height: 1.4)))
        .apply(
      bodyColor: kContentColorLightTheme,
    ),
    colorScheme: ColorScheme.light(
      primary: kPrimaryColor,
      secondary: kSecondaryColor,
      error: kErrorColor,
    ),
    inputDecorationTheme:
        InputDecorationTheme(hintStyle: TextStyle(color: Colors.black)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: kContentColorLightTheme.withOpacity(0.7),
      unselectedItemColor: kContentColorLightTheme.withOpacity(0.32),
      selectedIconTheme: IconThemeData(color: kPrimaryColor),
      showUnselectedLabels: true,
    ),
  );
}

ThemeData darkThemeData(BuildContext context) {
  // Bydefault flutter provie us light and dark theme
  // we just modify it as our need
  return ThemeData.dark().copyWith(
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: kContentColorLightTheme,
    appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(color: Colors.white),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent),
    iconTheme: IconThemeData(color: kContentColorDarkTheme),
    textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme)
        .apply(bodyColor: kContentColorDarkTheme),
    colorScheme: ColorScheme.dark().copyWith(
      primary: kPrimaryColor,
      secondary: kSecondaryColor,
      error: kErrorColor,
    ),
    inputDecorationTheme:
        InputDecorationTheme(hintStyle: TextStyle(color: Color(0xFF121212))),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: kContentColorLightTheme,
      selectedItemColor: Colors.white70,
      unselectedItemColor: kContentColorDarkTheme.withOpacity(0.32),
      selectedIconTheme: IconThemeData(color: kPrimaryColor),
      showUnselectedLabels: true,
    ),
  );
}
