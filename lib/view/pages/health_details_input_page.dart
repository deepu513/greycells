import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mental_health/constants/strings.dart';
import 'package:mental_health/view/widgets/no_glow_scroll_behaviour.dart';

class HealthDetailsInputPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: NoGlowScrollBehaviour(),
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
            child: Row(
              children: <Widget>[
                Text(
                  Strings.healthDetails,
                  style: Theme.of(context).textTheme.headline5.copyWith(
                      color: Colors.black, fontWeight: FontWeight.w400),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.info_outline),
                )
              ],
            ),
          ),
          SizedBox(
            height: 36.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: GenderSelector(),
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
