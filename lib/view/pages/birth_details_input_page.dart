import 'package:flutter/material.dart';
import 'package:mental_health/constants/strings.dart';

class BirthDetailsInputPage extends StatelessWidget {
  // TODO: Change label color when not in focus and adjust font sizes
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            Strings.birthDetails,
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(color: Colors.black, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 36.0,
          ),
          Expanded(child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: PlaceOfBirthInput(),
          )),
          Expanded(child: DateOfBirthInput()),
          Expanded(child: TimeOfBirthWidget()),
        ],
      ),
    );
  }
}

class PlaceOfBirthInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 1,
      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w400),
      decoration: InputDecoration(
        border: InputBorder.none,
        helperText: "tap to enter",
        helperStyle: TextStyle(fontSize: 14.0),
        labelText: Strings.placeOfBirth,
        contentPadding: EdgeInsets.zero,
        labelStyle: TextStyle(color: Theme.of(context).accentColor),
      ),
      autofocus: false,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
    );
  }
}

class DateOfBirthInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Date of birth", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400)),
        SizedBox(height: 16.0,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: TextField(
                  maxLength: 2,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                      labelText: "dd",
                      labelStyle: TextStyle(color: Theme.of(context).accentColor),
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none),
                  keyboardType: TextInputType.number,
                  buildCounter: (BuildContext context,
                          {int currentLength, int maxLength, bool isFocused}) =>
                      null,
                ),
              ),
              Expanded(
                flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text("/", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400)),
                  )),
              Expanded(
                flex: 2,
                child: TextField(
                  maxLength: 2,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                      labelText: "mm",
                      labelStyle: TextStyle(color: Theme.of(context).accentColor),
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none),
                  keyboardType: TextInputType.number,
                  buildCounter: (BuildContext context,
                          {int currentLength, int maxLength, bool isFocused}) =>
                      null,
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text("/", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400)),
                  )),
              Expanded(
                flex: 2,
                child: TextField(
                  maxLength: 4,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                      labelText: "yyyy",
                      labelStyle: TextStyle(color: Theme.of(context).accentColor),
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none),
                  keyboardType: TextInputType.number,
                  buildCounter: (BuildContext context,
                          {int currentLength, int maxLength, bool isFocused}) =>
                      null,
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class TimeOfBirthWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Time of birth", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400)),
        SizedBox(height: 16.0,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: TextField(
                  maxLength: 2,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                      labelText: "hrs",
                      labelStyle: TextStyle(color: Theme.of(context).accentColor),
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none),
                  keyboardType: TextInputType.number,
                  buildCounter: (BuildContext context,
                      {int currentLength, int maxLength, bool isFocused}) =>
                  null,
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(":", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400)),
                  )),
              Expanded(
                flex: 2,
                child: TextField(
                  maxLength: 2,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                      labelText: "min",
                      labelStyle: TextStyle(color: Theme.of(context).accentColor),
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none),
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
          ),
        ),
      ],
    );
  }
}
