import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greycells/bloc/registration/bloc.dart';
import 'package:greycells/bloc/validation/bloc.dart';
import 'package:greycells/bloc/validation/validation_field.dart';
import 'package:greycells/constants/strings.dart';
import 'package:greycells/extensions.dart';

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
          padding: EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 16.0),
          child: BlocListener<RegistrationBloc, RegistrationState>(
            listener: (previous, current) {},
            child: BlocBuilder<RegistrationBloc, RegistrationState>(
              builder: (context, registrationState) {
                return BlocBuilder<ValidationBloc, ValidationState>(
                  cubit:
                      BlocProvider.of<RegistrationBloc>(context).validationBloc,
                  builder: (context, validationState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          Strings.register,
                          style: Theme.of(context).textTheme.headline4.copyWith(
                              color: Colors.black, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 48.0,
                        ),
                        TextField(
                            controller: TextEditingController(
                                text: BlocProvider.of<RegistrationBloc>(context)
                                        .registration
                                        .firstName ??
                                    ""),
                            maxLines: 1,
                            textInputAction: TextInputAction.next,
                            style: TextStyle(fontSize: 18.0),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                Icons.person,
                                size: 20.0,
                              ),
                              helperText: Strings.tapToEnter,
                              labelText: Strings.firstName,
                              contentPadding: EdgeInsets.zero,
                              errorText: validationState.isFieldInvalid(
                                      ValidationField.FIRST_NAME)
                                  ? ValidationField.FIRST_NAME.errorMessage()
                                  : null,
                            ),
                            autofocus: false,
                            keyboardType: TextInputType.text,
                            enabled:
                                registrationState is! RegistrationInProgress,
                            onChanged: (value) =>
                                BlocProvider.of<RegistrationBloc>(context)
                                    .registration
                                    .firstName = value,
                            onSubmitted: (_) =>
                                FocusScope.of(context).nextFocus()),
                        SizedBox(
                          height: 24.0,
                        ),
                        TextField(
                            maxLines: 1,
                            style: TextStyle(fontSize: 18.0),
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
                            keyboardType: TextInputType.text,
                            controller: TextEditingController(
                                text: BlocProvider.of<RegistrationBloc>(context)
                                        .registration
                                        .lastName ??
                                    ""),
                            onChanged: (value) =>
                                BlocProvider.of<RegistrationBloc>(context)
                                    .registration
                                    .lastName = value,
                            onSubmitted: (_) =>
                                FocusScope.of(context).nextFocus()),
                        SizedBox(
                          height: 24.0,
                        ),
                        TextField(
                            maxLines: 1,
                            textInputAction: TextInputAction.next,
                            style: TextStyle(fontSize: 18.0),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                Icons.phone,
                                size: 20.0,
                              ),
                              helperText: Strings.tapToEnter,
                              labelText: Strings.mobileNumber,
                              contentPadding: EdgeInsets.zero,
                              errorText: validationState.isFieldInvalid(
                                      ValidationField.CONTACT_NUMBER)
                                  ? ValidationField.CONTACT_NUMBER
                                      .errorMessage()
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
                                    .mobileNumber = value,
                            onSubmitted: (_) =>
                                FocusScope.of(context).nextFocus()),
                        SizedBox(
                          height: 24.0,
                        ),
                        TextField(
                            maxLines: 1,
                            textInputAction: TextInputAction.next,
                            style: TextStyle(fontSize: 18.0),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                Icons.email,
                                size: 20.0,
                              ),
                              helperText: Strings.tapToEnter,
                              labelText: Strings.email,
                              contentPadding: EdgeInsets.zero,
                              errorText: validationState
                                      .isFieldInvalid(ValidationField.EMAIL)
                                  ? ValidationField.EMAIL.errorMessage()
                                  : null,
                            ),
                            autofocus: false,
                            keyboardType: TextInputType.emailAddress,
                            controller: TextEditingController(
                                text: BlocProvider.of<RegistrationBloc>(context)
                                        .registration
                                        .email ??
                                    ""),
                            onChanged: (value) =>
                                BlocProvider.of<RegistrationBloc>(context)
                                    .registration
                                    .email = value,
                            onSubmitted: (_) =>
                                FocusScope.of(context).nextFocus()),
                        SizedBox(
                          height: 24.0,
                        ),
                        TextField(
                          maxLines: 1,
                          textInputAction: TextInputAction.next,
                          style: TextStyle(fontSize: 18.0),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.lock,
                              size: 20.0,
                            ),
                            suffixIcon: Icon(
                              Icons.visibility,
                              size: 20.0,
                            ),
                            helperText: Strings.tapToEnter,
                            labelText: Strings.password,
                            contentPadding: EdgeInsets.zero,
                            errorText: validationState
                                    .isFieldInvalid(ValidationField.PASSWORD)
                                ? ValidationField.PASSWORD.errorMessage()
                                : null,
                          ),
                          autofocus: false,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          controller: TextEditingController(
                              text: BlocProvider.of<RegistrationBloc>(context)
                                      .registration
                                      .password ??
                                  ""),
                          onChanged: (value) =>
                              BlocProvider.of<RegistrationBloc>(context)
                                  .registration
                                  .password = value,
                          onSubmitted: (_) =>
                              FocusScope.of(context).nextFocus(),
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        TextField(
                          maxLines: 1,
                          textInputAction: TextInputAction.done,
                          style: TextStyle(fontSize: 18.0),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.brightness_1,
                              size: 20.0,
                              color: Colors.transparent,
                            ),
                            helperText: Strings.tapToEnter,
                            suffixIcon: Icon(
                              Icons.visibility,
                              size: 20.0,
                            ),
                            labelText: Strings.confirmPassword,
                            contentPadding: EdgeInsets.zero,
                            errorText: validationState.isFieldInvalid(
                                    ValidationField.CONFIRM_PASSWORD)
                                ? ValidationField.CONFIRM_PASSWORD
                                    .errorMessage()
                                : null,
                          ),
                          autofocus: false,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          controller: TextEditingController(
                              text: BlocProvider.of<RegistrationBloc>(context)
                                      .registration
                                      .confirmPassword ??
                                  ""),
                          onChanged: (value) =>
                              BlocProvider.of<RegistrationBloc>(context)
                                  .registration
                                  .confirmPassword = value,
                          onSubmitted: (_) => FocusScope.of(context).unfocus(),
                        ),
                        SizedBox(
                          height: 48.0,
                        ),
                        ButtonTheme(
                          minWidth: double.infinity,
                          height: 48.0,
                          child: RaisedButton(
                            onPressed:
                                registrationState is RegistrationInProgress
                                    ? null
                                    : () => {_requestCreateNewUser(context)},
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
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  _requestCreateNewUser(BuildContext context) {
    BlocProvider.of<RegistrationBloc>(context).add(RegistrationCreateUser());
  }
}
