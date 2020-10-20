import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greycells/bloc/patient_details/patient_details_bloc.dart';
import 'package:greycells/bloc/validation/bloc.dart';
import 'package:greycells/bloc/validation/validation_bloc.dart';
import 'package:greycells/bloc/validation/validation_field.dart';
import 'package:greycells/constants/relationship.dart';
import 'package:greycells/constants/strings.dart';
import 'package:greycells/extensions.dart';
import 'package:greycells/interface/validatable.dart';
import 'package:greycells/view/widgets/no_glow_scroll_behaviour.dart';

class GuardianDetailsInputPage extends StatelessWidget implements Validatable {
  const GuardianDetailsInputPage();

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
                  Strings.guardianDetails,
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
            height: 36.0,
          ),
          // Relationship, guardian name, guardian mobile number, guardian address
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: BlocBuilder<PatientDetailsBloc, PatientDetailsState>(
              builder: (context, state) {
                return GuardianRelationshipInput(
                    BlocProvider.of<PatientDetailsBloc>(context)
                        .patient
                        .guardian
                        .relationShip, (relationShip) {
                  BlocProvider.of<PatientDetailsBloc>(context)
                      .add(UpdateGuardianRelationship(relationShip));
                });
              },
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          BlocBuilder<PatientDetailsBloc, PatientDetailsState>(
            builder: (context, state) {
              return Visibility(
                visible: BlocProvider.of<PatientDetailsBloc>(context)
                        .patient
                        .guardian
                        .relationShip ==
                    Relationship.other,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: _SpecifyRelationshipInput(),
                ),
              );
            },
          ),
          SizedBox(
            height: 24.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: GuardianFirstNameInput(),
          ),
          SizedBox(
            height: 12.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: GuardianLastNameInput(),
          ),
          SizedBox(
            height: 12.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: GuardianMobileNumberInput((mobileNumber) {
              BlocProvider.of<PatientDetailsBloc>(context)
                  .patient
                  .guardian
                  .mobileNumber = mobileNumber;
            }),
          ),
          SizedBox(
            height: 12.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: GuardianEmailInput((email) {
              BlocProvider.of<PatientDetailsBloc>(context)
                  .patient
                  .guardian
                  .email = email;
            }),
          ),
          SizedBox(
            height: 16.0,
          ),
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
                  Text(Strings.guardianDetailsInfo),
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
      if (validationState is GuardianDetailsValid) {
        completer.complete(true);
      } else if (validationState is ValidationInvalidField) {
        completer.complete(false);
      } else {
        completer.completeError(Exception());
      }
      subscription.cancel();
    });

    validationBloc.add(ValidateGuardianDetailsFields(
        BlocProvider.of<PatientDetailsBloc>(context).patient));

    return completer.future;
  }
}

class GuardianRelationshipInput extends StatefulWidget {
  final Relationship initialRelationship;
  final ValueChanged<Relationship> onRelationshipSelected;

  GuardianRelationshipInput(
      this.initialRelationship, this.onRelationshipSelected);

  @override
  _GuardianRelationshipInputState createState() =>
      _GuardianRelationshipInputState();
}

class _GuardianRelationshipInputState extends State<GuardianRelationshipInput> {
  List<Relationship> relationShipList;
  List<bool> _toggleStateList;
  int _selectedIndex;

  @override
  void initState() {
    super.initState();
    relationShipList = Relationship.values();
    _selectedIndex = relationShipList.indexWhere((element) {
      return element.toString() == widget.initialRelationship.toString();
    });
    _toggleStateList = List.generate(5, (index) => index == _selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Your relationship with guardian",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400)),
        SizedBox(
          height: 8.0,
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            return ToggleButtons(
              children: relationShipList
                  .map((value) => Text(value.toString()))
                  .toList(),
              constraints: BoxConstraints.expand(
                  width:
                      (constraints.maxWidth - 24.0) / relationShipList.length,
                  height: 48.0),
              isSelected: _toggleStateList,
              onPressed: (index) {
                _toggleStateList[_selectedIndex] =
                    !_toggleStateList[_selectedIndex];
                _selectedIndex = index;
                _toggleStateList[_selectedIndex] =
                    !_toggleStateList[_selectedIndex];
                widget.onRelationshipSelected.call(relationShipList[index]);
              },
            );
          },
        ),
      ],
    );
  }
}

class _SpecifyRelationshipInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ValidationBloc, ValidationState>(
      builder: (context, validationState) {
        return TextField(
          controller: TextEditingController(
              text: BlocProvider.of<PatientDetailsBloc>(context)
                      .patient
                      .guardian
                      .readableRelationship ??
                  ""),
          maxLines: 1,
          decoration: InputDecoration(
            border: InputBorder.none,
            helperText: Strings.tapToEnter,
            labelText: Strings.specifyRelationship,
            contentPadding: EdgeInsets.zero,
            labelStyle: TextStyle(color: Theme.of(context).accentColor),
            errorText:
                validationState.isFieldInvalid(ValidationField.OTHER_RELATION)
                    ? ValidationField.OTHER_RELATION.errorMessage()
                    : null,
          ),
          autofocus: false,
          keyboardType: TextInputType.name,
          onChanged: (value) {
            BlocProvider.of<PatientDetailsBloc>(context)
                .patient
                .guardian
                .readableRelationship = value.trim();
          },
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
        );
      },
    );
  }
}

class GuardianMobileNumberInput extends StatelessWidget {
  final ValueChanged<String> onMobileNumberValueChanged;

  GuardianMobileNumberInput(this.onMobileNumberValueChanged);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ValidationBloc, ValidationState>(
      builder: (context, validationState) {
        return TextField(
          controller: TextEditingController(
              text: BlocProvider.of<PatientDetailsBloc>(context)
                      .patient
                      .guardian
                      .mobileNumber ??
                  ""),
          maxLines: 1,
          maxLength: 10,
          decoration: InputDecoration(
            border: InputBorder.none,
            helperText: Strings.tapToEnter,
            labelText: Strings.guardianMobileNumber,
            contentPadding: EdgeInsets.zero,
            icon: Icon(
              Icons.phone,
              size: 20.0,
            ),
            errorText:
                validationState.isFieldInvalid(ValidationField.CONTACT_NUMBER)
                    ? ValidationField.CONTACT_NUMBER.errorMessage()
                    : null,
          ),
          autofocus: false,
          keyboardType: TextInputType.phone,
          inputFormatters: <TextInputFormatter>[
            WhitelistingTextInputFormatter.digitsOnly
          ],
          autocorrect: false,
          buildCounter: (BuildContext context,
                  {int currentLength, int maxLength, bool isFocused}) =>
              null,
          onChanged: (value) {
            onMobileNumberValueChanged.call(value);
          },
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
        );
      },
    );
  }
}

class GuardianEmailInput extends StatelessWidget {
  final ValueChanged<String> onEmailChanged;

  GuardianEmailInput(this.onEmailChanged);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: TextEditingController(
          text: BlocProvider.of<PatientDetailsBloc>(context)
                  .patient
                  .guardian
                  .email ??
              ""),
      maxLines: 1,
      decoration: InputDecoration(
        border: InputBorder.none,
        helperText: Strings.tapToEnter,
        labelText: Strings.guardianEmailId,
        contentPadding: EdgeInsets.zero,
        icon: Icon(
          Icons.alternate_email,
          size: 20.0,
        ),
      ),
      autofocus: false,
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      onChanged: (value) {
        onEmailChanged.call(value.trim());
      },
      onEditingComplete: () => FocusScope.of(context).unfocus(),
    );
  }
}

class GuardianFirstNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ValidationBloc, ValidationState>(
      builder: (context, state) {
        return TextField(
            controller: TextEditingController(
                text: BlocProvider.of<PatientDetailsBloc>(context)
                        .patient
                        .guardian
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
              helperText: Strings.tapToEnter,
              labelText: Strings.guardianFirstName,
              contentPadding: EdgeInsets.zero,
              errorText:
                  state.isFieldInvalid(ValidationField.GUARDIAN_FIRST_NAME)
                      ? ValidationField.GUARDIAN_FIRST_NAME.errorMessage()
                      : null,
            ),
            autofocus: false,
            keyboardType: TextInputType.text,
            onChanged: (value) => BlocProvider.of<PatientDetailsBloc>(context)
                .patient
                .guardian
                .firstName = value.trim(),
            onEditingComplete: () => FocusScope.of(context).nextFocus());
      },
    );
  }
}

class GuardianLastNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ValidationBloc, ValidationState>(
      builder: (context, state) {
        return TextField(
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
              labelText: Strings.guardianLastName,
              contentPadding: EdgeInsets.zero,
              errorText:
                  state.isFieldInvalid(ValidationField.GUARDIAN_LAST_NAME)
                      ? ValidationField.GUARDIAN_LAST_NAME.errorMessage()
                      : null,
            ),
            autofocus: false,
            keyboardType: TextInputType.text,
            controller: TextEditingController(
                text: BlocProvider.of<PatientDetailsBloc>(context)
                        .patient
                        .guardian
                        .lastName ??
                    ""),
            onChanged: (value) => BlocProvider.of<PatientDetailsBloc>(context)
                .patient
                .guardian
                .lastName = value.trim(),
            onEditingComplete: () => FocusScope.of(context).nextFocus());
      },
    );
  }
}
