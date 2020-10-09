import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:greycells/destination.dart';

class PatientMainPage extends StatefulWidget {
  @override
  _PatientMainPageState createState() => _PatientMainPageState();
}

class _PatientMainPageState extends State<PatientMainPage>
    with TickerProviderStateMixin<PatientMainPage> {
  int _currentIndex;
  AnimationController _bottomNavBarController;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _bottomNavBarController =
        AnimationController(vsync: this, duration: kThemeAnimationDuration);
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: Scaffold(
        body: SafeArea(
          child: IndexedStack(
            index: _currentIndex,
            children: [],
          ),
        ),
        bottomNavigationBar: SizeTransition(
          sizeFactor: _bottomNavBarController,
          axisAlignment: -1.0,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            showUnselectedLabels: true,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: allDestinations.map((destination) {
              return BottomNavigationBarItem(
                  icon: Icon(destination.icon),
                  label: destination.title,
                  activeIcon: Icon(destination.activeIcon));
            }).toList(),
          ),
        ),
      ),
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth == 0) {
      if (notification is UserScrollNotification) {
        final UserScrollNotification userScroll = notification;
        switch (userScroll.direction) {
          case ScrollDirection.forward:
            _bottomNavBarController.forward();
            break;
          case ScrollDirection.reverse:
            _bottomNavBarController.reverse();
            break;
          case ScrollDirection.idle:
            break;
        }
      }
    }
    return false;
  }
}
