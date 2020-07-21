import 'package:flutter/material.dart';
import 'package:mental_health/constants/strings.dart';

class RegisterPage extends StatelessWidget {
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
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                Strings.register,
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: Colors.black, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 56.0,
              ),
              TextField(
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: Strings.firstName,
                ),
                autofocus: false,
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 24.0,
              ),
              TextField(
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: Strings.lastName,
                ),
                autofocus: false,
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 24.0,
              ),
              TextField(
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: Strings.mobileNumber,
                ),
                autofocus: false,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(
                height: 24.0,
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
                height: 24.0,
              ),
              TextField(
                maxLines: 1,
                style: TextStyle(fontSize: 18.0),
                decoration: InputDecoration(
                    labelText: Strings.password,
                    suffixIcon: Icon(
                      Icons.visibility,
                    )),
                autofocus: false,
                obscureText: true,
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 24.0,
              ),
              TextField(
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: Strings.confirmPassword,
                    suffixIcon: Icon(
                      Icons.visibility,
                    ),
                ),
                autofocus: false,
                obscureText: true,
                keyboardType: TextInputType.text,
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
                    Strings.register,
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
      ),
    );
  }
}
