import 'package:flutter/material.dart';
import 'package:greycells/constants/strings.dart';

class ErrorWithRetry extends StatelessWidget {
  final VoidCallback onRetryPressed;

  ErrorWithRetry({@required this.onRetryPressed})
      : assert(onRetryPressed != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "images/desert.png",
          ),
          Text("Something went wrong!",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5.copyWith(
                    fontWeight: FontWeight.bold,
                  )),
          SizedBox(
            height: 16.0,
          ),
          Text("We are working on it.\nPlease try again in sometime.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                  height: 1.3,
                  letterSpacing: 0.5,
                  wordSpacing: 0.7,
                  color: Colors.grey)),
          SizedBox(
            height: 56.0,
          ),
          OutlineButton.icon(
            onPressed: onRetryPressed,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),),
            padding: EdgeInsets.symmetric(horizontal: 36.0),
            
            icon: Icon(Icons.refresh),
            label: Text(
              Strings.retry.toUpperCase(),
            ),
          )
        ],
      ),
    );
  }
}
