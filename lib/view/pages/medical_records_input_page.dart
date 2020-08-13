import 'package:flutter/material.dart';
import 'package:mental_health/constants/strings.dart';

class MedicalRecordsInputPage extends StatelessWidget {
  final List<String> list = List<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String result = await showAlertDialog(context);
          print(result);
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
          Expanded(child: list.isEmpty ? ListEmptyWidget() : FileList(list)),
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context) async {
    // set up the list options
    Widget optionOne = SimpleDialogOption(
      child: Row(
        children: [
          Icon(Icons.image),
          SizedBox(
            width: 16.0,
          ),
          Text('Image'),
        ],
      ),
      onPressed: () {
        Navigator.of(context).pop("Image");
      },
    );
    Widget optionTwo = SimpleDialogOption(
      child: Row(
        children: [
          Icon(Icons.picture_as_pdf),
          SizedBox(
            width: 16.0,
          ),
          Text('PDF'),
        ],
      ),
      onPressed: () {
        Navigator.of(context).pop("PDF");
      },
    );

    // set up the SimpleDialog
    SimpleDialog dialog = SimpleDialog(
      title: const Text('Choose file as'),
      children: <Widget>[
        optionOne,
        optionTwo,
      ],
    );

    // show the dialog
    return await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }
}

class FileList extends StatelessWidget {
  final List<String> list;

  FileList(this.list);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return Container();
        },
        separatorBuilder: (context, index) => Divider(),
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
          Icon(Icons.insert_drive_file, size: 56.0,),
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
