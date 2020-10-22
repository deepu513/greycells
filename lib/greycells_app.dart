import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greycells/app_theme.dart';
import 'package:greycells/bloc/authentication/bloc.dart';
import 'package:greycells/bloc/decider/decider_bloc.dart';
import 'package:greycells/bloc/notification/bloc/notification_bloc.dart';
import 'package:greycells/bloc/payment/payment_bloc.dart';
import 'package:greycells/bloc/validation/validation_bloc.dart';
import 'package:greycells/models/home/home.dart';
import 'package:greycells/models/payment/payment.dart';
import 'package:greycells/models/payment/payment_item.dart';
import 'package:greycells/models/payment/payment_type.dart';
import 'package:greycells/route/route_generator.dart';
import 'package:greycells/simple_bloc_observer.dart';
import 'package:greycells/view/pages/patient/birth_details_input_page.dart';
import 'package:greycells/view/pages/decider_page.dart';
import 'package:greycells/view/pages/login_page.dart';
import 'package:greycells/view/pages/patient/patient_detail_input.dart';
import 'package:greycells/view/pages/patient/patient_main_page.dart';
import 'package:greycells/view/pages/patient/payment_page.dart';
import 'package:greycells/view/pages/patient_profile_page.dart';
import 'package:greycells/view/pages/register_page.dart';
import 'package:greycells/view/pages/splash_page.dart';
import 'package:greycells/view/pages/therapist/therapist_main_page.dart';
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
          create: (context) {
            return AuthenticationBloc(ValidationBloc())..add(AppStarted());
          },
        ),
        BlocProvider<DeciderBloc>(
          create: (context) {
            return DeciderBloc();
          },
        ),
        BlocProvider<PaymentBloc>(
          create: (context) {
            return PaymentBloc(Payment()
              ..type = PaymentType.APPOINTMENT
              ..title = "Book Appointment"
              ..itemImageUrl =
                  "https://urbanbalance.com/wp-content/uploads/2019/04/new-therapist.jpg"
              ..itemTitle = "Dr. Anne Hathaway"
              ..itemSubtitle = "Clinical Psychologist"
              ..promoCodeApplied = false
              ..discountAmount = 100
              ..originalAmount = 300
              ..items = [
                PaymentItem()
                  ..itemName = "1 Session"
                  ..itemPrice = 300
              ]
              ..totalAmount = 300);
          },
        )
      ],
      child: Provider<Home>(
        create: (_) => Home(),
        child: BlocConsumer<NotificationBloc, NotificationState>(
          listener: (context, state) {},
          builder: (context, state) {
            return _MyApp();
          },
        ),
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
              return PatientProfilePage();
              //return WelcomePage();
            }

            /// User is logged in
            if (authenticationState is AuthenticationAuthenticated) {
              return PatientProfilePage();
              //return DeciderPage();
            }

            return SplashPage();
          },
        ),
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
