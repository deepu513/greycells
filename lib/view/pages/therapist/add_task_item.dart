import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greycells/bloc/picker/image_picker_bloc.dart';
import 'package:greycells/constants/strings.dart';
import 'package:greycells/extensions.dart';
import 'package:image_picker/image_picker.dart';

class AddTaskItemsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4.0,
        title: Text(
          'Add Task Item',
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.black87),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocProvider<ImagePickerBloc>(
                  create: (_) => ImagePickerBloc(),
                  child: ImageSection(
                    onImageSelected: (imagePath) {},
                  ),
                ),
                Divider(
                  height: 24.0,
                ),
                TaskItemInputSection(
                  onTitleChanged: (title) {},
                  onDescriptionChanged: (description) {},
                  onDateSelected: (date) {},
                ),
                SizedBox(
                  height: 24.0,
                ),
                ActionButtons(
                  onCancelPressed: () {},
                  onTaskAddPressed: () {},
                ),
              ],
            )),
      ),
    );
  }
}

class ImageSection extends StatelessWidget {
  final ValueChanged<String> onImageSelected;

  const ImageSection({Key key, @required this.onImageSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ImagePickerBloc, ImagePickerState>(
      listener: (context, state) {},
      builder: (context, imagePickerState) {
        if (imagePickerState is StateImagePicked)
          onImageSelected.call(imagePickerState.pickedImageFile.path);
        if (imagePickerState is StateImagePickCancelled)
          onImageSelected.call("");
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                BlocProvider.of<ImagePickerBloc>(context)
                    .add(PickImage(ImageSource.gallery));
              },
              borderRadius: BorderRadius.circular(16.0),
              child: Ink(
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(16.0)),
                width: double.maxFinite,
                height: 180.0,
                child: imagePickerState is StateImagePicked
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.file(
                          imagePickerState.pickedImageFile,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Icon(Icons.add_photo_alternate_outlined),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: RichText(
                text: TextSpan(
                    text: "Tap to add/change image",
                    style: Theme.of(context).textTheme.bodyText1,
                    children: [
                      TextSpan(
                        text: " (optional)",
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ]),
              ),
            ),
          ],
        );
      },
    );
  }
}

class TaskItemInputSection extends StatefulWidget {
  final ValueChanged<String> onTitleChanged;
  final ValueChanged<String> onDescriptionChanged;
  final ValueChanged<String> onDateSelected;

  const TaskItemInputSection(
      {Key key,
      @required this.onTitleChanged,
      @required this.onDescriptionChanged,
      @required this.onDateSelected})
      : super(key: key);

  @override
  _TaskItemInputState createState() => _TaskItemInputState();
}

class _TaskItemInputState extends State<TaskItemInputSection> {
  String initialDate;

  @override
  void initState() {
    super.initState();
    initialDate = DateTime.now().formatToddMMyyyy();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          maxLines: 1,
          maxLength: 100,
          buildCounter: (BuildContext context,
                  {int currentLength, int maxLength, bool isFocused}) =>
              null,
          decoration: InputDecoration(
            labelText: "Title*",
            border: InputBorder.none,
            helperText: Strings.tapToEnter,
            icon: Icon(
              Icons.title_rounded,
              size: 20.0,
            ),
          ),
          textInputAction: TextInputAction.next,
          autofocus: false,
          keyboardType: TextInputType.text,
          onChanged: widget.onTitleChanged,
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
        ),
        SizedBox(
          height: 16.0,
        ),
        TextField(
          maxLines: null,
          decoration: InputDecoration(
            labelText: "Description*",
            border: InputBorder.none,
            helperText: Strings.tapToEnter,
            icon: Icon(
              Icons.notes,
              size: 20.0,
            ),
          ),
          autofocus: false,
          keyboardType: TextInputType.multiline,
          onChanged: widget.onDescriptionChanged,
        ),
        SizedBox(
          height: 16.0,
        ),
        InkWell(
          onTap: () async {
            FocusScope.of(context).unfocus();

            final DateTime pickedDateTime = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(Duration(days: 90)),
            );

            if (pickedDateTime != null)
              widget.onDateSelected.call(pickedDateTime.formatToddMMyyyy());

            setState(() {
              if (pickedDateTime != null)
                initialDate = pickedDateTime.formatToddMMyyyy();
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 8.0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.event_rounded,
                  size: 20.0,
                ),
                SizedBox(
                  width: 16.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Expected date of completion",
                      style: Theme.of(context).textTheme.button.copyWith(
                            color: Colors.black87,
                          ),
                    ),
                    Text(
                      initialDate,
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                          color: Colors.black87, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "(tap to change)",
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(color: Colors.black38),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ActionButtons extends StatelessWidget {
  final VoidCallback onCancelPressed;
  final VoidCallback onTaskAddPressed;

  const ActionButtons(
      {Key key,
      @required this.onCancelPressed,
      @required this.onTaskAddPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlineButton(
            child: Text(
              Strings.cancel.toUpperCase(),
              style: Theme.of(context).textTheme.button.copyWith(
                  letterSpacing: 0.7,
                  color: Colors.grey[800],
                  fontWeight: FontWeight.bold),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            onPressed: () {},
          ),
        ),
        SizedBox(
          width: 16.0,
        ),
        Expanded(
          child: RaisedButton(
            child: Text(
              "ADD",
              style: Theme.of(context).textTheme.button.copyWith(
                  letterSpacing: 0.7,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            color: Color(0xFF455a64),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            onPressed: () {},
          ),
        )
      ],
    );
  }
}
