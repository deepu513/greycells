import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health/bloc/address_details/address_details_bloc.dart';
import 'package:mental_health/bloc/validation/bloc.dart';
import 'package:mental_health/bloc/validation/validation_bloc.dart';
import 'package:mental_health/bloc/validation/validation_field.dart';
import 'package:mental_health/bloc/validation/validation_state.dart';
import 'package:mental_health/constants/strings.dart';
import 'package:mental_health/extensions.dart';
import 'package:mental_health/interface/validatable.dart';
import 'package:mental_health/view/widgets/no_glow_scroll_behaviour.dart';

class AddressDetailInputPage extends StatelessWidget implements Validatable {
  const AddressDetailInputPage();

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: NoGlowScrollBehaviour(),
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: <Widget>[
                Text(
                  Strings.addressDetails,
                  style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Colors.black, fontWeight: FontWeight.w400),
                ),
                Spacer(),
                IconButton(
                  onPressed: () => showInfoDialog(context),
                  icon: Icon(Icons.info_outline),
                )
              ],
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          PatientAddressInput(),
          Divider(),
          GuardianAddressInput()
        ],
      ),
    );
  }

  void showInfoDialog(BuildContext context) {
    showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: Text(Strings.info),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(Strings.addressDetailsInfo),
                ],
              ),
            ),
            actions: [
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  FutureOr<bool> validate(BuildContext context, ValidationBloc validationBloc) {
    final completer = Completer<bool>();

    StreamSubscription subscription;

    subscription = validationBloc.listen((validationState) {
      if (validationState is AddressFieldsValid) {
        completer.complete(true);
      } else if (validationState is ValidationInvalidField) {
        completer.complete(false);
      } else {
        completer.completeError(Exception());
      }
      subscription.cancel();
    });

    validationBloc.add(ValidateAddressFields(
        BlocProvider.of<AddressDetailsBloc>(context).address));

    return completer.future;
  }
}

class PatientAddressInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: BlocBuilder<ValidationBloc, ValidationState>(
        builder: (context, validationState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                  maxLines: 1,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(Icons.home),
                    helperText: Strings.tapToEnter,
                    labelText: Strings.houseNumber,
                    contentPadding: EdgeInsets.zero,
                    errorText: validationState
                            .isFieldInvalid(ValidationField.HOUSE_NUMBER)
                        ? ValidationField.HOUSE_NUMBER.errorMessage()
                        : null,
                  ),
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  controller: TextEditingController(
                      text: BlocProvider.of<AddressDetailsBloc>(context)
                              .address
                              .houseNumber ??
                          ""),
                  onChanged: (value) =>
                      BlocProvider.of<AddressDetailsBloc>(context)
                          .address
                          .houseNumber = value,
                  onSubmitted: (_) => FocusScope.of(context).nextFocus()),
              SizedBox(
                height: 16.0,
              ),
              TextField(
                  maxLines: 1,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    icon: Icon(Icons.nature),
                    border: InputBorder.none,
                    helperText: Strings.tapToEnter,
                    labelText: Strings.roadName,
                    contentPadding: EdgeInsets.zero,
                    errorText: validationState
                            .isFieldInvalid(ValidationField.ROAD_NAME)
                        ? ValidationField.ROAD_NAME.errorMessage()
                        : null,
                  ),
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  controller: TextEditingController(
                      text: BlocProvider.of<AddressDetailsBloc>(context)
                              .address
                              .roadName ??
                          ""),
                  onChanged: (value) =>
                      BlocProvider.of<AddressDetailsBloc>(context)
                          .address
                          .roadName = value,
                  onSubmitted: (_) => FocusScope.of(context).nextFocus()),
              SizedBox(
                height: 16.0,
              ),
              TextField(
                  maxLines: 1,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    icon: Icon(Icons.location_city),
                    border: InputBorder.none,
                    helperText: Strings.tapToEnter,
                    labelText: Strings.city,
                    contentPadding: EdgeInsets.zero,
                    errorText:
                        validationState.isFieldInvalid(ValidationField.CITY)
                            ? ValidationField.CITY.errorMessage()
                            : null,
                  ),
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  controller: TextEditingController(
                      text: BlocProvider.of<AddressDetailsBloc>(context)
                              .address
                              .city ??
                          ""),
                  onChanged: (value) =>
                      BlocProvider.of<AddressDetailsBloc>(context)
                          .address
                          .city = value,
                  onSubmitted: (_) => FocusScope.of(context).nextFocus()),
              SizedBox(
                height: 16.0,
              ),
              TextField(
                  maxLines: 1,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    icon: Icon(Icons.my_location),
                    border: InputBorder.none,
                    helperText: Strings.tapToEnter,
                    labelText: Strings.state,
                    contentPadding: EdgeInsets.zero,
                    errorText:
                        validationState.isFieldInvalid(ValidationField.STATE)
                            ? ValidationField.STATE.errorMessage()
                            : null,
                  ),
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  controller: TextEditingController(
                      text: BlocProvider.of<AddressDetailsBloc>(context)
                              .address
                              .state ??
                          ""),
                  onChanged: (value) =>
                      BlocProvider.of<AddressDetailsBloc>(context)
                          .address
                          .state = value,
                  onSubmitted: (_) => FocusScope.of(context).nextFocus()),
              SizedBox(
                height: 16.0,
              ),
              TextField(
                  maxLines: 1,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    icon: Icon(Icons.map),
                    border: InputBorder.none,
                    helperText: Strings.tapToEnter,
                    labelText: Strings.country,
                    contentPadding: EdgeInsets.zero,
                    errorText:
                        validationState.isFieldInvalid(ValidationField.COUNTRY)
                            ? ValidationField.COUNTRY.errorMessage()
                            : null,
                  ),
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  controller: TextEditingController(
                      text: BlocProvider.of<AddressDetailsBloc>(context)
                              .address
                              .country ??
                          ""),
                  onChanged: (value) =>
                      BlocProvider.of<AddressDetailsBloc>(context)
                          .address
                          .country = value,
                  onSubmitted: (_) => FocusScope.of(context).nextFocus()),
              SizedBox(
                height: 16.0,
              ),
              TextField(
                  maxLines: 1,
                  textInputAction: TextInputAction.next,
                  maxLength: 10,
                  decoration: InputDecoration(
                    icon: Icon(Icons.pin_drop),
                    border: InputBorder.none,
                    helperText: Strings.tapToEnter,
                    labelText: Strings.pincode,
                    contentPadding: EdgeInsets.zero,
                    errorText:
                        validationState.isFieldInvalid(ValidationField.PINCODE)
                            ? ValidationField.PINCODE.errorMessage()
                            : null,
                  ),
                  autofocus: false,
                  keyboardType: TextInputType.number,
                  buildCounter: (BuildContext context,
                          {int currentLength, int maxLength, bool isFocused}) =>
                      null,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                  controller: TextEditingController(
                      text: BlocProvider.of<AddressDetailsBloc>(context)
                              .address
                              .pincode ??
                          ""),
                  onChanged: (value) =>
                      BlocProvider.of<AddressDetailsBloc>(context)
                          .address
                          .pincode = value,
                  onSubmitted: (_) => FocusScope.of(context).unfocus()),
              SizedBox(
                height: 16.0,
              ),
            ],
          );
        },
      ),
    );
  }
}

// Show this only if patient is a minor
class GuardianAddressInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            Strings.guardianAddress,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
          ),
        ),
        CheckboxListTile(
          value: false,
          onChanged: (value) {},
          title: Text(
            Strings.sameAsAbove,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          subtitle: Text(Strings.liveWithGuardian),
        ),
        SizedBox(
          height: 8.0,
        ),
        AnimatedOpacity(
            opacity: 1.0,
            duration: Duration(milliseconds: 600),
            child: GuardianAddressInputFields())
      ],
    );
  }
}

class GuardianAddressInputFields extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: BlocBuilder<ValidationBloc, ValidationState>(
        builder: (context, validationState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                  maxLines: 1,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(Icons.home),
                    helperText: Strings.tapToEnter,
                    labelText: Strings.houseNumber,
                    contentPadding: EdgeInsets.zero,
                    errorText: validationState.isFieldInvalid(
                            ValidationField.GUARDIAN_HOUSE_NUMBER)
                        ? ValidationField.GUARDIAN_HOUSE_NUMBER.errorMessage()
                        : null,
                  ),
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  controller: TextEditingController(
                      text: BlocProvider.of<AddressDetailsBloc>(context)
                              .address
                              .guardianAddress
                              .houseNumber ??
                          ""),
                  onChanged: (value) =>
                      BlocProvider.of<AddressDetailsBloc>(context)
                          .address
                          .guardianAddress
                          .houseNumber = value,
                  onSubmitted: (_) => FocusScope.of(context).nextFocus()),
              SizedBox(
                height: 16.0,
              ),
              TextField(
                  maxLines: 1,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    icon: Icon(Icons.nature),
                    border: InputBorder.none,
                    helperText: Strings.tapToEnter,
                    labelText: Strings.roadName,
                    contentPadding: EdgeInsets.zero,
                    errorText: validationState
                            .isFieldInvalid(ValidationField.GUARDIAN_ROAD_NAME)
                        ? ValidationField.GUARDIAN_ROAD_NAME.errorMessage()
                        : null,
                  ),
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  controller: TextEditingController(
                      text: BlocProvider.of<AddressDetailsBloc>(context)
                              .address
                              .guardianAddress
                              .roadName ??
                          ""),
                  onChanged: (value) =>
                      BlocProvider.of<AddressDetailsBloc>(context)
                          .address
                          .guardianAddress
                          .roadName = value,
                  onSubmitted: (_) => FocusScope.of(context).nextFocus()),
              SizedBox(
                height: 16.0,
              ),
              TextField(
                  maxLines: 1,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    icon: Icon(Icons.location_city),
                    border: InputBorder.none,
                    helperText: Strings.tapToEnter,
                    labelText: Strings.city,
                    contentPadding: EdgeInsets.zero,
                    errorText: validationState
                            .isFieldInvalid(ValidationField.GUARDIAN_CITY)
                        ? ValidationField.GUARDIAN_CITY.errorMessage()
                        : null,
                  ),
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  controller: TextEditingController(
                      text: BlocProvider.of<AddressDetailsBloc>(context)
                              .address
                              .guardianAddress
                              .city ??
                          ""),
                  onChanged: (value) =>
                      BlocProvider.of<AddressDetailsBloc>(context)
                          .address
                          .guardianAddress
                          .city = value,
                  onSubmitted: (_) => FocusScope.of(context).nextFocus()),
              SizedBox(
                height: 16.0,
              ),
              TextField(
                  maxLines: 1,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    icon: Icon(Icons.my_location),
                    border: InputBorder.none,
                    helperText: Strings.tapToEnter,
                    labelText: Strings.state,
                    contentPadding: EdgeInsets.zero,
                    errorText: validationState
                            .isFieldInvalid(ValidationField.GUARDIAN_STATE)
                        ? ValidationField.GUARDIAN_STATE.errorMessage()
                        : null,
                  ),
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  controller: TextEditingController(
                      text: BlocProvider.of<AddressDetailsBloc>(context)
                              .address
                              .guardianAddress
                              .state ??
                          ""),
                  onChanged: (value) =>
                      BlocProvider.of<AddressDetailsBloc>(context)
                          .address
                          .guardianAddress
                          .state = value,
                  onSubmitted: (_) => FocusScope.of(context).nextFocus()),
              SizedBox(
                height: 16.0,
              ),
              TextField(
                  maxLines: 1,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    icon: Icon(Icons.map),
                    border: InputBorder.none,
                    helperText: Strings.tapToEnter,
                    labelText: Strings.country,
                    contentPadding: EdgeInsets.zero,
                    errorText: validationState
                            .isFieldInvalid(ValidationField.GUARDIAN_COUNTRY)
                        ? ValidationField.GUARDIAN_COUNTRY.errorMessage()
                        : null,
                  ),
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  controller: TextEditingController(
                      text: BlocProvider.of<AddressDetailsBloc>(context)
                              .address
                              .guardianAddress
                              .country ??
                          ""),
                  onChanged: (value) =>
                      BlocProvider.of<AddressDetailsBloc>(context)
                          .address
                          .guardianAddress
                          .country = value,
                  onSubmitted: (_) => FocusScope.of(context).nextFocus()),
              SizedBox(
                height: 16.0,
              ),
              TextField(
                  maxLines: 1,
                  textInputAction: TextInputAction.next,
                  maxLength: 10,
                  decoration: InputDecoration(
                    icon: Icon(Icons.pin_drop),
                    border: InputBorder.none,
                    helperText: Strings.tapToEnter,
                    labelText: Strings.pincode,
                    contentPadding: EdgeInsets.zero,
                    errorText: validationState
                            .isFieldInvalid(ValidationField.GUARDIAN_PINCODE)
                        ? ValidationField.GUARDIAN_PINCODE.errorMessage()
                        : null,
                  ),
                  autofocus: false,
                  keyboardType: TextInputType.number,
                  buildCounter: (BuildContext context,
                          {int currentLength, int maxLength, bool isFocused}) =>
                      null,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                  controller: TextEditingController(
                      text: BlocProvider.of<AddressDetailsBloc>(context)
                              .address
                              .guardianAddress
                              .pincode ??
                          ""),
                  onChanged: (value) =>
                      BlocProvider.of<AddressDetailsBloc>(context)
                          .address
                          .guardianAddress
                          .pincode = value,
                  onSubmitted: (_) => FocusScope.of(context).unfocus()),
              SizedBox(
                height: 16.0,
              ),
            ],
          );
        },
      ),
    );
  }
}
