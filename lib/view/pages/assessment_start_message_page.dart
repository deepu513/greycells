import 'package:flutter/material.dart';
import 'package:mental_health/constants/strings.dart';

class AssessmentStartMessagePage extends StatefulWidget {
  @override
  _AssessmentStartMessagePageState createState() =>
      _AssessmentStartMessagePageState();
}

class _AssessmentStartMessagePageState extends State<AssessmentStartMessagePage>
    with TickerProviderStateMixin {
  AnimationController _firstMessageFadeController;
  AnimationController _secondMessageFadeController;

  Animation<double> _firstMessageFadeInOut;
  Animation<double> _secondMessageFadeInOut;

  bool _firstAnimRunningInBackwards = false;

  @override
  void initState() {
    super.initState();
    _firstMessageFadeController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _secondMessageFadeController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    _firstMessageFadeInOut = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _firstMessageFadeController, curve: Curves.ease),
    );

    _secondMessageFadeInOut = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _secondMessageFadeController, curve: Curves.ease),
    );

    _firstMessageFadeController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _firstMessageFadeController.reverse();
      } else if (status == AnimationStatus.reverse) {
        _firstAnimRunningInBackwards = true;
      } else if (_firstAnimRunningInBackwards == true &&
          status == AnimationStatus.dismissed) {
        _secondMessageFadeController.forward();
      }
    });

    _secondMessageFadeController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _secondMessageFadeController.reverse();
      }
    });

    _firstMessageFadeController.forward();
  }

  @override
  void dispose() {
    _firstMessageFadeController.dispose();
    _secondMessageFadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            FadeTransition(
              opacity: _firstMessageFadeInOut,
              child: Center(
                child: Text(
                  Strings.beforeWeBegin,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
            FadeTransition(
              opacity: _secondMessageFadeInOut,
              child: Center(
                child: Text(Strings.somePoints,
                    style: Theme.of(context).textTheme.headline6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
