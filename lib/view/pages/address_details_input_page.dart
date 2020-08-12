import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mental_health/constants/strings.dart';
import 'package:mental_health/view/widgets/no_glow_scroll_behaviour.dart';

class AddressDetailInputPage extends StatelessWidget {
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
            height: 16.0,
          ),
          AddressInputControls(),
          Divider(),
          GuardianAddressInput()
        ],
      ),
    );
  }
}

class AddressInputControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            maxLines: 1,
            decoration: InputDecoration(
              border: InputBorder.none,
              icon: Icon(Icons.home),
              helperText: Strings.tapToEnter,
              labelText: Strings.houseNumber,
              contentPadding: EdgeInsets.zero,
            ),
            autofocus: false,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
          ),
          SizedBox(
            height: 16.0,
          ),
          TextField(
            maxLines: 1,
            decoration: InputDecoration(
              icon: Icon(Icons.nature),
              border: InputBorder.none,
              helperText: Strings.tapToEnter,
              labelText: Strings.roadName,
              contentPadding: EdgeInsets.zero,
            ),
            autofocus: false,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
          ),
          SizedBox(
            height: 16.0,
          ),
          TextField(
            maxLines: 1,
            decoration: InputDecoration(
              icon: Icon(Icons.location_city),
              border: InputBorder.none,
              helperText: Strings.tapToEnter,
              labelText: Strings.city,
              contentPadding: EdgeInsets.zero,
            ),
            autofocus: false,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
          ),
          SizedBox(
            height: 16.0,
          ),
          TextField(
            maxLines: 1,
            decoration: InputDecoration(
              icon: Icon(Icons.my_location),
              border: InputBorder.none,
              helperText: Strings.tapToEnter,
              labelText: Strings.state,
              contentPadding: EdgeInsets.zero,
            ),
            autofocus: false,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
          ),
          SizedBox(
            height: 16.0,
          ),
          TextField(
            maxLines: 1,
            decoration: InputDecoration(
              icon: Icon(Icons.map),
              border: InputBorder.none,
              helperText: Strings.tapToEnter,
              labelText: Strings.country,
              contentPadding: EdgeInsets.zero,
            ),
            autofocus: false,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
          ),
          SizedBox(
            height: 16.0,
          ),
          TextField(
            maxLines: 1,
            maxLength: 10,
            decoration: InputDecoration(
              icon: Icon(Icons.pin_drop),
              border: InputBorder.none,
              helperText: Strings.tapToEnter,
              labelText: Strings.pincode,
              contentPadding: EdgeInsets.zero,
            ),
            autofocus: false,
            keyboardType: TextInputType.number,
            buildCounter: (BuildContext context,
                    {int currentLength, int maxLength, bool isFocused}) =>
                null,
            inputFormatters: <TextInputFormatter>[
              WhitelistingTextInputFormatter.digitsOnly
            ],
          ),
          SizedBox(
            height: 16.0,
          ),
        ],
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
          title: Text(Strings.sameAsAbove, style: Theme.of(context).textTheme.subtitle1,),
          subtitle: Text(Strings.liveWithGuardian),
        ),
        SizedBox(
          height: 8.0,
        ),
        AnimatedOpacity(
            opacity: 1.0,
            duration: Duration(milliseconds: 600),
            child: AddressInputControls())
      ],
    );
  }
}
