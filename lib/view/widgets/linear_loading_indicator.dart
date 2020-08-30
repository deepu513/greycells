import 'package:flutter/material.dart';

class LinearLoadingIndicator extends StatefulWidget {
  final bool visibility;

  const LinearLoadingIndicator({Key key, this.visibility = false});

  @override
  _LinearLoadingIndicatorState createState() => _LinearLoadingIndicatorState();
}

class _LinearLoadingIndicatorState extends State<LinearLoadingIndicator> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.visibility,
      child: LinearProgressIndicator(
        backgroundColor: Colors.white,
      ),
    );
  }
}
