import 'package:flutter/material.dart';
import 'package:mental_health/constants/strings.dart';

class BirthDetailsInputPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListView(
        children: <Widget>[
          Text(
            Strings.birthDetails,
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(color: Colors.black, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}


class DateOfBirthInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: TextField(
            maxLength: 2,
            decoration:
            InputDecoration(labelText: "Date", border: InputBorder.none),
            keyboardType: TextInputType.number,
            buildCounter: (BuildContext context,
                {int currentLength, int maxLength, bool isFocused}) =>
            null,
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          flex: 1,
          child: TextField(
            maxLength: 2,
            decoration:
            InputDecoration(labelText: "Month", border: InputBorder.none),
            keyboardType: TextInputType.number,
            buildCounter: (BuildContext context,
                {int currentLength, int maxLength, bool isFocused}) =>
            null,
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          flex: 1,
          child: TextField(
            maxLength: 4,
            decoration:
            InputDecoration(labelText: "Year", border: InputBorder.none),
            keyboardType: TextInputType.number,
            buildCounter: (BuildContext context,
                {int currentLength, int maxLength, bool isFocused}) =>
            null,
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(),
        )
      ],
    );
  }
}

class TimeOfBirthWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: TextField(
            maxLength: 2,
            decoration:
            InputDecoration(labelText: "Hours", border: InputBorder.none),
            keyboardType: TextInputType.number,
            buildCounter: (BuildContext context,
                {int currentLength, int maxLength, bool isFocused}) =>
            null,
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          flex: 1,
          child: TextField(
            maxLength: 4,
            decoration:
            InputDecoration(labelText: "Minutes", border: InputBorder.none),
            keyboardType: TextInputType.number,
            buildCounter: (BuildContext context,
                {int currentLength, int maxLength, bool isFocused}) =>
            null,
          ),
        ),
        SizedBox(width: 8.0),
        ToggleButtons(
          children: <Widget>[Text("AM"), Text("PM")],
          borderRadius: BorderRadius.circular(8.0),
          isSelected: [true, false],
          onPressed: (index) {},
        ),
        Expanded(
          flex: 2,
          child: Container(),
        )
      ],
    );
  }
}