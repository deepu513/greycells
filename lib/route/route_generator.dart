import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greycells/bloc/registration/bloc.dart';
import 'package:greycells/bloc/validation/bloc.dart';
import 'package:greycells/route/route_name.dart';
import 'package:greycells/view/pages/forgot_password_page.dart';
import 'package:greycells/view/pages/home_page.dart';
import 'package:greycells/view/pages/login_page.dart';
import 'package:greycells/view/pages/register_page.dart';
import 'package:greycells/view/pages/welcome_page.dart';

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
        return MaterialPageRoute(
            builder: (_) => LoginPage(
                  shouldShowRegistrationSuccessfulMessage: args ?? false,
                ));
      case RouteName.REGISTER:
        return MaterialPageRoute(
            builder: (context) => BlocProvider<RegistrationBloc>(
                create: (_) => RegistrationBloc(ValidationBloc()),
                child: RegisterPage()));
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
