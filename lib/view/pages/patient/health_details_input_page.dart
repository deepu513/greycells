import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greycells/bloc/patient_details/patient_details_bloc.dart';
import 'package:greycells/bloc/validation/validation_bloc.dart';
import 'package:greycells/constants/gender.dart';
import 'package:greycells/constants/strings.dart';
import 'package:greycells/interface/validatable.dart';
import 'package:greycells/view/widgets/number_slider.dart';

class HealthDetailsInputPage extends StatefulWidget implements Validatable {
  const HealthDetailsInputPage();

  @override
  _HealthDetailsInputPageState createState() => _HealthDetailsInputPageState();

  @override
  FutureOr<bool> validate(BuildContext context, ValidationBloc validationBloc) {
    BlocProvider.of<PatientDetailsBloc>(context).add(HealthDetailsSubmitted());
    return true;
  }
}

class _HealthDetailsInputPageState extends State<HealthDetailsInputPage> {
  int selectedHeight;
  int selectedWeight;

  @override
  void initState() {
    super.initState();
    selectedHeight = BlocProvider.of<PatientDetailsBloc>(context)
        .patient
        .healthRecord
        .heightInCm;

    selectedWeight = BlocProvider.of<PatientDetailsBloc>(context)
        .patient
        .healthRecord
        .weightInKg;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: <Widget>[
              Text(""),
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
          child: Text("Gender",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400)),
        ),
        SizedBox(
          height: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: BlocBuilder<PatientDetailsBloc, PatientDetailsState>(
            buildWhen: (context, patientDetailsState) {
              return patientDetailsState is GenderUpdated;
            },
            builder: (context, patientDetailsState) {
              var gender =
                  BlocProvider.of<PatientDetailsBloc>(context).patient.gender;
              if (patientDetailsState is GenderUpdated) {
                gender = patientDetailsState.updatedGender;
              }
              return GenderSelector(gender, (selectedGender) {
                BlocProvider.of<PatientDetailsBloc>(context)
                    .add(UpdateGender(selectedGender));
              });
            },
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Divider(
          indent: 16.0,
          endIndent: 16.0,
        ),
        SizedBox(
          height: 20.0,
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Text(
                  "Weight",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
                ),
                Spacer(),
                FittedBox(
                  child: RichText(
                    text: TextSpan(
                        text: "${(selectedWeight * 2.205).toStringAsFixed(2)}",
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54),
                        children: [
                          TextSpan(
                            text: " pounds ",
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400),
                          ),
                        ]),
                  ),
                  fit: BoxFit.contain,
                )
              ],
            )),
        SizedBox(
          height: 16.0,
        ),
        NumberSlider(
          minValue: 30,
          maxValue: 200,
          value: selectedWeight,
          indicatorText: "kgs",
          width: MediaQuery.of(context).size.width,
          onChanged: (val) => setState(
            () {
              selectedWeight = val;
              BlocProvider.of<PatientDetailsBloc>(context)
                  .patient
                  .healthRecord
                  .weightInKg = val;
            },
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Divider(
          indent: 16.0,
          endIndent: 16.0,
        ),
        SizedBox(
          height: 20.0,
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("Height",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400)),
                Spacer(),
                cmToFeetInches(selectedHeight)
              ],
            )),
        SizedBox(
          height: 16.0,
        ),
        NumberSlider(
          minValue: 30,
          maxValue: 200,
          value: selectedHeight,
          indicatorText: "cms",
          width: MediaQuery.of(context).size.width,
          onChanged: (val) => setState(
            () {
              selectedHeight = val;
              BlocProvider.of<PatientDetailsBloc>(context)
                  .patient
                  .healthRecord
                  .weightInKg = val;
            },
          ),
        ),
      ],
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
                  Text(Strings.healthRecordsInfo),
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

  Widget cmToFeetInches(int cms) {
    double foot = cms / 30.48;
    int inches = (((foot - foot.toInt()) * 12).toInt());

    return FittedBox(
      child: RichText(
        text: TextSpan(
            text: "${foot.toInt()}",
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                color: Colors.black54),
            children: [
              TextSpan(
                  text: " feet ",
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400)),
              TextSpan(
                  text: "$inches",
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54)),
              TextSpan(
                  text: " inches ",
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400))
            ]),
      ),
      fit: BoxFit.contain,
    );
  }
}

class GenderSelector extends StatefulWidget {
  final Gender initialGender;
  final ValueChanged<Gender> genderSelectedCallback;

  GenderSelector(this.initialGender, this.genderSelectedCallback);

  @override
  _GenderSelectorState createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelector> {
  int _selectedIndex;
  List<Gender> _genders;

  @override
  void initState() {
    super.initState();
    _genders = Gender.values();
    _selectedIndex = _genders.indexOf(widget.initialGender);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl(
        groupValue: _selectedIndex,
        padding: EdgeInsets.all(8.0),
        children: {
          0: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset(
                  "images/gender-male.svg",
                  width: 24.0,
                  height: 24.0,
                ),
                Text(
                  "Male",
                  style: TextStyle(fontSize: 20.0),
                )
              ],
            ),
          ),
          1: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset(
                  "images/gender-female.svg",
                  width: 24.0,
                  height: 24.0,
                ),
                Text(
                  "Female",
                  style: TextStyle(fontSize: 20.0),
                )
              ],
            ),
          ),
        },
        onValueChanged: (i) {
          _selectedIndex = i;
          widget.genderSelectedCallback.call(_genders[_selectedIndex]);
        });
  }
}
