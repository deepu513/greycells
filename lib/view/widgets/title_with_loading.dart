import 'package:flutter/material.dart';

class TitleWithLoading extends StatelessWidget {
  final Text text;
  final bool loadingVisibility;
  final Color loadingBackgroundColor;

  TitleWithLoading(
      {@required this.text,
      @required this.loadingVisibility,
      this.loadingBackgroundColor})
      : assert(text != null),
        assert(loadingVisibility != null);

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          text,
          SizedBox(
            height: 12.0,
          ),
          Visibility(
            visible: loadingVisibility,
            child: LinearProgressIndicator(
              backgroundColor: loadingBackgroundColor ?? null,
              minHeight: 2.0,
            ),
          )
        ],
      ),
    );
  }
}
