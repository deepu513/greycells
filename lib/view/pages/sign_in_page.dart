import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mental_health/constants/strings.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[800],
      body: SafeArea(
        minimum: EdgeInsets.only(
          top: 64.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                Strings.welcome,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                Strings.signIn,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 36.0,
                    fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(32.0, 72.0, 32.0, 24.0),
                width: double.infinity,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50.0),
                        topRight: Radius.circular(50.0)),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      Strings.email,
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[600]),
                    ),
                    TextField(
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                          hintText: "youremail@xyz.com",
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[400]))),
                      autofocus: false,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 36.0,
                    ),
                    Text(
                      Strings.password,
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[600]),
                    ),
                    TextField(
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                          hintText: "Enter password",
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[400]))),
                      autofocus: false,
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        Strings.forgotPassword,
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey[600]),
                      ),
                    ),
                    SizedBox(
                      height: 56.0,
                    ),
                    ButtonTheme(
                      minWidth: double.infinity,
                      height: 56.0,
                      child: RaisedButton(
                        onPressed: () => {},
                        color: Colors.orange[800],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0)
                        ),
                        textColor: Colors.white,
                        child: Text(
                          Strings.signIn,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 32.0,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        Strings.register,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
