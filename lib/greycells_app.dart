import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greycells/app_theme.dart';
import 'package:greycells/bloc/authentication/bloc.dart';
import 'package:greycells/bloc/decider/decider_bloc.dart';
import 'package:greycells/bloc/notification/notification_bloc.dart';
import 'package:greycells/bloc/validation/validation_bloc.dart';
import 'package:greycells/models/home/patient_home.dart';
import 'package:greycells/models/home/therapist_home.dart';
import 'package:greycells/route/route_generator.dart';
import 'package:greycells/simple_bloc_observer.dart';
import 'package:greycells/view/pages/decider_page.dart';
import 'package:greycells/view/pages/splash_page.dart';
import 'package:greycells/view/pages/therapist/assign_tasks_page.dart';
import 'package:greycells/view/pages/welcome_page.dart';
import 'package:provider/provider.dart';

import 'constants/strings.dart';

class GreyCellsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Bloc.observer = SimpleBlocObserver();

    /// Providing authentication bloc at the app level ensures that
    /// the whole app has access to authentication.

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) =>
              AuthenticationBloc(ValidationBloc())..add(AppStarted()),
        ),
        BlocProvider<DeciderBloc>(
          create: (context) => DeciderBloc(),
        ),
        BlocProvider<NotificationBloc>(
          create: (context) => NotificationBloc(),
        )
      ],
      child: MultiProvider(
        providers: [
          // * One of these is initialised based on user type of logged in user.
          Provider<PatientHome>(create: (_) => PatientHome()),
          Provider<TherapistHome>(create: (_) => TherapistHome()),
        ],
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
      title: Strings.appName,
      theme: AppTheme.lightTheme,
      home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
            statusBarColor: Colors.white,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark),
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, authenticationState) {
            /// User is not logged in
            if (authenticationState is AuthenticationUnauthenticated) {
              //return PatientAppointmentPage();
              return AssignTasksPage();
            }

            /// User is logged in
            if (authenticationState is AuthenticationAuthenticated) {
              BlocProvider.of<NotificationBloc>(context)
                  .add(SafelyUpdateToken());
              //return PatientAppointmentPage();
              return AssignTasksPage();
            }

            return SplashPage();
          },
        ),
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
