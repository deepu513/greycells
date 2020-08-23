import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mental_health/constants/strings.dart';
import 'package:mental_health/view/widgets/number_slider.dart';

class HealthDetailsInputPage extends StatefulWidget {
  const HealthDetailsInputPage();

  @override
  _HealthDetailsInputPageState createState() => _HealthDetailsInputPageState();
}

class _HealthDetailsInputPageState extends State<HealthDetailsInputPage> {
  int selectedHeight;
  int selectedWeight;

  @override
  void initState() {
    super.initState();
    selectedHeight = 150;
    selectedWeight = 70;
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
          child: GenderSelector(),
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
                Text("Weight",
                    style: TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.w400)),
                Spacer(),
                FittedBox(
                  child: RichText(
                    text: TextSpan(
                        text:
                            "${(selectedWeight * 2.205).toStringAsFixed(2)}",
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
                                  fontWeight: FontWeight.w400)),
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
          onChanged: (val) => setState(() {
            selectedWeight = val;
          }),
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
                    style: TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.w400)),
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
          onChanged: (val) => setState(() {
            selectedHeight = val;
          }),
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
  @override
  _GenderSelectorState createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelector> {
  int segmentedControlGroupValue = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl(
        groupValue: segmentedControlGroupValue,
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
          setState(() {
            segmentedControlGroupValue = i;
          });
        });
  }
}
