import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health/bloc/authentication/authentication_bloc.dart';
import 'package:mental_health/bloc/authentication/authentication_event.dart';
import 'package:mental_health/bloc/authentication/authentication_state.dart';
import 'package:mental_health/bloc/validation/bloc.dart';
import 'package:mental_health/bloc/validation/validation_field.dart';
import 'package:mental_health/constants/strings.dart';
import 'package:mental_health/extensions.dart';
import 'package:mental_health/route/route_name.dart';

class LoginPage extends StatelessWidget {
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
        minimum: EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 16.0),
        child: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (previous, current) {},
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, authenticationState) {
              return BlocBuilder<ValidationBloc, ValidationState>(
                bloc: BlocProvider.of<AuthenticationBloc>(context).validationBloc,
                builder: (context, validationState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        Strings.login,
                        style: Theme.of(context).textTheme.headline4.copyWith(
                            color: Colors.black, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 48.0,
                      ),
                      TextField(
                        controller: TextEditingController(
                            text: BlocProvider.of<AuthenticationBloc>(context)
                                    .loginRequest
                                    .email ??
                                ""),
                        maxLines: 1,
                        style: TextStyle(fontSize: 18.0),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.alternate_email,
                            size: 20.0,
                          ),
                          helperText: "tap to enter",
                          labelText: Strings.email,
                          contentPadding: EdgeInsets.zero,
                          errorText: validationState
                                  .isFieldInvalid(ValidationField.EMAIL)
                              ? validationState.getErrorMessage()
                              : null,
                        ),
                        autofocus: false,
                        enabled: authenticationState is! AuthenticationLoading,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 36.0,
                      ),
                      TextField(
                        controller: TextEditingController(
                            text: BlocProvider.of<AuthenticationBloc>(context)
                                    .loginRequest
                                    .password ??
                                ""),
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(Icons.vpn_key, size: 20.0),
                          suffixIcon: Icon(
                            Icons.visibility,
                            size: 20.0,
                          ),
                          helperText: "tap to enter",
                          labelText: Strings.password,
                          contentPadding: EdgeInsets.zero,
                          errorText: validationState
                                  .isFieldInvalid(ValidationField.PASSWORD)
                              ? validationState.getErrorMessage()
                              : null,
                        ),
                        autofocus: false,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        enabled: authenticationState is! AuthenticationLoading,
                        textCapitalization: TextCapitalization.words,
                      ),
                      SizedBox(
                        height: 48.0,
                      ),
                      ButtonTheme(
                        minWidth: double.infinity,
                        height: 48.0,
                        child: RaisedButton(
                          onPressed:
                              authenticationState is AuthenticationLoading
                                  ? null
                                  : () => {_requestUserLogin(context)},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Text(
                            Strings.login,
                            style: Theme.of(context)
                                .textTheme
                                .button
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: FlatButton(
                          onPressed:
                              authenticationState is AuthenticationLoading
                                  ? null
                                  : () {
                                      Navigator.pushNamed(
                                          context, RouteName.FORGOT_PASSWORD);
                                    },
                          child: Text(Strings.forgotPassword,
                              style: Theme.of(context).textTheme.caption),
                        ),
                      )
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  _requestUserLogin(BuildContext context) {
    BlocProvider.of<AuthenticationBloc>(context).add(LoginInitiated());
  }
}
