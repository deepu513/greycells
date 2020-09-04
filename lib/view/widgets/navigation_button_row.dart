import 'package:flutter/material.dart';
import 'package:greycells/constants/strings.dart';

class NavigationButtonRow extends StatelessWidget {
  final VoidCallback onBackPressed;
  final VoidCallback onNextPressed;

  NavigationButtonRow({Key key, this.onBackPressed, this.onNextPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FlatButton(
          onPressed: onBackPressed,
          textColor: Theme.of(context).accentColor,
          child: Text(Strings.back.toUpperCase()),
        ),
        RaisedButton(
          onPressed: onNextPressed,
          color: Theme.of(context).accentColor,
          textColor: Colors.white,
          child: Text(
            Strings.next.toUpperCase(),
          ),
        )
      ],
    );
  }
}
