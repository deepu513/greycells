import 'package:flutter/material.dart';
import 'package:mental_health/constants/strings.dart';

class ProfilePicInputPage extends StatefulWidget {
  @override
  _ProfilePicInputPageState createState() => _ProfilePicInputPageState();
}

class _ProfilePicInputPageState extends State<ProfilePicInputPage> {
  bool selected;

  @override
  void initState() {
    super.initState();
    selected = false;
  }

  @override
  Widget build(BuildContext context) {
    if (selected) {
      return CircleAvatar(
        radius: 50,
        backgroundImage: NetworkImage(
            "https://via.placeholder.com/150"),
      );
    } else
      return _ProfilePicSelector(
        onSelectionRequested: () {
          setState(() {
            // TODO: This should be done from bloc
            selected = true;
          });
        },
      );
  }
}

class _ProfilePicSelector extends StatelessWidget {
  final VoidCallback onSelectionRequested;

  _ProfilePicSelector({Key key, this.onSelectionRequested});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          onPressed: onSelectionRequested,
          icon: Icon(Icons.add_a_photo),
          iconSize: 32.0,
        ),
        SizedBox(
          height: 16.0,
        ),
        Text(
          Strings.profilePicPickerMessage,
          style: Theme.of(context).textTheme.subtitle1,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
