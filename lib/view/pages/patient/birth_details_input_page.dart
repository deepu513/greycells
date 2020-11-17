import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greycells/bloc/patient_details/patient_details_bloc.dart';
import 'package:greycells/bloc/validation/bloc.dart';
import 'package:greycells/bloc/validation/validation_field.dart';
import 'package:greycells/constants/strings.dart';
import 'package:greycells/extensions.dart';
import 'package:greycells/interface/validatable.dart';

class BirthDetailsInputPage extends StatelessWidget implements Validatable {
  const BirthDetailsInputPage();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                Strings.birthDetails,
                style: Theme.of(context).textTheme.headline6.copyWith(
                    color: Colors.black87, fontWeight: FontWeight.w400),
              ),
              Spacer(),
              IconButton(
                onPressed: () => showInfoDialog(context),
                icon: Icon(Icons.info_outline),
              )
            ],
          ),
          Text(Strings.mandatoryFields,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(color: Colors.grey[600], fontSize: 12.0)),
          SizedBox(
            height: 32.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: PlaceOfBirthInput(),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: DateOfBirthInput(),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TimeOfBirthWidget(),
          ),
          Spacer(),
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
                  Text(Strings.birthDetailsInfo),
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
      if (validationState is BirthDetailsValid) {
        BlocProvider.of<PatientDetailsBloc>(context)
            .add(BirthDetailsValidated());
        completer.complete(true);
      } else if (validationState is ValidationInvalidField) {
        completer.complete(false);
      } else {
        completer.completeError(Exception());
      }
      subscription.cancel();
    });

    validationBloc.add(ValidateBirthDetailsFields(
        BlocProvider.of<PatientDetailsBloc>(context).patient));

    return completer.future;
  }
}

class PlaceOfBirthInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ValidationBloc, ValidationState>(
      builder: (context, validationState) {
        return TextField(
          controller: TextEditingController(
              text: BlocProvider.of<PatientDetailsBloc>(context)
                      .patient
                      .placeOfBirth ??
                  ""),
          maxLines: 1,
          maxLength: 50,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            border: InputBorder.none,
            icon: Icon(
              Icons.add_location,
              size: 20.0,
            ),
            helperText: Strings.tapToEnter,
            labelText: Strings.placeOfBirth,
            contentPadding: EdgeInsets.zero,
            errorText:
                validationState.isFieldInvalid(ValidationField.PLACE_PART)
                    ? ValidationField.PLACE_PART.errorMessage()
                    : null,
          ),
          autofocus: false,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          buildCounter: (BuildContext context,
                  {int currentLength, int maxLength, bool isFocused}) =>
              null,
          onChanged: (value) => BlocProvider.of<PatientDetailsBloc>(context)
              .patient
              .placeOfBirth = value,
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
        );
      },
    );
  }
}

class DateOfBirthInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            Icon(
              Icons.event,
              color: Colors.black54,
              size: 18.0,
            ),
            SizedBox(
              width: 16.0,
            ),
            Text(Strings.dateOfBirth,
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                    fontWeight: FontWeight.w400, color: Colors.black54)),
          ],
        ),
        SizedBox(
          height: 12.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: BlocBuilder<ValidationBloc, ValidationState>(
            builder: (context, validationState) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: TextField(
                        controller: TextEditingController(
                            text: BlocProvider.of<PatientDetailsBloc>(context)
                                    .patient
                                    .dayPart ??
                                ""),
                        maxLength: 2,
                        textInputAction: TextInputAction.next,
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                            labelText: "dd",
                            labelStyle:
                                TextStyle(color: Theme.of(context).accentColor),
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none),
                        keyboardType: TextInputType.number,
                        buildCounter: (BuildContext context,
                                {int currentLength,
                                int maxLength,
                                bool isFocused}) =>
                            null,
                        onChanged: (value) {
                          if (value.length == 2)
                            FocusScope.of(context).nextFocus();

                          BlocProvider.of<PatientDetailsBloc>(context)
                              .patient
                              .dayPart = value.padLeft(2, '0');
                        },
                        onEditingComplete: () =>
                            FocusScope.of(context).nextFocus()),
                  ),
                  Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text("/",
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w400)),
                      )),
                  Expanded(
                    flex: 2,
                    child: TextField(
                        controller: TextEditingController(
                            text: BlocProvider.of<PatientDetailsBloc>(context)
                                    .patient
                                    .monthPart ??
                                ""),
                        maxLength: 2,
                        textInputAction: TextInputAction.next,
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                            labelText: "mm",
                            labelStyle:
                                TextStyle(color: Theme.of(context).accentColor),
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none),
                        keyboardType: TextInputType.number,
                        buildCounter: (BuildContext context,
                                {int currentLength,
                                int maxLength,
                                bool isFocused}) =>
                            null,
                        onChanged: (value) {
                          if (value.length == 2)
                            FocusScope.of(context).nextFocus();

                          BlocProvider.of<PatientDetailsBloc>(context)
                              .patient
                              .monthPart = value.padLeft(2, '0');
                        },
                        onEditingComplete: () =>
                            FocusScope.of(context).nextFocus()),
                  ),
                  Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text("/",
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w400)),
                      )),
                  Expanded(
                    flex: 2,
                    child: TextField(
                        controller: TextEditingController(
                            text: BlocProvider.of<PatientDetailsBloc>(context)
                                    .patient
                                    .yearPart ??
                                ""),
                        maxLength: 4,
                        textInputAction: TextInputAction.next,
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                            labelText: "yyyy",
                            labelStyle:
                                TextStyle(color: Theme.of(context).accentColor),
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none),
                        keyboardType: TextInputType.number,
                        buildCounter: (BuildContext context,
                                {int currentLength,
                                int maxLength,
                                bool isFocused}) =>
                            null,
                        onChanged: (value) {
                          if (value.length == 4)
                            FocusScope.of(context).nextFocus();
                          BlocProvider.of<PatientDetailsBloc>(context)
                              .patient
                              .yearPart = value.padLeft(4, '0');
                        },
                        onEditingComplete: () =>
                            FocusScope.of(context).nextFocus()),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(),
                  )
                ],
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: BlocBuilder<ValidationBloc, ValidationState>(
            builder: (context, validationState) {
              return Visibility(
                visible:
                    validationState.isFieldInvalid(ValidationField.DATE_PART),
                child: Text(
                  validationState.isFieldInvalid(ValidationField.DATE_PART)
                      ? ValidationField.DATE_PART.errorMessage()
                      : "",
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(color: Colors.red),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class TimeOfBirthWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            Icon(
              Icons.access_time,
              color: Colors.black54,
              size: 18.0,
            ),
            SizedBox(
              width: 16.0,
            ),
            Text(Strings.timeOfBirth,
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                    fontWeight: FontWeight.w400, color: Colors.black54)),
          ],
        ),
        SizedBox(
          height: 12.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: BlocBuilder<ValidationBloc, ValidationState>(
            builder: (context, validationState) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: TextField(
                        controller: TextEditingController(
                            text: BlocProvider.of<PatientDetailsBloc>(context)
                                    .patient
                                    .hourPart ??
                                ""),
                        maxLength: 2,
                        textInputAction: TextInputAction.next,
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                            labelText: "hrs",
                            labelStyle:
                                TextStyle(color: Theme.of(context).accentColor),
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none),
                        keyboardType: TextInputType.number,
                        buildCounter: (BuildContext context,
                                {int currentLength,
                                int maxLength,
                                bool isFocused}) =>
                            null,
                        onChanged: (value) {
                          if (value.length == 2)
                            FocusScope.of(context).nextFocus();
                          BlocProvider.of<PatientDetailsBloc>(context)
                              .patient
                              .hourPart = value.padLeft(2, '0');
                        },
                        onEditingComplete: () =>
                            FocusScope.of(context).nextFocus()),
                  ),
                  Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(":",
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w400)),
                      )),
                  Expanded(
                    flex: 2,
                    child: TextField(
                        controller: TextEditingController(
                            text: BlocProvider.of<PatientDetailsBloc>(context)
                                    .patient
                                    .minutePart ??
                                ""),
                        maxLength: 2,
                        textInputAction: TextInputAction.done,
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                            labelText: "min",
                            labelStyle:
                                TextStyle(color: Theme.of(context).accentColor),
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none),
                        keyboardType: TextInputType.number,
                        buildCounter: (BuildContext context,
                                {int currentLength,
                                int maxLength,
                                bool isFocused}) =>
                            null,
                        onChanged: (value) {
                          if (value.length == 2)
                            FocusScope.of(context).unfocus();

                          BlocProvider.of<PatientDetailsBloc>(context)
                              .patient
                              .minutePart = value.padLeft(2, '0');
                        },
                        onEditingComplete: () =>
                            FocusScope.of(context).nextFocus()),
                  ),
                  SizedBox(width: 8.0),
                  _AmPmToggle(),
                  Expanded(
                    flex: 2,
                    child: Container(),
                  )
                ],
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: BlocBuilder<ValidationBloc, ValidationState>(
            builder: (context, validationState) {
              return Visibility(
                visible:
                    validationState.isFieldInvalid(ValidationField.TIME_PART),
                child: Text(
                  validationState.isFieldInvalid(ValidationField.TIME_PART)
                      ? ValidationField.TIME_PART.errorMessage()
                      : "",
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(color: Colors.red),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _AmPmToggle extends StatefulWidget {
  @override
  _AmPmToggleState createState() => _AmPmToggleState();
}

class _AmPmToggleState extends State<_AmPmToggle> {
  int _selectedIndex;
  List<String> _options;
  List<bool> _selections;

  @override
  void initState() {
    super.initState();

    _selectedIndex = 0;
    _options = ["AM", "PM"];
    _selections = List.generate(2, (index) => index == _selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      children: List<Widget>.generate(
          _options.length, (index) => Text(_options[index], style: Theme.of(context).textTheme.bodyText1,)),
      borderRadius: BorderRadius.circular(8.0),
      selectedBorderColor: Colors.blue,
      isSelected: _selections,
      onPressed: (index) {
        setState(() {
          _selections[_selectedIndex] = false;
          _selections[index] = !_selections[index];
          _selectedIndex = index;

          BlocProvider.of<PatientDetailsBloc>(context).patient.a =
              _options[index];
        });
      },
    );
  }
}
