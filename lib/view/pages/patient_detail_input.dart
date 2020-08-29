import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health/bloc/birth_details/birth_details_bloc.dart';
import 'package:mental_health/bloc/guardian_details/guardian_details_bloc.dart';
import 'package:mental_health/bloc/health_details/health_details_bloc.dart';
import 'package:mental_health/bloc/page_transition/bloc.dart';
import 'package:mental_health/bloc/page_transition/page_transition_bloc.dart';
import 'package:mental_health/bloc/picker/image_picker_bloc.dart';
import 'package:mental_health/bloc/validation/bloc.dart';
import 'package:mental_health/models/validatable.dart';
import 'package:mental_health/view/pages/address_details_input_page.dart';
import 'package:mental_health/view/pages/birth_details_input_page.dart';
import 'package:mental_health/view/pages/guardian_details_input_page.dart';
import 'package:mental_health/view/pages/health_details_input_page.dart';
import 'package:mental_health/view/pages/medical_records_input_page.dart';
import 'package:mental_health/view/pages/profile_pic_input_page.dart';
import 'package:mental_health/view/widgets/navigation_button_row.dart';

class PatientDetailInput extends StatefulWidget {
  @override
  _PatientDetailInputState createState() => _PatientDetailInputState();
}

class _PatientDetailInputState extends State<PatientDetailInput>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _progressAnimation;
  final animationDuration = 500;

  final initialPageNumber = 1;
  final numberOfPages = 6;

  List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _pages = List.unmodifiable(<Widget>[
      const ProfilePicInputPage(),
      const BirthDetailsInputPage(),
      const HealthDetailsInputPage(),
      const GuardianDetailsInputPage(),
      const AddressDetailInputPage(),
      const MedicalRecordsInputPage(),
    ]);

    _controller = AnimationController(vsync: this);

    _progressAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));

    _controller.animateTo(initialPageNumber / numberOfPages,
        duration: Duration(milliseconds: animationDuration));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ImagePickerBloc>(
          create: (context) => ImagePickerBloc(),
        ),
        BlocProvider<ValidationBloc>(
          create: (context) => ValidationBloc(),
        ),
        BlocProvider<BirthDetailsBloc>(
          create: (context) => BirthDetailsBloc(),
        ),
        BlocProvider<HealthDetailsBloc>(
          create: (context) => HealthDetailsBloc(),
        ),
        BlocProvider<GuardianDetailsBloc>(
          create: (context) => GuardianDetailsBloc(),
        ),
        BlocProvider<PageTransitionBloc>(
          create: (context) => PageTransitionBloc(
              numberOfPages: numberOfPages,
              initialPageNumber: initialPageNumber),
        )
      ],
      child: Scaffold(
        body: SafeArea(
          minimum: EdgeInsets.only(top: 56.0),
          child: BlocListener<PageTransitionBloc, PageTransitionState>(
            listener: (previous, current) {
              _controller.animateBack(
                  (current.currentPageNumber) / numberOfPages,
                  duration: Duration(milliseconds: animationDuration));
            },
            child: BlocBuilder<PageTransitionBloc, PageTransitionState>(
              buildWhen: (previous, current) {
                return current is PageTransitionInitial ||
                    current is PageTransitionToNextPage ||
                    current is PageTransitionToPreviousPage;
              },
              builder: (context, transitionState) {
                return Column(
                  children: <Widget>[
                    Expanded(
                      child: PageTransitionSwitcher(
                        duration: const Duration(milliseconds: 300),
                        reverse: transitionState.currentPageNumber == 1
                            ? true
                            : false,
                        transitionBuilder: (Widget child,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation) {
                          return SharedAxisTransition(
                            child: child,
                            animation: animation,
                            secondaryAnimation: secondaryAnimation,
                            transitionType: SharedAxisTransitionType.horizontal,
                          );
                        },
                        child: _pages[transitionState.currentPageNumber - 1],
                      ),
                    ),
                    SizedBox(
                      height: 2.0,
                      child: AnimatedBuilder(
                        animation: _progressAnimation,
                        builder: (context, child) {
                          return LinearProgressIndicator(
                            value: _progressAnimation.value,
                            backgroundColor: Colors.blue.shade100,
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: NavigationButtonRow(
                        onBackPressed: () => _handleBackPressed(context),
                        onNextPressed: () =>
                            _handleNextPressed(context, transitionState),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _handleBackPressed(BuildContext context) {
    BlocProvider.of<PageTransitionBloc>(context)
        .add(TransitionToPreviousPage());
  }

  _handleNextPressed(
      BuildContext context, PageTransitionState transitionState) async {
    if (_shouldValidateCurrentPage(transitionState)) {
      var result = await _validateCurrentPage(context, transitionState);
      if (result == true)
        _transitionToNextPage(context);
    } else {
      _transitionToNextPage(context);
    }
  }

  Future<bool> _validateCurrentPage(
      BuildContext context, PageTransitionState transitionState) async {
    try {
      Validatable validatable =
          _pages[transitionState.currentPageNumber - 1] as Validatable;
      return await validatable
          .validate(context, BlocProvider.of<ValidationBloc>(context));
    } catch (e) {
      return false;
    }
  }

  bool _shouldValidateCurrentPage(PageTransitionState transitionState) =>
      _pages[transitionState.currentPageNumber - 1] is Validatable;

  void _transitionToNextPage(BuildContext context) {
    BlocProvider.of<PageTransitionBloc>(context).add(TransitionToNextPage());
  }
}
