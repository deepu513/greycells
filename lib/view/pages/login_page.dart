import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greycells/bloc/authentication/authentication_bloc.dart';
import 'package:greycells/bloc/authentication/authentication_event.dart';
import 'package:greycells/bloc/authentication/authentication_state.dart';
import 'package:greycells/bloc/validation/bloc.dart';
import 'package:greycells/bloc/validation/validation_field.dart';
import 'package:greycells/constants/strings.dart';
import 'package:greycells/extensions.dart';
import 'package:greycells/route/route_name.dart';
import 'package:greycells/view/widgets/title_with_loading.dart';

class LoginPage extends StatelessWidget {
  final bool shouldShowRegistrationSuccessfulMessage;

  LoginPage({this.shouldShowRegistrationSuccessfulMessage = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black87),
        brightness: Brightness.light,
      ),
      body: SafeArea(
        minimum: EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 16.0),
        child: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, current) {
            if (current is AuthenticationFailure) {
              showErrorDialog(
                  context: context,
                  message: current.error,
                  showIcon: true,
                  onPressed: () async {
                    Navigator.of(context).pop();
                  });
            }
          },
          child: LoginInputSection(
            shouldShowRegistrationSuccessfulMessage:
                shouldShowRegistrationSuccessfulMessage,
          ),
        ),
      ),
    );
  }
}

class LoginInputSection extends StatelessWidget {
  final bool shouldShowRegistrationSuccessfulMessage;

  LoginInputSection({this.shouldShowRegistrationSuccessfulMessage = false});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, authenticationState) {
        return BlocBuilder<ValidationBloc, ValidationState>(
          cubit: BlocProvider.of<AuthenticationBloc>(context).validationBloc,
          builder: (context, validationState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TitleWithLoading(
                  text: Text(
                    Strings.login,
                    style: Theme.of(context).textTheme.headline4.copyWith(
                        color: Colors.black87, fontWeight: FontWeight.w400),
                  ),
                  loadingVisibility:
                      authenticationState is AuthenticationLoading,
                  loadingBackgroundColor: Colors.white,
                ),
                Visibility(
                  visible: shouldShowRegistrationSuccessfulMessage,
                  child: Text(
                    Strings.registrationSuccessMessageOnLogin,
                    overflow: TextOverflow.clip,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                TextField(
                  controller: TextEditingController(
                      text: BlocProvider.of<AuthenticationBloc>(context)
                              .loginRequest
                              .email ??
                          ""),
                  maxLines: 1,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(fontSize: 18.0),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.alternate_email,
                      size: 20.0,
                    ),
                    helperText: Strings.tapToEnter,
                    labelText: Strings.email,
                    contentPadding: EdgeInsets.zero,
                    errorText:
                        validationState.isFieldInvalid(ValidationField.EMAIL)
                            ? ValidationField.EMAIL.errorMessage()
                            : null,
                  ),
                  autofocus: false,
                  enabled: authenticationState is! AuthenticationLoading,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) =>
                      BlocProvider.of<AuthenticationBloc>(context)
                          .loginRequest
                          .email = value.trim(),
                  onEditingComplete: () => FocusScope.of(context).nextFocus(),
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
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(Icons.vpn_key, size: 20.0),
                    suffixIcon: IconButton(
                      icon: BlocProvider.of<AuthenticationBloc>(context)
                              .shouldObscurePassword
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                      iconSize: 20.0,
                      onPressed: () {
                        BlocProvider.of<AuthenticationBloc>(context).add(
                          new TogglePasswordVisibility(),
                        );
                      },
                    ),
                    helperText: Strings.tapToEnter,
                    labelText: Strings.password,
                    contentPadding: EdgeInsets.zero,
                    errorText:
                        validationState.isFieldInvalid(ValidationField.PASSWORD)
                            ? ValidationField.PASSWORD.errorMessage()
                            : null,
                  ),
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  obscureText: BlocProvider.of<AuthenticationBloc>(context)
                      .shouldObscurePassword,
                  enabled: authenticationState is! AuthenticationLoading,
                  textCapitalization: TextCapitalization.words,
                  onChanged: (value) =>
                      BlocProvider.of<AuthenticationBloc>(context)
                          .loginRequest
                          .password = value.trim(),
                  onEditingComplete: () => FocusScope.of(context).unfocus(),
                ),
                SizedBox(
                  height: 24.0,
                ),
                SizedBox(
                  height: 24.0,
                ),
                ButtonTheme(
                  minWidth: double.infinity,
                  height: 48.0,
                  child: RaisedButton(
                    onPressed: authenticationState is AuthenticationLoading
                        ? null
                        : () => {_requestUserLogin(context)},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Text(
                      Strings.login.toUpperCase(),
                      style: Theme.of(context).textTheme.button.copyWith(
                          letterSpacing: 0.7,
                          color: Colors.grey[800],
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FlatButton(
                    onPressed: authenticationState is AuthenticationLoading
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
    );
  }

  _requestUserLogin(BuildContext context) {
    BlocProvider.of<AuthenticationBloc>(context).add(LoginInitiated());
  }
}
