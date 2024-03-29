import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:greycells/app_theme.dart';
import 'package:greycells/constants/strings.dart';
import 'package:greycells/route/route_name.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _firstWordFadeAnimation;
  Animation<double> _secondWordFadeAnimation;
  Animation<double> _subtitleFadeAnimation;
  Animation<double> _contentFadeAnimation;
  Animation<AlignmentGeometry> _translateAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: Duration(milliseconds: 4000), vsync: this);

    _firstWordFadeAnimation =
        Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.0, 0.15, curve: Curves.linear),
    ));

    _secondWordFadeAnimation =
        Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.15, 0.30, curve: Curves.linear),
    ));

    _subtitleFadeAnimation =
        Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.35, 0.50, curve: Curves.linear),
    ));

    _translateAnimation =
        Tween(begin: Alignment.center, end: Alignment.topCenter)
            .animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.7, 0.9, curve: Curves.decelerate),
    ));

    _contentFadeAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.8, 1.0, curve: Curves.linear),
    ));
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      minimum: EdgeInsets.fromLTRB(32.0, 72.0, 32.0, 36.0),
      child: Stack(children: <Widget>[
        AlignTransition(
          alignment: _translateAnimation,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FadeTransition(
                      opacity: _firstWordFadeAnimation,
                      child: Text(
                        Strings.grey,
                        style: Theme.of(context)
                            .textTheme
                            .headline3
                            .copyWith(color: Colors.grey[700]),
                      )),
                  FadeTransition(
                      opacity: _secondWordFadeAnimation,
                      child: Text(
                        Strings.cells,
                        style: Theme.of(context)
                            .textTheme
                            .headline3
                            .copyWith(color: Colors.black87),
                      )),
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
              FadeTransition(
                opacity: _subtitleFadeAnimation,
                child: Text(
                  Strings.subtitle,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: FadeTransition(
            opacity: _contentFadeAnimation,
            child: Image.asset(
              "images/self_care_illustration.png",
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: FadeTransition(
            opacity: _contentFadeAnimation,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ButtonTheme(
                  minWidth: double.infinity,
                  height: 48.0,
                  child: RaisedButton(
                    onPressed: () =>
                        {Navigator.pushNamed(context, RouteName.LOGIN)},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    textColor: Colors.black,
                    color: Colors.white,
                    child: Text(
                      Strings.login.toUpperCase(),
                      style: Theme.of(context).textTheme.button.copyWith(
                          letterSpacing: 0.7,
                          color: Colors.grey[800],
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: 24.0),
                ButtonTheme(
                  minWidth: double.maxFinite,
                  height: 48.0,
                  child: RaisedButton(
                    onPressed: () =>
                        {Navigator.pushNamed(context, RouteName.REGISTER)},
                    color: AppTheme.secondaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Text(
                      Strings.register.toUpperCase(),
                      style: Theme.of(context).textTheme.button.copyWith(
                          letterSpacing: 0.7,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ]),
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
