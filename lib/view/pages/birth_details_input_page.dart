import 'package:flutter/material.dart';
import 'package:mental_health/constants/strings.dart';

class BirthDetailsInputPage extends StatelessWidget {
  const BirthDetailsInputPage();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                Strings.birthDetails,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Colors.black, fontWeight: FontWeight.w400),
              ),
              Spacer(),
              IconButton(
                onPressed: () => showInfoDialog(context),
                icon: Icon(Icons.info_outline),
              )
            ],
          ),
          Text(Strings.mandatoryFields,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(color: Colors.grey[600], fontSize: 14.0)),
          SizedBox(
            height: 32.0,
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: PlaceOfBirthInput(),
          )),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: DateOfBirthInput(),
          )),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TimeOfBirthWidget(),
          )),
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
                  Text(Strings.birthDetailsInfo),
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
}

class PlaceOfBirthInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 1,
      maxLength: 50,
      textInputAction: TextInputAction.next,
      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
      decoration: InputDecoration(
        border: InputBorder.none,
        icon: Icon(
          Icons.add_location,
          size: 20.0,
        ),
        helperText: Strings.tapToEnter,
        helperStyle: TextStyle(fontSize: 14.0, color: Colors.grey),
        labelText: Strings.placeOfBirth,
        contentPadding: EdgeInsets.zero,
      ),
      autofocus: false,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      buildCounter: (BuildContext context,
          {int currentLength, int maxLength, bool isFocused}) =>
      null,
      onSubmitted: (_) => FocusScope.of(context).nextFocus(),
    );
  }
}

class DateOfBirthInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            Icon(
              Icons.event,
              color: Colors.black54,
              size: 20.0,
            ),
            SizedBox(
              width: 16.0,
            ),
            Text(Strings.dateOfBirth,
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54)),
          ],
        ),
        SizedBox(
          height: 16.0,
        ),
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
                  textInputAction: TextInputAction.next,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                      labelText: "dd",
                      labelStyle:
                          TextStyle(color: Theme.of(context).accentColor),
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none),
                  keyboardType: TextInputType.number,
                  buildCounter: (BuildContext context,
                          {int currentLength, int maxLength, bool isFocused}) =>
                      null,
                    onChanged: (value) {
                      if(value.length == 2) FocusScope.of(context).nextFocus();
                    },
                    onSubmitted: (_) => FocusScope.of(context).nextFocus()
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text("/",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w400)),
                  )),
              Expanded(
                flex: 2,
                child: TextField(
                  maxLength: 2,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                      labelText: "mm",
                      labelStyle:
                          TextStyle(color: Theme.of(context).accentColor),
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none),
                  keyboardType: TextInputType.number,
                  buildCounter: (BuildContext context,
                          {int currentLength, int maxLength, bool isFocused}) =>
                      null,
                    onChanged: (value) {
                      if(value.length == 2) FocusScope.of(context).nextFocus();
                    },
                    onSubmitted: (_) => FocusScope.of(context).nextFocus()
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text("/",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w400)),
                  )),
              Expanded(
                flex: 2,
                child: TextField(
                  maxLength: 4,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                      labelText: "yyyy",
                      labelStyle:
                          TextStyle(color: Theme.of(context).accentColor),
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none),
                  keyboardType: TextInputType.number,
                  buildCounter: (BuildContext context,
                          {int currentLength, int maxLength, bool isFocused}) =>
                      null,
                    onChanged: (value) {
                      if(value.length == 4) FocusScope.of(context).nextFocus();
                    },
                    onSubmitted: (_) => FocusScope.of(context).nextFocus()
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
        Row(
          children: [
            Icon(
              Icons.access_time,
              color: Colors.black54,
              size: 20.0,
            ),
            SizedBox(
              width: 16.0,
            ),
            Text(Strings.timeOfBirth,
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54)),
          ],
        ),
        SizedBox(
          height: 16.0,
        ),
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
                  textInputAction: TextInputAction.next,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                      labelText: "hrs",
                      labelStyle:
                          TextStyle(color: Theme.of(context).accentColor),
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none),
                  keyboardType: TextInputType.number,
                  buildCounter: (BuildContext context,
                          {int currentLength, int maxLength, bool isFocused}) =>
                      null,
                    onChanged: (value) {
                      if(value.length == 2) FocusScope.of(context).nextFocus();
                    },
                    onSubmitted: (_) => FocusScope.of(context).nextFocus()
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(":",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w400)),
                  )),
              Expanded(
                flex: 2,
                child: TextField(
                  maxLength: 2,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                      labelText: "min",
                      labelStyle:
                          TextStyle(color: Theme.of(context).accentColor),
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none),
                  keyboardType: TextInputType.number,
                  buildCounter: (BuildContext context,
                          {int currentLength, int maxLength, bool isFocused}) =>
                      null,
                    onChanged: (value) {
                      if(value.length == 2) FocusScope.of(context).unfocus();
                    },
                    onSubmitted: (_) => FocusScope.of(context).nextFocus()
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
