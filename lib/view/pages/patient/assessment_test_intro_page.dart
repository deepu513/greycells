import 'package:flutter/material.dart';
import 'package:greycells/constants/strings.dart';
import 'package:greycells/constants/test_types.dart';
import 'package:greycells/models/assessment/assessment_test_args.dart';
import 'package:greycells/route/route_name.dart';

class AssessmentTestIntroPage extends StatefulWidget {
  final bool shouldPop;

  AssessmentTestIntroPage({this.shouldPop = false});

  @override
  _AssessmentTestIntroPageState createState() =>
      _AssessmentTestIntroPageState();
}

class _AssessmentTestIntroPageState extends State<AssessmentTestIntroPage>
    with TickerProviderStateMixin {
  AnimationController _firstMessageFadeController;
  AnimationController _secondMessageFadeController;

  AnimationController _buttonFadeController;

  AnimationController _listTitleFadeController;
  AnimationController _firstPointFadeController;
  AnimationController _secondPointFadeController;
  AnimationController _thirdPointFadeController;
  AnimationController _fourthPointFadeController;
  AnimationController _fifthPointFadeController;

  Animation<double> _firstMessageFadeInOut;
  Animation<double> _secondMessageFadeInOut;

  Animation<double> _buttonFadeIn;

  Animation<double> _listTitleFadeIn;
  Animation<double> _firstColumnPointFadeIn;
  Animation<double> _secondColumnPointFadeIn;
  Animation<double> _thirdColumnPointFadeIn;
  Animation<double> _fourthColumnPointFadeIn;
  Animation<double> _fifthColumnPointFadeIn;

  bool _firstAnimRunningInBackwards = false;
  bool _secondAnimRunningInBackwards = false;

  int currentPoint = 1;

  @override
  void initState() {
    super.initState();
    _firstMessageFadeController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    _secondMessageFadeController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    _buttonFadeController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    _listTitleFadeController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    _firstPointFadeController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    _secondPointFadeController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    _thirdPointFadeController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    _fourthPointFadeController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    _fifthPointFadeController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    _firstMessageFadeInOut = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _firstMessageFadeController, curve: Curves.ease),
    );

    _secondMessageFadeInOut = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _secondMessageFadeController, curve: Curves.ease),
    );

    _buttonFadeIn = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _buttonFadeController, curve: Curves.ease),
    );

    _listTitleFadeIn = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _listTitleFadeController, curve: Curves.ease),
    );

    _firstColumnPointFadeIn = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _firstPointFadeController, curve: Curves.ease),
    );

    _secondColumnPointFadeIn = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _secondPointFadeController, curve: Curves.ease),
    );

    _thirdColumnPointFadeIn = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _thirdPointFadeController, curve: Curves.ease),
    );

    _fourthColumnPointFadeIn = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fourthPointFadeController, curve: Curves.ease),
    );

    _fifthColumnPointFadeIn = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fifthPointFadeController, curve: Curves.ease),
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
      } else if (status == AnimationStatus.reverse) {
        _secondAnimRunningInBackwards = true;
      } else if (_secondAnimRunningInBackwards == true &&
          status == AnimationStatus.dismissed) {
        _listTitleFadeController.forward();
      }
    });

    _listTitleFadeController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _firstPointFadeController.forward();
      }
    });

    _firstPointFadeController.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.forward) {
        currentPoint = 1;
        _buttonFadeController.forward();
      }
    });

    _secondPointFadeController.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.forward) {
        currentPoint = 2;
      }
    });

    _thirdPointFadeController.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.forward) {
        currentPoint = 3;
      }
    });

    _fourthPointFadeController.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.forward) {
        currentPoint = 4;
      }
    });

    _fifthPointFadeController.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.forward) {
        setState(() {
          currentPoint = 5;
        });
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

  showNextPoint() {
    if (currentPoint == 1) {
      _secondPointFadeController.forward();
    }

    if (currentPoint == 2) {
      _thirdPointFadeController.forward();
    }

    if (currentPoint == 3) {
      _fourthPointFadeController.forward();
    }

    if (currentPoint == 4) {
      _fifthPointFadeController.forward();
    }

    if (currentPoint == 5) {
      if (widget.shouldPop == true) {
        Navigator.of(context).pop();
      } else
        _navigateToAssessmentTestPage();
    }
  }

  void _navigateToAssessmentTestPage() {
    Navigator.of(context).pushNamed(
      RouteName.ASSESSMENT_TEST,
      arguments: AssessmentTestArguments(
          testType: TestTypes.BEHAVIOUR, resumeFromQuestionNumber: 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 36.0),
          child: Stack(
            children: [
              FadeTransition(
                opacity: _firstMessageFadeInOut,
                child: Center(
                  child: Text(
                    Strings.beforeWeBegin,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(fontWeight: FontWeight.w300, fontSize: 24.0),
                  ),
                ),
              ),
              FadeTransition(
                opacity: _secondMessageFadeInOut,
                child: Center(
                  child: Text(Strings.somePoints,
                      style: Theme.of(context).textTheme.headline5.copyWith(
                          fontWeight: FontWeight.w300, fontSize: 24.0)),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: FadeTransition(
                  opacity: _buttonFadeIn,
                  child: FlatButton(
                    child: AnimatedCrossFade(
                      duration: Duration(milliseconds: 200),
                      crossFadeState: currentPoint < 5
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      firstChild: Text(
                        Strings.next.toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .button
                            .copyWith(color: Theme.of(context).accentColor),
                      ),
                      secondChild: Text(
                        "Let's begin".toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .button
                            .copyWith(color: Theme.of(context).accentColor),
                      ),
                    ),
                    onPressed: showNextPoint,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeTransition(
                      opacity: _listTitleFadeIn,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Points to note:",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  .copyWith(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w300)),
                          SizedBox(
                            width: 72.0,
                            child: Divider(
                              color: Colors.blue,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 16.0),
                    FadeTransition(
                      opacity: _firstColumnPointFadeIn,
                      child: RichText(
                        text: TextSpan(
                            text: "1.  ",
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20.0,
                                    ),
                            children: [
                              TextSpan(
                                text:
                                    "This questionnaire is designed to help you explore the typical ways you interact with people.",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 18.0,
                                        height: 1.4,
                                        letterSpacing: 0.7),
                              ),
                            ]),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    FadeTransition(
                      opacity: _secondColumnPointFadeIn,
                      child: RichText(
                        text: TextSpan(
                            text: "2.  ",
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20.0,
                                    ),
                            children: [
                              TextSpan(
                                text: "There are ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 18.0,
                                        height: 1.4,
                                        letterSpacing: 0.6),
                              ),
                              TextSpan(
                                text: "no right or wrong answers.",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18.0,
                                        height: 1.4,
                                        letterSpacing: 0.6),
                              )
                            ]),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    FadeTransition(
                      opacity: _thirdColumnPointFadeIn,
                      child: RichText(
                        text: TextSpan(
                            text: "3.  ",
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20.0,
                                    ),
                            children: [
                              TextSpan(
                                text:
                                    "Each person has his own ways of behaving. Sometimes people are tempted to answer questions like this in terms of what they think a person should do.",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 18.0,
                                        height: 1.4,
                                        letterSpacing: 0.6),
                              ),
                              TextSpan(
                                text: "This is not what is desired here.",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18.0,
                                        height: 1.4,
                                        letterSpacing: 0.6),
                              )
                            ]),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    FadeTransition(
                      opacity: _fourthColumnPointFadeIn,
                      child: RichText(
                        text: TextSpan(
                            text: "4.  ",
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20.0,
                                    ),
                            children: [
                              TextSpan(
                                text:
                                    "The questionnaire is an attempt to help you learn more about yourself and how you actually behave.",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 18.0,
                                        height: 1.4,
                                        letterSpacing: 0.6),
                              ),
                            ]),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    FadeTransition(
                      opacity: _fifthColumnPointFadeIn,
                      child: RichText(
                        text: TextSpan(
                            text: "5.  ",
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20.0,
                                    ),
                            children: [
                              TextSpan(
                                text:
                                    "Some of the questions which follow may seem similar to others.",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 18.0,
                                        height: 1.4,
                                        letterSpacing: 0.6),
                              ),
                              TextSpan(
                                text:
                                    " Please tick the answer that best applies to you. Be honest with yourself",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18.0,
                                        height: 1.4,
                                        letterSpacing: 0.6),
                              )
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
