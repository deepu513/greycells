import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color primaryColor = Colors.blue;
  static const Color primaryVariantColor = Colors.blue;
  static const Color secondaryColor = Color(0xFF455a64);
  static const Color onPrimaryColor = Colors.black87;
  static const Color onSecondaryColor = Colors.white;
  static const Color appBarColor = Colors.white;
  static const Color iconColor = Colors.pink;

  static final ThemeData lightTheme = ThemeData(
    snackBarTheme: SnackBarThemeData(behavior: SnackBarBehavior.floating),
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Lato',
    accentColorBrightness: Brightness.dark,
    canvasColor: Colors.white,
    bottomSheetTheme: BottomSheetThemeData(modalBackgroundColor: Colors.white),
    splashFactory: InkRipple.splashFactory,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: AppBarTheme(
      elevation: 4.0,
      iconTheme: IconThemeData(color: Colors.black87),
      brightness: Brightness.light,
      color: appBarColor,
    ),
    colorScheme: ColorScheme.light(
        primary: primaryColor,
        primaryVariant: primaryVariantColor,
        secondary: secondaryColor,
        onPrimary: onPrimaryColor,
        onSecondary: onSecondaryColor),
    iconTheme: IconThemeData(
      color: iconColor,
    ),
  );
}
