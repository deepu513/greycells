import 'package:flutter/material.dart';
import 'package:greycells/destination.dart';

class PatientMainPage extends StatefulWidget {
  @override
  _PatientMainPageState createState() => _PatientMainPageState();
}

class _PatientMainPageState extends State<PatientMainPage>
    with TickerProviderStateMixin<PatientMainPage> {
  int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: [],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
    );
  }
}
