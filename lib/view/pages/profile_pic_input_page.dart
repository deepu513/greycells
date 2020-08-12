import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mental_health/constants/strings.dart';

class ProfilePicInputPage extends StatefulWidget {
  @override
  _ProfilePicInputPageState createState() => _ProfilePicInputPageState();
}

class _ProfilePicInputPageState extends State<ProfilePicInputPage> {
  bool selected;
  File file;

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
          backgroundImage: file == null
              ? NetworkImage("https://via.placeholder.com/150")
              : FileImage(
                  file,
                ));
    } else
      return _ProfilePicSelector(
        onSelectionRequested: () async {
          file = await FilePicker.getFile(type: FileType.image);
          if (file != null)
            setState(() {
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
          iconSize: 36.0,
        ),
        SizedBox(
          height: 36.0,
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
