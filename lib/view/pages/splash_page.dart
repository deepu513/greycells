import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(
            "Please wait...",
            style: TextStyle(fontSize: 24.0),
          ),
        ),
      ),
    );
  }
}
