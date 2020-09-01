import 'dart:async';

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
      if (status == AnimationStatus.completed) {
        currentPoint = 1;
        _buttonFadeController.forward();
      }
    });

    _secondPointFadeController.addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        currentPoint = 2;
      }
    });

    _thirdPointFadeController.addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        currentPoint = 3;
      }
    });

    _fourthPointFadeController.addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        currentPoint = 4;
      }
    });

    _fifthPointFadeController.addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        currentPoint = 5;
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
      // start test
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
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
                    child: Text("Next"),
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
                      child: Text("List title",
                          style: Theme.of(context).textTheme.headline5.copyWith(
                              fontWeight: FontWeight.w300, fontSize: 20.0)),
                    ),
                    FadeTransition(
                      opacity: _firstColumnPointFadeIn,
                      child: Text(
                          "1. Some point to show to the user, may be show in rich text",
                          style: Theme.of(context).textTheme.headline5.copyWith(
                              fontWeight: FontWeight.w300, fontSize: 16.0)),
                    ),
                    FadeTransition(
                      opacity: _secondColumnPointFadeIn,
                      child: Text(
                          "1. Some point to show to the user, may be show in rich text",
                          style: Theme.of(context).textTheme.headline5.copyWith(
                              fontWeight: FontWeight.w300, fontSize: 16.0)),
                    ),
                    FadeTransition(
                      opacity: _thirdColumnPointFadeIn,
                      child: Text(
                          "1. Some point to show to the user, may be show in rich text",
                          style: Theme.of(context).textTheme.headline5.copyWith(
                              fontWeight: FontWeight.w300, fontSize: 16.0)),
                    ),
                    FadeTransition(
                      opacity: _fourthColumnPointFadeIn,
                      child: Text(
                          "1. Some point to show to the user, may be show in rich text",
                          style: Theme.of(context).textTheme.headline5.copyWith(
                              fontWeight: FontWeight.w300, fontSize: 16.0)),
                    ),
                    FadeTransition(
                      opacity: _fifthColumnPointFadeIn,
                      child: Text(
                          "1. Some point to show to the user, may be show in rich text",
                          style: Theme.of(context).textTheme.headline5.copyWith(
                              fontWeight: FontWeight.w300, fontSize: 16.0)),
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

class ShowUp extends StatefulWidget {
  final Widget child;
  final int delay;

  ShowUp({@required this.child, this.delay});

  @override
  _ShowUpState createState() => _ShowUpState();
}

class _ShowUpState extends State<ShowUp> with TickerProviderStateMixin {
  AnimationController _animController;
  Animation<Offset> _animOffset;

  @override
  void initState() {
    super.initState();

    _animController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    final curve =
        CurvedAnimation(curve: Curves.decelerate, parent: _animController);
    _animOffset =
        Tween<Offset>(begin: const Offset(0.0, 0.35), end: Offset.zero)
            .animate(curve);

    if (widget.delay == null) {
      _animController.forward();
    } else {
      Timer(Duration(milliseconds: widget.delay), () {
        _animController.forward();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _animController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
      opacity: _animController,
    );
  }
}
