import 'package:flutter/material.dart';
import 'package:greycells/destination.dart';
import 'package:greycells/models/home/therapist_home.dart';
import 'package:provider/provider.dart';

class TherapistMainPage extends StatefulWidget {
  @override
  _TherapistMainPageState createState() => _TherapistMainPageState();
}

class _TherapistMainPageState extends State<TherapistMainPage>
    with TickerProviderStateMixin<TherapistMainPage> {
  int _currentIndex;
  List<Destination> therapistDestinations;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    therapistDestinations = Destination.therapistDestinations(
        Provider.of<TherapistHome>(context, listen: false).therapist);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: therapistDestinations.map((destination) {
            return destination.body;
          }).toList(),
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
        items: therapistDestinations.map((destination) {
          return BottomNavigationBarItem(
              icon: Icon(destination.icon),
              label: destination.title,
              activeIcon: Icon(destination.activeIcon));
        }).toList(),
      ),
    );
  }
}
