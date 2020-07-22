import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health/app_theme.dart';
import 'package:mental_health/bloc/authentication/bloc.dart';
import 'package:mental_health/bloc/validation/validation_bloc.dart';
import 'package:mental_health/models/user/user.dart';
import 'package:mental_health/route/route_generator.dart';
import 'package:mental_health/simple_bloc_delegate.dart';
import 'package:mental_health/view/pages/home_page.dart';
import 'package:mental_health/view/pages/welcome_page.dart';
import 'package:provider/provider.dart';

class MentalHealthApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocSupervisor.delegate = SimpleBlocDelegate();

    /// Providing authentication bloc at the app level ensures that
    /// the whole app has access to authentication.

    return Provider<User>(
      create: (context) => User(),
      child: BlocProvider<AuthenticationBloc>(
        create: (context) {
          return AuthenticationBloc(ValidationBloc())..add(AppStarted());
        },
        child: _MyApp(),
      ),
    );
  }
}

class _MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SoundMind',
      theme: AppTheme.lightTheme,
      home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
            statusBarColor: Colors.white,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark),
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          // TODO: Check if it is better to have a BlocListener for navigation here.
          builder: (context, authenticationState) {
            /// The initial state of AuthenticationBloc
            if (authenticationState is AuthenticationInitial) {
              /* TODO: Check the performance in profile mode,
                  if good then remove this
                  else create a good looking splash page
               */
              //return SplashPage();
            }

            /// User is not logged in
//            if (authenticationState is AuthenticationUnauthenticated) {
//              return WelcomePage();
//            }

            /// User is logged in
            if (authenticationState is AuthenticationAuthenticated) {
              var updatedUser = authenticationState.user;
              Provider.of<User>(context)
                ..id = updatedUser.id
                ..name = updatedUser.name
                ..contactNumber = updatedUser.contactNumber
                ..city = updatedUser.city
                ..userType = updatedUser.userType
                ..profilePictureUrl = updatedUser.profilePictureUrl;

              return HomePage();
            }

            // TODO: Handle this/failure, show error or let user login again
            return WelcomePage();
          },
        ),
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
