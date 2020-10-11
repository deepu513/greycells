import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greycells/bloc/assessment/assessment_bloc.dart';
import 'package:greycells/bloc/authentication/forgot_password_bloc.dart';
import 'package:greycells/bloc/registration/bloc.dart';
import 'package:greycells/bloc/validation/bloc.dart';
import 'package:greycells/route/route_name.dart';
import 'package:greycells/view/pages/assessment_test_intro_page.dart';
import 'package:greycells/view/pages/assessment_test_page.dart';
import 'package:greycells/view/pages/decider_page.dart';
import 'package:greycells/view/pages/forgot_password_page.dart';
import 'package:greycells/view/pages/login_page.dart';
import 'package:greycells/view/pages/patient_detail_input.dart';
import 'package:greycells/view/pages/patient_score_page.dart';
import 'package:greycells/view/pages/payment_page.dart';
import 'package:greycells/view/pages/register_page.dart';
import 'package:greycells/view/pages/second_test_intro_page.dart';
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
      case RouteName.PATIENT_HOME:
        return MaterialPageRoute(builder: (_) => PatientScorePage());
      case RouteName.FORGOT_PASSWORD:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<ForgotPasswordBloc>(
                create: (_) => ForgotPasswordBloc(),
                child: ForgotPasswordPage()));
      case RouteName.PATIENT_DETAIL_INPUT_PAGE:
        return MaterialPageRoute(builder: (_) => PatientDetailInput());
      case RouteName.ASSESSMENT_TEST_INTRO:
        return MaterialPageRoute(builder: (_) => AssessmentTestIntroPage());
      case RouteName.SECOND_TEST_INTRO:
        return MaterialPageRoute(builder: (_) => SecondTestIntroPage());
      case RouteName.ASSESSMENT_TEST:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<AssessmentBloc>(
                  create: (_) => AssessmentBloc(),
                  child: AssessmentTestPage(args),
                ));
      case RouteName.DECIDER_PAGE:
        return MaterialPageRoute(builder: (_) => DeciderPage());
      case RouteName.PAYMENT_PAGE:
        return MaterialPageRoute(builder: (_) => PaymentPage());
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  // TODO: Make a proper error page
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
