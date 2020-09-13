import 'package:flutter/material.dart';
import 'package:greycells/constants/strings.dart';
import 'package:greycells/route/route_name.dart';

class SecondTestIntroPage extends StatefulWidget {
  @override
  _SecondTestIntroPageState createState() => _SecondTestIntroPageState();
}

class _SecondTestIntroPageState extends State<SecondTestIntroPage>
    with TickerProviderStateMixin {
  AnimationController _firstMessageFadeController;
  Animation<double> _firstMessageFadeInOut;

  @override
  void initState() {
    super.initState();
    _firstMessageFadeController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));

    _firstMessageFadeInOut = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _firstMessageFadeController, curve: Curves.ease),
    );

    _firstMessageFadeController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _navigateToAssessmentTest();
      }
    });

    _firstMessageFadeController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: FadeTransition(
            opacity: _firstMessageFadeInOut,
            child: Center(
              child: Text(
                Strings.secondTestIntroMessage,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(fontWeight: FontWeight.w300, fontSize: 24.0),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _navigateToAssessmentTest() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        RouteName.ASSESSMENT_TEST, (route) => false,
        arguments: 2);
  }
}
