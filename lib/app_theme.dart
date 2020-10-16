import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static Color _iconColor = Colors.redAccent.shade200;

  static const Color primaryColor = Color(0xFFFCC03B);
  static const Color primaryVariantColor = Colors.white;
  static const Color secondaryColor = Color(0xFFf50057);
  static const Color onPrimaryColor = Colors.black;
  static const Color appBarColor = Colors.white;

  static final ThemeData lightTheme = ThemeData(
    snackBarTheme: SnackBarThemeData(behavior: SnackBarBehavior.floating),
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Lato',
    accentColorBrightness: Brightness.dark,
    canvasColor: Colors.transparent,
    bottomSheetTheme: BottomSheetThemeData(modalBackgroundColor: Colors.white),
    splashFactory: InkRipple.splashFactory,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      iconTheme: IconThemeData(color: onPrimaryColor),
      brightness: Brightness.light,
      color: appBarColor,
    ),
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      primaryVariant: Colors.white,
      secondary: secondaryColor,
      onPrimary: onPrimaryColor,
    ),
    iconTheme: IconThemeData(
      color: _iconColor,
    ),
    textTheme: _textTheme,
  );

  static final TextTheme _textTheme = TextTheme(
    headline1: _headingStyle,
  );

  static final TextStyle _headingStyle =
      TextStyle(fontSize: 48.0, letterSpacing: 1.2, color: onPrimaryColor);
}
