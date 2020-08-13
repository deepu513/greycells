import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mental_health/view/widgets/height_card.dart';
import 'package:mental_health/view/widgets/weight_card.dart';

class HealthDetailsInputPage extends StatefulWidget {
  final int initialHeight = 150;

  @override
  _HealthDetailsInputPageState createState() => _HealthDetailsInputPageState();
}

class _HealthDetailsInputPageState extends State<HealthDetailsInputPage> {
  int selectedHeight;

  @override
  void initState() {
    super.initState();
    selectedHeight = widget.initialHeight;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(""),
              Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.info_outline),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text("Gender",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400)),
          ),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GenderSelector(),
          ),
          SizedBox(
            height: 16.0,
          ),
          Divider(),
          SizedBox(
            height: 16.0,
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
            height: 16.0,
          ),
          Divider(),
          SizedBox(
            height: 16.0,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 16.0),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
                height: 124.0,
                child: HeightCard(
                  initialHeight: 150,
                  onHeightChanged: (val) => setState(() {
                    selectedHeight = val;
                  }),
                )),
          ),
        ],
      ),
    );
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
