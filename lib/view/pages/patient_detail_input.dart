import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health/bloc/page_transition/bloc.dart';
import 'package:mental_health/bloc/page_transition/page_transition_bloc.dart';
import 'package:mental_health/constants/strings.dart';
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
        TitleWithLoading(
          title: Strings.personalDetails,
          loadingVisibility: false,
        ),
        SizedBox(height: 32.0),
        InkWell(
          onTap: () {},
          child: AvatarWidget(),
        ),
        SizedBox(height: 16.0),
        Text(
          Strings.dateOfBirthMessage,
          style: DefaultTextStyle.of(context).style,
        ),
        DateOfBirthInput(),
        SizedBox(
          height: 16.0,
        ),
        RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: [
              TextSpan(text: Strings.timeOfBirthMessage),
              TextSpan(
                text: " ${Strings.optionalMessage}",
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
        ),
        TimeOfBirthWidget()
      ],
    );
  }
}

class DateOfBirthInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: TextField(
            maxLength: 2,
            decoration:
                InputDecoration(labelText: "Date", border: InputBorder.none),
            keyboardType: TextInputType.number,
            buildCounter: (BuildContext context,
                    {int currentLength, int maxLength, bool isFocused}) =>
                null,
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          flex: 1,
          child: TextField(
            maxLength: 2,
            decoration:
                InputDecoration(labelText: "Month", border: InputBorder.none),
            keyboardType: TextInputType.number,
            buildCounter: (BuildContext context,
                    {int currentLength, int maxLength, bool isFocused}) =>
                null,
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          flex: 1,
          child: TextField(
            maxLength: 4,
            decoration:
                InputDecoration(labelText: "Year", border: InputBorder.none),
            keyboardType: TextInputType.number,
            buildCounter: (BuildContext context,
                    {int currentLength, int maxLength, bool isFocused}) =>
                null,
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(),
        )
      ],
    );
  }
}

class TimeOfBirthWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: TextField(
            maxLength: 2,
            decoration:
                InputDecoration(labelText: "Hours", border: InputBorder.none),
            keyboardType: TextInputType.number,
            buildCounter: (BuildContext context,
                    {int currentLength, int maxLength, bool isFocused}) =>
                null,
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          flex: 1,
          child: TextField(
            maxLength: 4,
            decoration:
                InputDecoration(labelText: "Minutes", border: InputBorder.none),
            keyboardType: TextInputType.number,
            buildCounter: (BuildContext context,
                    {int currentLength, int maxLength, bool isFocused}) =>
                null,
          ),
        ),
        SizedBox(width: 8.0),
        ToggleButtons(
          children: <Widget>[Text("AM"), Text("PM")],
          borderRadius: BorderRadius.circular(8.0),
          isSelected: [true, false],
          onPressed: (index) {},
        ),
        Expanded(
          flex: 2,
          child: Container(),
        )
      ],
    );
  }
}

class AvatarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CircleAvatar(
            child: Icon(
              Icons.add_a_photo,
              size: 32.0,
            ),
            radius: 32.0,
          ),
          SizedBox(
            height: 16.0,
          ),
          Text(
            Strings.profilePicPickerMessage,
            style: Theme.of(context).textTheme.caption,
            textAlign: TextAlign.center,
          ),
        ],
      ),
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
