import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health/bloc/page_transition/bloc.dart';
import 'package:mental_health/bloc/page_transition/page_transition_bloc.dart';
import 'package:mental_health/view/pages/address_details_input_page.dart';
import 'package:mental_health/view/pages/birth_details_input_page.dart';
import 'package:mental_health/view/pages/guardian_details_input_page.dart';
import 'package:mental_health/view/pages/health_details_input_page.dart';
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
  final numberOfPages = 5;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    _progressAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));

    _controller.animateTo(initialPageNumber / numberOfPages, duration: Duration(milliseconds: animationDuration));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              PageTransitionBloc(numberOfPages: numberOfPages, initialPageNumber: initialPageNumber),
        )
      ],
      child: Scaffold(
        body: SafeArea(
          minimum: EdgeInsets.only(top: 56.0),
          child: BlocListener<PageTransitionBloc, PageTransitionState>(
            listener: (previous, current) {
              _controller.animateBack(
                  (current.currentPageNumber) /
                      numberOfPages,
                  duration: Duration(milliseconds: animationDuration));
            },
            child: BlocBuilder<PageTransitionBloc, PageTransitionState>(
              condition: (previous, current) {
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
                        reverse:
                            transitionState.currentPageNumber == 1 ? true : false,
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
                        child: _getPage(context, transitionState),
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

  Widget _getPage(BuildContext context, PageTransitionState transitionState) {
    if (transitionState.currentPageNumber == 1)
      return ProfilePicInputPage();
    else if (transitionState.currentPageNumber == 2)
      return BirthDetailsInputPage();
    else if (transitionState.currentPageNumber == 3)
      return GuardianDetailsInputPage();
    else if (transitionState.currentPageNumber == 4)
      return AddressDetailInputPage();
    else if (transitionState.currentPageNumber == 5)
      return HealthDetailsInputPage();

    return Container(); // Should never happen
  }

  void _handleBackPressed(BuildContext context) {
    BlocProvider.of<PageTransitionBloc>(context)
        .add(TransitionToPreviousPage());
  }

  _handleNextPressed(
      BuildContext context, PageTransitionState transitionState) {
    BlocProvider.of<PageTransitionBloc>(context).add(TransitionToNextPage());
  }
}
