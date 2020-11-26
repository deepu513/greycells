import 'package:flutter/material.dart';
import 'package:greycells/app_theme.dart';
import 'package:greycells/route/route_name.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = new List();

  @override
  void initState() {
    super.initState();
    slides.add(
      new Slide(
        title: "PURPOSE",
        styleTitle: TextStyle(
            color: AppTheme.secondaryColor,
            fontSize: 24.0,
            fontWeight: FontWeight.bold),
        heightImage: 320.0,
        widthImage: 320.0,
        styleDescription: TextStyle(
            color: Colors.black87,
            letterSpacing: 0.7,
            wordSpacing: 1.0,
            fontSize: 14.0),
        description:
            """The purpose of this application is to provide a platform for individuals to get an assessment done for their personality, behaviour, leadership, team building capabilities and mental health needs. The analysis will help individuals to focus on their strengths, improve on their weaknesses and build a better capability.""",
        pathImage: "images/intro_1.png",
        backgroundColor: Colors.white,
      ),
    );
    slides.add(
      new Slide(
        title: "CONNECT",
        styleTitle: TextStyle(
            color: AppTheme.secondaryColor,
            fontSize: 24.0,
            fontWeight: FontWeight.bold),
        heightImage: 320.0,
        widthImage: 320.0,
        styleDescription: TextStyle(
            color: Colors.black87,
            letterSpacing: 0.7,
            wordSpacing: 1.0,
            fontSize: 14.0),
        description:
            """The application provides an opportunity to individuals to connect with experts like Clinical Psychologists to address their concerns relating to personal, professional, familial, educational and interpersonal issues. The application caters to both adults and children from 3 years to 18 years.""",
        pathImage: "images/intro_2.png",
        backgroundColor: Colors.white,
      ),
    );
    slides.add(
      new Slide(
        title: "ACHIEVE",
        styleTitle: TextStyle(
            color: AppTheme.secondaryColor,
            fontSize: 24.0,
            fontWeight: FontWeight.bold),
        heightImage: 320.0,
        widthImage: 320.0,
        styleDescription: TextStyle(
            color: Colors.black87,
            letterSpacing: 0.7,
            wordSpacing: 1.0,
            fontSize: 14.0),
        description:
            """Sessions with the experts can be booked using the appointments as per the availability. The sessions once booked will be done over an inbuilt video call for the selected time duration. Post the session, the experts can assign tasks and set goals for the individuals, which can be tracked both by the individual and the therapist.""",
        pathImage: "images/intro_3.png",
        backgroundColor: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      slides: this.slides,
      onDonePress: () {
        Navigator.of(context).pushNamedAndRemoveUntil(
          RouteName.PATIENT_DETAIL_INPUT_PAGE,
          (route) => false,
        );
      },
      styleNameSkipBtn: TextStyle(
          color: AppTheme.secondaryColor,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.7),
      styleNameDoneBtn: TextStyle(
          color: AppTheme.secondaryColor,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.7),
    );
  }
}
