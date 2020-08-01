import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mental_health/constants/strings.dart';
import 'package:mental_health/view/widgets/no_glow_scroll_behaviour.dart';

class GuardianDetailsInputPage extends StatelessWidget {
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
                  Strings.guardianDetails,
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
            height: 24.0,
          ),
          // Relationship, guardian name, guardian mobile number, guardian address
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: GuardianRelationshipInput(),
          ),
          SizedBox(height: 16.0,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: GuardianMobileNumberInput(),
          )
        ],
      ),
    );
  }
}

class GuardianRelationshipInput extends StatefulWidget {
  @override
  _GuardianRelationshipInputState createState() =>
      _GuardianRelationshipInputState();
}

class _GuardianRelationshipInputState extends State<GuardianRelationshipInput> {
  List<String> relationShipList;
  List<bool> toggleStateList;
  int _selectedIndex;

  @override
  void initState() {
    relationShipList = List<String>()
      ..add("Father")
      ..add("Mother")
      ..add("Brother")
      ..add("Sister")
      ..add("Other");

    toggleStateList = <bool>[true, false, false, false, false];
    _selectedIndex = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Your relationship with guardian", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400)),
        SizedBox(height: 8.0,),
        LayoutBuilder(
          builder: (context, constraints) {
            return ToggleButtons(
              children: relationShipList.map((value) => Text(value)).toList(),
              constraints: BoxConstraints.expand(width: (constraints.maxWidth - 24.0)/ relationShipList.length, height: 48.0),
              isSelected: toggleStateList,
              onPressed: (index) {

              },
            );
          },
        ),
        SizedBox(height: 12.0),
        AnimatedContainer(
          height: 0.0,
          duration: Duration(milliseconds: 600),
          child: TextField(
            maxLines: 1,
            decoration: InputDecoration(
              border: InputBorder.none,
              helperText: "tap to enter",
              labelText: Strings.relationshipWithGuardian,
              contentPadding: EdgeInsets.zero,
              labelStyle: TextStyle(color: Theme.of(context).accentColor),
            ),
            autofocus: false,
            keyboardType: TextInputType.text,
            enabled: true,
            textCapitalization: TextCapitalization.words,
          ),
        )
      ],
    );
  }
}

class GuardianMobileNumberInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Guardian mobile number", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400)),
        TextField(
          maxLines: 1,
          maxLength: 10,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText:
            "tap to enter",
            hintStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
            icon: Text(
              "+91",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
            ),
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
        ),
      ],
    );
  }
}

class GuardianAddressInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
