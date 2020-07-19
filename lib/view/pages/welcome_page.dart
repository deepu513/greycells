import 'package:flutter/material.dart';
import 'package:mental_health/constants/strings.dart';

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
        duration: Duration(milliseconds: 3000), vsync: this);

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
        parent: _controller, curve: Interval(0.9, 1.0, curve: Curves.linear)));
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          minimum: EdgeInsets.fromLTRB(24.0, 96.0, 24.0, 24.0),
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
                            Strings.sound,
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline3
                                .copyWith(
                                color: Colors.grey[700]
                            ),
                          )),
                      FadeTransition(
                          opacity: _secondWordFadeAnimation,
                          child: Text(
                            Strings.mind,
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline3
                                .copyWith(
                                color: Colors.black
                            ),
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
                      style: Theme
                          .of(context)
                          .textTheme.subtitle1,
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: FadeTransition(
                  opacity: _contentFadeAnimation,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text("Some message here",
                          style: TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.w300,
                          )),
                      SizedBox(
                        height: 56.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 48.0,
                        child: FlatButton.icon(
                          onPressed: () {

                          },
                          textColor: Theme
                              .of(context)
                              .accentColor,
                          label: Text(
                            "Test",
                            style: TextStyle(fontSize: 20.0),
                          ),
                          icon: Icon(Icons.favorite),
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 48.0,
                        child: FlatButton.icon(
                          onPressed: () {},
                          textColor: Theme
                              .of(context)
                              .accentColor,
                          label: Text(
                            "Test",
                            style: TextStyle(fontSize: 20.0),
                          ),
                          icon: Icon(Icons.toys),
                        ),
                      )
                    ],
                  )),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: FadeTransition(
                opacity: _contentFadeAnimation,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FlatButton(
                    onPressed: () {},
                    textColor: Theme
                        .of(context)
                        .accentColor,
                    child: Text(
                      "Test",
                      style: TextStyle(fontSize: 16.0),
                      textAlign: TextAlign.center,
                    ),
                    padding: const EdgeInsets.all(8.0),
                  ),
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
