import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greycells/app_theme.dart';
import 'package:greycells/bloc/registration/bloc.dart';
import 'package:greycells/bloc/validation/bloc.dart';
import 'package:greycells/bloc/validation/validation_field.dart';
import 'package:greycells/constants/strings.dart';
import 'package:greycells/extensions.dart';
import 'package:greycells/route/route_name.dart';
import 'package:greycells/view/widgets/title_with_loading.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 16.0),
          child: Builder(
            builder: (context) {
              return BlocListener<RegistrationBloc, RegistrationState>(
                listener: (context, current) {
                  if (current is RegistrationSuccessful) {
                    Navigator.popAndPushNamed(context, RouteName.LOGIN,
                        arguments: true);
                  }

                  if (current is RegistrationUnsuccessful) {
                    showErrorDialog(
                        context: context,
                        message: current.error,
                        showIcon: true,
                        onPressed: () async {
                          Navigator.of(context).pop();
                        });
                  }
                },
                child: RegisterInputSection(),
              );
            },
          ),
        ),
      ),
    );
  }
}

class RegisterInputSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      builder: (context, registrationState) {
        return BlocBuilder<ValidationBloc, ValidationState>(
          cubit: BlocProvider.of<RegistrationBloc>(context).validationBloc,
          builder: (context, validationState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TitleWithLoading(
                  text: Text(
                    Strings.register,
                    style: Theme.of(context).textTheme.headline4.copyWith(
                        color: Colors.black87, fontWeight: FontWeight.w400),
                  ),
                  loadingVisibility:
                      registrationState is RegistrationInProgress,
                  loadingBackgroundColor: Colors.white,
                ),
                SizedBox(
                  height: 36.0,
                ),
                TextField(
                    controller: TextEditingController(
                        text: BlocProvider.of<RegistrationBloc>(context)
                                .registration
                                .firstName ??
                            ""),
                    maxLines: 1,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(
                        Icons.person,
                        size: 20.0,
                      ),
                      enabled: registrationState is! RegistrationInProgress,
                      helperText: Strings.tapToEnter,
                      labelText: Strings.firstName,
                      contentPadding: EdgeInsets.zero,
                      errorText: validationState
                              .isFieldInvalid(ValidationField.FIRST_NAME)
                          ? ValidationField.FIRST_NAME.errorMessage()
                          : null,
                    ),
                    autofocus: false,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    enabled: registrationState is! RegistrationInProgress,
                    onChanged: (value) =>
                        BlocProvider.of<RegistrationBloc>(context)
                            .registration
                            .firstName = value.trim(),
                    onEditingComplete: () =>
                        FocusScope.of(context).nextFocus()),
                SizedBox(
                  height: 24.0,
                ),
                TextField(
                    maxLines: 1,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(
                        Icons.brightness_1,
                        size: 20.0,
                        color: Colors.transparent,
                      ),
                      helperText: Strings.tapToEnter,
                      labelText: Strings.lastName,
                      contentPadding: EdgeInsets.zero,
                      errorText: validationState
                              .isFieldInvalid(ValidationField.LAST_NAME)
                          ? ValidationField.LAST_NAME.errorMessage()
                          : null,
                    ),
                    autofocus: false,
                    enabled: registrationState is! RegistrationInProgress,
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.text,
                    controller: TextEditingController(
                        text: BlocProvider.of<RegistrationBloc>(context)
                                .registration
                                .lastName ??
                            ""),
                    onChanged: (value) =>
                        BlocProvider.of<RegistrationBloc>(context)
                            .registration
                            .lastName = value.trim(),
                    onEditingComplete: () =>
                        FocusScope.of(context).nextFocus()),
                SizedBox(
                  height: 24.0,
                ),
                TextField(
                    maxLines: 1,
                    maxLength: 10,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(
                        Icons.phone,
                        size: 20.0,
                      ),
                      enabled: registrationState is! RegistrationInProgress,
                      helperText: Strings.tapToEnter,
                      labelText: Strings.mobileNumber,
                      contentPadding: EdgeInsets.zero,
                      errorText: validationState
                              .isFieldInvalid(ValidationField.CONTACT_NUMBER)
                          ? ValidationField.CONTACT_NUMBER.errorMessage()
                          : null,
                    ),
                    autofocus: false,
                    keyboardType: TextInputType.phone,
                    controller: TextEditingController(
                        text: BlocProvider.of<RegistrationBloc>(context)
                                .registration
                                .mobileNumber ??
                            ""),
                    onChanged: (value) =>
                        BlocProvider.of<RegistrationBloc>(context)
                            .registration
                            .mobileNumber = value.trim(),
                    onEditingComplete: () =>
                        FocusScope.of(context).nextFocus()),
                SizedBox(
                  height: 24.0,
                ),
                TextField(
                    maxLines: 1,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(
                        Icons.email,
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
                    enabled: registrationState is! RegistrationInProgress,
                    keyboardType: TextInputType.emailAddress,
                    controller: TextEditingController(
                        text: BlocProvider.of<RegistrationBloc>(context)
                                .registration
                                .email ??
                            ""),
                    onChanged: (value) =>
                        BlocProvider.of<RegistrationBloc>(context)
                            .registration
                            .email = value.trim(),
                    onEditingComplete: () =>
                        FocusScope.of(context).nextFocus()),
                SizedBox(
                  height: 24.0,
                ),
                TextField(
                  maxLines: 1,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.lock,
                      size: 20.0,
                    ),
                    suffixIcon: IconButton(
                      icon: BlocProvider.of<RegistrationBloc>(context)
                              .shouldObscurePassword
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                      onPressed: () {
                        BlocProvider.of<RegistrationBloc>(context)
                            .add(new TogglePasswordVisibility());
                      },
                      iconSize: 20.0,
                    ),
                    helperText: Strings.tapToEnter,
                    labelText: Strings.password,
                    contentPadding: EdgeInsets.zero,
                    errorText: _getPasswordErrorMessage(validationState),
                  ),
                  autofocus: false,
                  enabled: registrationState is! RegistrationInProgress,
                  obscureText: BlocProvider.of<RegistrationBloc>(context)
                      .shouldObscurePassword,
                  keyboardType: TextInputType.text,
                  controller: TextEditingController(
                      text: BlocProvider.of<RegistrationBloc>(context)
                              .registration
                              .password ??
                          ""),
                  onChanged: (value) =>
                      BlocProvider.of<RegistrationBloc>(context)
                          .registration
                          .password = value.trim(),
                  onEditingComplete: () => FocusScope.of(context).nextFocus(),
                ),
                SizedBox(
                  height: 24.0,
                ),
                TextField(
                  maxLines: 1,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.brightness_1,
                      size: 20.0,
                      color: Colors.transparent,
                    ),
                    helperText: Strings.tapToEnter,
                    suffixIcon: IconButton(
                      icon: BlocProvider.of<RegistrationBloc>(context)
                              .shouldObscureConfirmPassword
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                      iconSize: 20.0,
                      onPressed: () {
                        BlocProvider.of<RegistrationBloc>(context)
                            .add(new ToggleConfirmPasswordVisibility());
                      },
                    ),
                    labelText: Strings.confirmPassword,
                    contentPadding: EdgeInsets.zero,
                    errorText: validationState
                            .isFieldInvalid(ValidationField.CONFIRM_PASSWORD)
                        ? ValidationField.CONFIRM_PASSWORD.errorMessage()
                        : null,
                  ),
                  autofocus: false,
                  obscureText: BlocProvider.of<RegistrationBloc>(context)
                      .shouldObscureConfirmPassword,
                  keyboardType: TextInputType.text,
                  enabled: registrationState is! RegistrationInProgress,
                  controller: TextEditingController(
                      text: BlocProvider.of<RegistrationBloc>(context)
                              .registration
                              .confirmPassword ??
                          ""),
                  onChanged: (value) =>
                      BlocProvider.of<RegistrationBloc>(context)
                          .registration
                          .confirmPassword = value.trim(),
                  onEditingComplete: () => FocusScope.of(context).unfocus(),
                ),
                SizedBox(
                  height: 24.0,
                ),
                Row(
                  children: [
                    Checkbox(
                      value:
                          BlocProvider.of<RegistrationBloc>(context).tncAgreed,
                      onChanged: (checked) {
                        BlocProvider.of<RegistrationBloc>(context)
                            .add(new ToggleTnc());
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        launch('https://greycellswellness.com/privacy');
                      },
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'I agree to ',
                              style: TextStyle(color: Colors.black),
                            ),
                            TextSpan(
                              text: 'Terms & Conditions',
                              style: TextStyle(color: Colors.blue),
                            ),
                            TextSpan(
                              text: '.',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 24.0,
                ),
                ButtonTheme(
                  minWidth: double.infinity,
                  height: 48.0,
                  child: RaisedButton(
                    onPressed: registrationState is RegistrationInProgress ||
                            BlocProvider.of<RegistrationBloc>(context)
                                    .tncAgreed ==
                                false
                        ? null
                        : () => {_requestCreateNewUser(context)},
                    color: AppTheme.secondaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Text(
                      Strings.register.toUpperCase(),
                      style: Theme.of(context).textTheme.button.copyWith(
                          letterSpacing: 0.7,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  _requestCreateNewUser(BuildContext context) {
    BlocProvider.of<RegistrationBloc>(context).add(RegistrationCreateUser());
  }

  _getPasswordErrorMessage(ValidationState validationState) {
    if (validationState.isFieldInvalid(ValidationField.PASSWORD))
      return ValidationField.PASSWORD.errorMessage();
    if (validationState.isFieldInvalid(ValidationField.LENGTH))
      return ValidationField.LENGTH.errorMessage();
    return null;
  }
}
