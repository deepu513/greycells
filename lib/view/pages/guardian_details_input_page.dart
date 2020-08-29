import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health/bloc/guardian_details/guardian_details_bloc.dart';
import 'package:mental_health/bloc/validation/bloc.dart';
import 'package:mental_health/bloc/validation/validation_bloc.dart';
import 'package:mental_health/bloc/validation/validation_field.dart';
import 'package:mental_health/constants/relationship.dart';
import 'package:mental_health/constants/strings.dart';
import 'package:mental_health/extensions.dart';
import 'package:mental_health/models/validatable.dart';
import 'package:mental_health/view/widgets/no_glow_scroll_behaviour.dart';

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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(Strings.mandatoryFields,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(color: Colors.grey[600], fontSize: 14.0)),
          ),
          SizedBox(
            height: 36.0,
          ),
          // Relationship, guardian name, guardian mobile number, guardian address
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: BlocBuilder<GuardianDetailsBloc, GuardianDetailsState>(
              builder: (context, guardianDetailsState) {
                return GuardianRelationshipInput(
                    BlocProvider.of<GuardianDetailsBloc>(context)
                        .guardianDetails
                        .relationShip, (relationShip) {
                  BlocProvider.of<GuardianDetailsBloc>(context)
                      .add(UpdateRelationship(relationShip));
                }, (actualValue) {
                  BlocProvider.of<GuardianDetailsBloc>(context).add(
                      UpdateRelationship(Relationship.other,
                          actualValue: actualValue));
                });
              },
            ),
          ),
          SizedBox(
            height: 24.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: GuardianMobileNumberInput((mobileNumber) {
              BlocProvider.of<GuardianDetailsBloc>(context)
                  .add(UpdateMobileNumber(mobileNumber));
            }),
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
        BlocProvider.of<GuardianDetailsBloc>(context).guardianDetails));

    return completer.future;
  }
}

class GuardianRelationshipInput extends StatefulWidget {
  final Relationship initialRelationship;
  final ValueChanged<Relationship> onRelationshipSelected;
  final ValueChanged<String> onOtherValueChanged;

  GuardianRelationshipInput(this.initialRelationship,
      this.onRelationshipSelected, this.onOtherValueChanged);

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
        SizedBox(height: 16.0),
        Visibility(
            visible: BlocProvider.of<GuardianDetailsBloc>(context)
                    .guardianDetails
                    .relationShip ==
                Relationship.other,
            child: BlocBuilder<ValidationBloc, ValidationState>(
              builder: (context, validationState) {
                return TextField(
                  controller: TextEditingController(
                      text: BlocProvider.of<GuardianDetailsBloc>(context)
                              .guardianDetails
                              .readableRelationship ??
                          ""),
                  maxLines: 1,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    helperText: Strings.tapToEnter,
                    labelText: Strings.relationshipWithGuardian,
                    contentPadding: EdgeInsets.zero,
                    labelStyle: TextStyle(color: Theme.of(context).accentColor),
                    errorText: validationState
                            .isFieldInvalid(ValidationField.OTHER_RELATION)
                        ? ValidationField.OTHER_RELATION.errorMessage()
                        : null,
                  ),
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  enabled: true,
                  textCapitalization: TextCapitalization.words,
                  onChanged: (value) {
                    widget.onOtherValueChanged.call(value);
                  },
                  onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                );
              },
            )),
      ],
    );
  }
}

// TODO: Optimize it and DRY when integrating bloc
class GuardianMobileNumberInput extends StatelessWidget {
  final ValueChanged<String> onMobileNumberValueChanged;

  GuardianMobileNumberInput(this.onMobileNumberValueChanged);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Guardian mobile number",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400)),
        BlocBuilder<ValidationBloc, ValidationState>(
          builder: (context, validationState) {
            return TextField(
              controller: TextEditingController(
                  text: BlocProvider.of<GuardianDetailsBloc>(context)
                          .guardianDetails
                          .mobileNumber ??
                      ""),
              maxLines: 1,
              maxLength: 10,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: Strings.tapToEnter,
                hintStyle:
                    TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
                icon: Icon(
                  Icons.phone,
                  size: 20.0,
                ),
                errorText: validationState
                        .isFieldInvalid(ValidationField.CONTACT_NUMBER)
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
              onSubmitted: (_) => FocusScope.of(context).nextFocus(),
            );
          },
        ),
      ],
    );
  }
}
