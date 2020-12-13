import 'package:flutter/material.dart';
import 'package:greycells/app_theme.dart';
import 'package:greycells/models/payment/payment_success_args.dart';
import 'package:greycells/models/payment/payment_type.dart';
import 'package:greycells/route/route_name.dart';

class PaymentSuccessPage extends StatelessWidget {
  final PaymentSuccessArgs paymentSuccessArgs;

  const PaymentSuccessPage({
    Key key,
    @required this.paymentSuccessArgs,
  }) : super(key: key);

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
                Text("Payment Successful!",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline5.copyWith(
                          fontWeight: FontWeight.bold,
                        )),
                SizedBox(
                  height: 16.0,
                ),
                Image.asset(
                  "images/success.png",
                  height: 280.0,
                ),
                SizedBox(
                  height: 16.0,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "Your payment id is ",
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          height: 1.3,
                          letterSpacing: 0.5,
                          wordSpacing: 0.7,
                          color: Colors.grey,
                        ),
                    children: [
                      TextSpan(
                        text: paymentSuccessArgs.paymentId,
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                              height: 1.3,
                              letterSpacing: 0.5,
                              wordSpacing: 0.7,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Visibility(
                  visible:
                      paymentSuccessArgs.paymentType == PaymentType.ASSESSMENT,
                  child: Text(
                    "You are now eligible for taking a new assessment test.",
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          height: 1.3,
                          letterSpacing: 0.5,
                          wordSpacing: 0.7,
                          color: Colors.grey,
                        ),
                  ),
                ),
                Visibility(
                  visible:
                      paymentSuccessArgs.paymentType == PaymentType.APPOINTMENT,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "Your appointment is scheduled on ",
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            height: 1.3,
                            letterSpacing: 0.5,
                            wordSpacing: 0.7,
                            color: Colors.grey,
                          ),
                      children: [
                        TextSpan(
                          text: paymentSuccessArgs.appointmentDate,
                          style: Theme.of(context).textTheme.subtitle2.copyWith(
                                height: 1.3,
                                letterSpacing: 0.5,
                                wordSpacing: 0.7,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        TextSpan(
                          text: " at ",
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                height: 1.3,
                                letterSpacing: 0.5,
                                wordSpacing: 0.7,
                                color: Colors.grey,
                              ),
                        ),
                        TextSpan(
                          text: paymentSuccessArgs.appointmentTime,
                          style: Theme.of(context).textTheme.subtitle2.copyWith(
                                height: 1.3,
                                letterSpacing: 0.5,
                                wordSpacing: 0.7,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ),
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
