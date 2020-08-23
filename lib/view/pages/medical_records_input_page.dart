import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:mental_health/constants/strings.dart';
import 'package:path/path.dart';

class MedicalRecordsInputPage extends StatefulWidget {
  @override
  _MedicalRecordsInputPageState createState() =>
      _MedicalRecordsInputPageState();
}

class _MedicalRecordsInputPageState extends State<MedicalRecordsInputPage> {
  final List<File> list = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          File pickedFile = await FilePicker.getFile(
              type: FileType.custom,
              allowedExtensions: ["pdf", "jpg", "jpeg", "png"]);

          if (pickedFile != null) {
            if (extension(pickedFile.path) == ".pdf" ||
                extension(pickedFile.path) == ".jpg" ||
                extension(pickedFile.path) == ".jpeg" ||
                extension(pickedFile.path) == ".png")
              setState(() {
                list.add(pickedFile);
              });
          }
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: <Widget>[
                Text(
                  Strings.medicalRecords,
                  style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Colors.black, fontWeight: FontWeight.w400),
                ),
                Spacer(),
                IconButton(
                  onPressed: () => showInfoDialog(context),
                  icon: Icon(Icons.info_outline),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
            child: Text("${list.length} files selected",
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(color: Colors.grey[600], fontSize: 14.0)),
          ),
          Expanded(child: list.isEmpty ? ListEmptyWidget() : FileList(list)),
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
                  Text(Strings.medicalRecordsInfo),
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

class FileList extends StatelessWidget {
  final List<File> list;

  FileList(this.list);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(basename(list[index].path)),
            subtitle: Text(filesize(list[index].lengthSync())),
          );
        },
        separatorBuilder: (context, index) => Divider(
              indent: 16.0,
              endIndent: 16.0,
            ),
        itemCount: list.length);
  }
}

class ListEmptyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.insert_drive_file,
            size: 56.0,
          ),
          SizedBox(height: 16.0),
          Text(
            Strings.emptyListMessage,
            style: Theme.of(context).textTheme.subtitle1,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
