import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greycells/bloc/validation/bloc.dart';
import 'package:greycells/bloc/validation/validation_field.dart';
import 'package:greycells/constants/strings.dart';
import 'package:greycells/extensions.dart';
import 'package:greycells/models/task/task_item.dart';

class EditTaskItemsPage extends StatelessWidget {
  final TaskItem taskItem;

  const EditTaskItemsPage({Key key, this.taskItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ValidationBloc>(
      create: (_) => ValidationBloc(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 4.0,
          title: Text(
            'Edit Task Item',
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: Colors.black87),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: BlocConsumer<ValidationBloc, ValidationState>(
              listener: (context, state) {
                if (state is TaskItemValid) {
                  Navigator.of(context).pop(state.taskItem);
                }
              },
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TaskItemInputSection(
                      existingItem: taskItem,
                      titleError:
                          state.isFieldInvalid(ValidationField.TASK_ITEM_TITLE),
                      descriptionError:
                          state.isFieldInvalid(ValidationField.TASK_ITEM_DESC),
                      onTitleChanged: (title) {
                        taskItem.title = title;
                      },
                      onDescriptionChanged: (description) {
                        taskItem.description = description;
                      },
                      onDateSelected: (date, readableDate) {
                        taskItem.expectedCompletionDateTIme = date;
                        taskItem.readableDate = readableDate;
                      },
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    ActionButtons(
                      onCancelPressed: () {
                        Navigator.of(context).pop();
                      },
                      onTaskAddPressed: () {
                        BlocProvider.of<ValidationBloc>(context)
                            .add(ValidateTaskItemFields(taskItem));
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class TaskItemInputSection extends StatefulWidget {
  final TaskItem existingItem;
  final bool titleError;
  final bool descriptionError;
  final ValueChanged<String> onTitleChanged;
  final ValueChanged<String> onDescriptionChanged;
  final DateSelectedCallback onDateSelected;

  const TaskItemInputSection(
      {Key key,
      @required this.existingItem,
      @required this.onTitleChanged,
      @required this.onDescriptionChanged,
      @required this.onDateSelected,
      @required this.titleError,
      @required this.descriptionError})
      : super(key: key);

  @override
  _TaskItemInputState createState() => _TaskItemInputState();
}

typedef DateSelectedCallback = void Function(String, String);

class _TaskItemInputState extends State<TaskItemInputSection> {
  String initialDate;
  String readableDate;

  @override
  void initState() {
    super.initState();
    initialDate = widget.existingItem.expectedCompletionDateTIme;
    if (widget.existingItem.expectedCompletionDateTIme.contains("AM") ||
        widget.existingItem.expectedCompletionDateTIme.contains("PM")) {
      readableDate = widget.existingItem.expectedCompletionDateTIme
          .expectedCompletionAsDate()
          .readableDate();
    } else {
      readableDate = widget.existingItem.expectedCompletionDateTIme
          .fromddMMyyyy()
          .readableDate();
    }

    widget.onDateSelected.call(initialDate, readableDate);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller:
              TextEditingController(text: widget.existingItem.title ?? ""),
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
            errorText: widget.titleError
                ? ErrorMessages.EMPTY_FIELD_ERROR_MESSAGE
                : null,
          ),
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.sentences,
          autofocus: false,
          keyboardType: TextInputType.text,
          onChanged: widget.onTitleChanged,
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
        ),
        SizedBox(
          height: 16.0,
        ),
        TextField(
          controller: TextEditingController(
              text: widget.existingItem.description ?? ""),
          maxLines: null,
          decoration: InputDecoration(
            labelText: "Description*",
            border: InputBorder.none,
            helperText: Strings.tapToEnter,
            icon: Icon(
              Icons.notes,
              size: 20.0,
            ),
            errorText: widget.descriptionError
                ? ErrorMessages.EMPTY_FIELD_ERROR_MESSAGE
                : null,
          ),
          autofocus: false,
          keyboardType: TextInputType.multiline,
          textCapitalization: TextCapitalization.sentences,
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
              widget.onDateSelected.call(pickedDateTime.formatToddMMyyyy(),
                  pickedDateTime.readableDate());

            setState(() {
              if (pickedDateTime != null) {
                initialDate = pickedDateTime.formatToddMMyyyy();
                readableDate = pickedDateTime.readableDate();
              }
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
                  color: Colors.black45,
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
                            color: Colors.black54,
                          ),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Text(readableDate,
                        style: Theme.of(context).textTheme.subtitle1),
                    SizedBox(
                      height: 8.0,
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
            onPressed: onCancelPressed,
          ),
        ),
        SizedBox(
          width: 16.0,
        ),
        Expanded(
          child: RaisedButton(
              child: Text(
                "DONE",
                style: Theme.of(context).textTheme.button.copyWith(
                    letterSpacing: 0.7,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              color: Color(0xFF455a64),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              onPressed: onTaskAddPressed),
        )
      ],
    );
  }
}
