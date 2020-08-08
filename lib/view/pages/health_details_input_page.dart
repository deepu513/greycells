import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mental_health/constants/strings.dart';
import 'package:mental_health/view/widgets/height_card.dart';
import 'package:mental_health/view/widgets/weight_card.dart';

class HealthDetailsInputPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                Strings.healthDetails,
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: Colors.black, fontWeight: FontWeight.w400),
              ),
              Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.info_outline),
              )
            ],
          ),
          SizedBox(
            height: 36.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text("Gender",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400)),
          ),
          SizedBox(
            height: 16.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GenderSelector(),
          ),
          SizedBox(
            height: 36.0,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text("Weight",
                  style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400))),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(height: 124.0, child: WeightCard()),
          ),
          SizedBox(
            height: 36.0,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text("Height",
                  style:
                  TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400))),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(height: 124.0, child: HeightCard()),
          ),
        ],
      ),
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
