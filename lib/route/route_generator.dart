import 'package:flutter/material.dart';
import 'package:mental_health/route/route_name.dart';
import 'package:mental_health/view/pages/forgot_password_page.dart';
import 'package:mental_health/view/pages/home_page.dart';
import 'package:mental_health/view/pages/login_page.dart';
import 'package:mental_health/view/pages/register_page.dart';
import 'package:mental_health/view/pages/welcome_page.dart';

class RouteGenerator {
  static const double kDefaultDuration = .30;
  static const Curve kDefaultEaseFwd = Curves.easeOut;
  static const Curve kDefaultEaseReverse = Curves.easeOut;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case RouteName.INITIAL:
        return MaterialPageRoute(builder: (_) => WelcomePage());
      case RouteName.LOGIN:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case RouteName.REGISTER:
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case RouteName.HOME:
        return MaterialPageRoute(builder: (_) => HomePage());
      case RouteName.FORGOT_PASSWORD:
        return MaterialPageRoute(builder: (_) => ForgotPasswordPage());

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
