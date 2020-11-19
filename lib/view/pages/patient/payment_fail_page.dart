import 'package:flutter/material.dart';
import 'package:greycells/app_theme.dart';
import 'package:greycells/constants/strings.dart';
import 'package:greycells/route/route_name.dart';

class PaymentFailurePage extends StatelessWidget {
  final String paymentId;

  const PaymentFailurePage({Key key, @required this.paymentId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future<bool>.value(false);
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Error while doing payment!",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline5.copyWith(
                          fontWeight: FontWeight.bold,
                        )),
                SizedBox(
                  height: 16.0,
                ),
                Image.asset(
                  "images/desert.png",
                  height: 280.0,
                ),
                SizedBox(
                  height: 16.0,
                ),
                Visibility(
                  visible: paymentId != null,
                  child: Text(
                    "Your payment id is $paymentId",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                        height: 1.3,
                        letterSpacing: 0.5,
                        wordSpacing: 0.7,
                        color: Colors.grey),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  Strings.paymentStatusUnknown,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                      height: 1.3,
                      letterSpacing: 0.5,
                      wordSpacing: 0.7,
                      color: Colors.grey),
                ),
                SizedBox(
                  height: 32.0,
                ),
                OutlineButton(
                  child: Text(
                    "GO HOME".toUpperCase(),
                    style: Theme.of(context).textTheme.button.copyWith(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.7),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        RouteName.DECIDER_PAGE, (route) => false);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
