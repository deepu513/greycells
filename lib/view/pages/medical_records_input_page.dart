import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health/bloc/picker/file_picker_bloc.dart';
import 'package:mental_health/constants/strings.dart';
import 'package:path/path.dart';

class MedicalRecordsInputPage extends StatelessWidget {
  const MedicalRecordsInputPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (BlocProvider.of<FilePickerBloc>(context).pickedFiles.length < 5) {
            String result = await showAlertDialog(context);
            if (result == "Image") {
              BlocProvider.of<FilePickerBloc>(context).add(PickImageFile());
            } else if (result == "PDF") {
              BlocProvider.of<FilePickerBloc>(context).add(PickPdfFile());
            }
          } else {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(ErrorMessages.MAX_FILES_ERROR_MESSAGE),
              duration: Duration(milliseconds: 2000),
            ));
          }
        },
        child: Icon(Icons.add),
      ),
      body: BlocListener<FilePickerBloc, FilePickerState>(
        listener: (current, previous) {
          if (current is FileSizeTooLarge) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(ErrorMessages.FILE_SIZE_ERROR_MESSAGE),
              duration: Duration(milliseconds: 2000),
            ));
          }

          if (current is UnsupportedFilePicked) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(ErrorMessages.UNSUPPORTED_FILE_ERROR_MESSAGE),
              duration: Duration(milliseconds: 2000),
            ));
          }
        },
        child: BlocBuilder<FilePickerBloc, FilePickerState>(
          builder: (context, filePickerState) {
            var pickedFiles =
                BlocProvider.of<FilePickerBloc>(context).pickedFiles;
            return Column(
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
                  child: Text(
                    "${pickedFiles.length} file(s) selected\nMax size 2 MB per file",
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: Colors.grey[600], fontSize: 12.0, height: 1.3),
                  ),
                ),
                Expanded(
                    child: pickedFiles.isEmpty
                        ? ListEmptyWidget()
                        : FileList(pickedFiles)),
              ],
            );
          },
        ),
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
      onPressed: () async {
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
  final List<PickedFile> list;

  FileList(this.list);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            leading: list[index].selectableFileType == SelectableFileType.IMAGE
                ? Image.file(
                    list[index].selectedFile,
                    width: 80.0,
                    fit: BoxFit.cover,
                  )
                : Icon(Icons.insert_drive_file),
            title: Text(
              basename(list[index].selectedFile.path),
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(filesize(list[index].selectedFile.lengthSync())),
            trailing: IconButton(
              icon: Icon(Icons.cancel),
              iconSize: 20.0,
              onPressed: () {
                BlocProvider.of<FilePickerBloc>(context)
                    .add(RemoveFile(list[index]));
              },
            ),
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
