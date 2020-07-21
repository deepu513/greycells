import 'package:flutter/material.dart';
import 'package:mental_health/constants/strings.dart';

class ForgotPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        brightness: Brightness.light,
      ),
      body: SafeArea(
        minimum: EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              Strings.forgotPasswordTitle,
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .copyWith(color: Colors.black, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 16.0,
            ),
            Text(
              Strings.resetPasswordMessage,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
            ),
            SizedBox(
              height: 56.0,
            ),
            TextField(
              maxLines: 1,
              decoration: InputDecoration(
                labelText: Strings.email,
              ),
              autofocus: false,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 48.0,
            ),
            ButtonTheme(
              minWidth: double.infinity,
              height: 48.0,
              child: RaisedButton(
                onPressed: () => {},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                child: Text(
                  Strings.confirm,
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
