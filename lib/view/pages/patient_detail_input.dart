import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health/bloc/page_transition/bloc.dart';
import 'package:mental_health/bloc/page_transition/page_transition_bloc.dart';
import 'package:mental_health/constants/strings.dart';
import 'package:mental_health/view/widgets/linear_loading_indicator.dart';
import 'package:mental_health/view/widgets/navigation_button_row.dart';
import 'package:mental_health/view/widgets/title_with_loading.dart';

class PatientDetailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              PageTransitionBloc(numberOfPages: 2, initialPageNumber: 0),
        )
      ],
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          minimum: EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 16.0),
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
                          transitionState.currentPageNumber == 0 ? true : false,
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
                  NavigationButtonRow(
                    onBackPressed: () => _handleBackPressed(context),
                    onNextPressed: () =>
                        _handleNextPressed(context, transitionState),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _getPage(BuildContext context, PageTransitionState transitionState) {
    if (transitionState.currentPageNumber == 0)
      return PersonalDetails();
    else if (transitionState.currentPageNumber == 1)
      return HealthDetails();
    else if (transitionState.currentPageNumber == 2) return MedicalRecords();

    return null; // Should never happen
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

class PersonalDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        TitleWithLoading(title: Strings.personalDetails, loadingVisibility: false),
      ],
    );
  }
}

class HealthDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        Strings.healthDetails,
        style: Theme.of(context)
            .textTheme
            .headline5
            .copyWith(color: Colors.black, fontWeight: FontWeight.w400),
      ),
    );
  }
}

class MedicalRecords extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        Strings.medicalRecords,
        style: Theme.of(context)
            .textTheme
            .headline5
            .copyWith(color: Colors.black, fontWeight: FontWeight.w400),
      ),
    );
  }
}
