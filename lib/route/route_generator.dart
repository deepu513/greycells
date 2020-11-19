import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greycells/bloc/appointment/appointment_detail_bloc.dart';
import 'package:greycells/bloc/assessment/assessment_bloc.dart';
import 'package:greycells/bloc/authentication/forgot_password_bloc.dart';
import 'package:greycells/bloc/payment/payment_bloc.dart';
import 'package:greycells/bloc/registration/bloc.dart';
import 'package:greycells/bloc/task/task_bloc.dart';
import 'package:greycells/bloc/therapist/bloc/therapist_bloc.dart';
import 'package:greycells/bloc/timeslot/timeslot_bloc.dart';
import 'package:greycells/bloc/validation/bloc.dart';
import 'package:greycells/models/appointment/appointment_date_args.dart';
import 'package:greycells/models/appointment/appointment_detail_arguments.dart';
import 'package:greycells/models/payment/payment_success_args.dart';
import 'package:greycells/models/task/task_item_page_args.dart';
import 'package:greycells/route/route_name.dart';
import 'package:greycells/view/pages/appointment_detail_page.dart';
import 'package:greycells/view/pages/image_viewer.dart';
import 'package:greycells/view/pages/patient/add_goals_page.dart';
import 'package:greycells/view/pages/patient/appointment_date_selection.dart';
import 'package:greycells/view/pages/patient/assessment_test_intro_page.dart';
import 'package:greycells/view/pages/patient/assessment_test_page.dart';
import 'package:greycells/view/pages/decider_page.dart';
import 'package:greycells/view/pages/forgot_password_page.dart';
import 'package:greycells/view/pages/login_page.dart';
import 'package:greycells/view/pages/patient/patient_appointment_page.dart';
import 'package:greycells/view/pages/patient/patient_detail_input.dart';
import 'package:greycells/view/pages/patient/patient_main_page.dart';
import 'package:greycells/view/pages/patient/patient_score_page.dart';
import 'package:greycells/view/pages/patient/payment_fail_page.dart';
import 'package:greycells/view/pages/patient/payment_page.dart';
import 'package:greycells/view/pages/patient/payment_success_page.dart';
import 'package:greycells/view/pages/patient_profile_page.dart';
import 'package:greycells/view/pages/register_page.dart';
import 'package:greycells/view/pages/patient/second_test_intro_page.dart';
import 'package:greycells/view/pages/patient/therapist_list_page.dart';
import 'package:greycells/view/pages/task_item_page.dart';
import 'package:greycells/view/pages/therapist/add_task_item.dart';
import 'package:greycells/view/pages/therapist/assign_tasks_page.dart';
import 'package:greycells/view/pages/therapist/therapist_main_page.dart';
import 'package:greycells/view/pages/therapist_profile_page.dart';
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
            child: RegisterPage(),
          ),
        );
      case RouteName.PATIENT_MAIN:
        return MaterialPageRoute(builder: (_) => PatientMainPage());
      case RouteName.THERAPIST_MAIN:
        return MaterialPageRoute(builder: (_) => TherapistMainPage());
      case RouteName.FORGOT_PASSWORD:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<ForgotPasswordBloc>(
                create: (_) => ForgotPasswordBloc(),
                child: ForgotPasswordPage()));
      case RouteName.PATIENT_DETAIL_INPUT_PAGE:
        return MaterialPageRoute(builder: (_) => PatientDetailInput());
      case RouteName.ASSESSMENT_TEST_INTRO:
        return MaterialPageRoute(
            builder: (_) => AssessmentTestIntroPage(
                  shouldPop: args ?? false,
                ));
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
        return MaterialPageRoute(
            builder: (_) => BlocProvider<PaymentBloc>(
                create: (_) => PaymentBloc(), child: PaymentPage(args)));
      case RouteName.PATIENT_SCORE_PAGE:
        return MaterialPageRoute(builder: (_) => PatientScorePage());
      case RouteName.THERAPIST_LIST_PAGE:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<TherapistBloc>(
                create: (_) => TherapistBloc(), child: TherapistListPage()));
      case RouteName.PATIENT_APPOINTMENT_LIST_PAGE:
        return MaterialPageRoute(builder: (_) => PatientAppointmentPage());
      case RouteName.PATIENT_PROFILE_PAGE:
        return MaterialPageRoute(builder: (_) => PatientProfilePage(args));
      case RouteName.THERAPIST_PROFILE_PAGE:
        return MaterialPageRoute(builder: (_) => TherapistProfilePage(args));
      case RouteName.APPOINTMENT_DATE_SELECTION_PAGE:
        AppointmentDateSelectionArguments arguments =
            args as AppointmentDateSelectionArguments;
        return MaterialPageRoute(
            builder: (_) => BlocProvider<TimeslotBloc>(
                  create: (_) => TimeslotBloc(),
                  child: AppointmentDateSelection(
                      arguments.therapist, arguments.selectedMeeting),
                ));
      case RouteName.APPOINTMENT_DETAIL_PAGE:
        AppointmentDetailArguments arguments =
            args as AppointmentDetailArguments;
        return MaterialPageRoute(
            builder: (_) => BlocProvider<AppointmentDetailBloc>(
                  create: (_) => AppointmentDetailBloc(),
                  child: AppointmentDetailPage(
                      arguments.userType, arguments.appointment),
                ));
      case RouteName.ADD_TASKS_PAGE:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<TaskBloc>(
            create: (_) => TaskBloc(),
            child: AssignTasksPage(
              args: args,
            ),
          ),
        );
      case RouteName.ADD_TASK_ITEM_PAGE:
        return MaterialPageRoute(builder: (_) => AddTaskItemsPage());
      case RouteName.TASK_ITEM_PAGE:
        TaskItemPageArgs arguments = args as TaskItemPageArgs;
        return MaterialPageRoute(
          builder: (_) => BlocProvider<TaskBloc>(
            create: (_) => TaskBloc(),
            child: TaskItemPage(
              taskItem: arguments.taskItem,
              userType: arguments.userType,
            ),
          ),
        );
      case RouteName.IMAGE_VIEWER_PAGE:
        return MaterialPageRoute(builder: (_) => ImageViewer(imageUrl: args));
      case RouteName.ADD_GOALS_PAGE:
        return MaterialPageRoute(builder: (_) => AddGoalsPage());
      case RouteName.PAYMENT_SUCCESS_PAGE:
        PaymentSuccessArgs arguments = args as PaymentSuccessArgs;
        return MaterialPageRoute(
            builder: (_) => PaymentSuccessPage(
                  paymentId: arguments.paymentId,
                  appointmentDate: arguments.appointmentDate,
                  appointmentTime: arguments.appointmentTime,
                ));
      case RouteName.PAYMENT_FAIL_PAGE:
        return MaterialPageRoute(
            builder: (_) => PaymentFailurePage(
                  paymentId: args,
                ));
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
