import 'package:flutter/material.dart';
import 'package:greycells/constants/strings.dart';

class ErrorWithRetry extends StatelessWidget {
  final VoidCallback onRetryPressed;

  ErrorWithRetry({@required this.onRetryPressed})
      : assert(onRetryPressed != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(),
          ),
          Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 48.0,
          ),
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  ErrorMessages.GENERIC_ERROR_MESSAGE,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                    fontSize: 14.0,
                    height: 1.5,
                    wordSpacing: 1.0
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                RaisedButton(
                  onPressed: onRetryPressed,
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  color: Theme.of(context).accentColor,
                  child: Text(
                    Strings.retry.toUpperCase(),
                    style: Theme.of(context).textTheme.button.copyWith(
                      color: Colors.white,
                      letterSpacing: 1.0
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
