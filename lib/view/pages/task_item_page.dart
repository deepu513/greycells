import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greycells/bloc/picker/image_picker_bloc.dart';
import 'package:greycells/bloc/task/task_bloc.dart';
import 'package:greycells/constants/strings.dart';
import 'package:greycells/constants/user_type.dart';
import 'package:greycells/models/task/task_item.dart';
import 'package:greycells/extensions.dart';
import 'package:greycells/route/route_name.dart';
import 'package:greycells/view/widgets/colored_page_section.dart';
import 'package:greycells/view/widgets/network_image_with_error.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class TaskItemPage extends StatelessWidget {
  final TaskItem taskItem;
  final UserType userType;

  const TaskItemPage(
      {Key key, @required this.taskItem, @required this.userType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskBloc, TaskState>(
      listener: (context, state) {
        if (state is TaskUpdated) {
          Navigator.of(context).pop(true);
        }

        if (state is TasksError) {
          showErrorDialog(
              context: context,
              message: ErrorMessages.GENERIC_ERROR_MESSAGE,
              showIcon: true,
              onPressed: () {
                Navigator.of(context).pop();
              });
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 4.0,
            title: Text(
              'Task Item',
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Colors.black87),
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: userType == UserType.patient &&
                              taskItem.status != 1,
                          child: BlocProvider<ImagePickerBloc>(
                            create: (_) => ImagePickerBloc(),
                            child: PickImageSection(
                              onImageSelected: (imagePath) {
                                taskItem.filePath = imagePath;
                              },
                            ),
                          ),
                        ),
                        Visibility(
                          visible: (taskItem.status == 1 ||
                                  userType == UserType.therapist) &&
                              taskItem.file != null &&
                              !taskItem.file.name.isNullOrEmpty(),
                          child: ImageSection(
                            imageUrl: taskItem.file != null
                                ? taskItem.file.name.withBaseUrlForImage()
                                : "",
                          ),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        TaskMetaInfo(
                          taskItem: taskItem,
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Visibility(
                    visible:
                        userType == UserType.patient && taskItem.status != 1,
                    child: OutlineButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Visibility(
                            visible: state is TaskLoading,
                            child: SizedBox(
                                width: 16.0,
                                height: 16.0,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.0,
                                )),
                          ),
                          SizedBox(
                            width: 16.0,
                          ),
                          Text(
                            "Mark as complete".toUpperCase(),
                            style: Theme.of(context).textTheme.button.copyWith(
                                letterSpacing: 0.7,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      onPressed: state is TaskLoading
                          ? null
                          : () {
                              BlocProvider.of<TaskBloc>(context)
                                  .add(UpdateTaskItem(taskItem));
                            },
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class PickImageSection extends StatelessWidget {
  final ValueChanged<String> onImageSelected;

  const PickImageSection({Key key, @required this.onImageSelected})
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
                  borderRadius: BorderRadius.circular(16.0),
                ),
                width: double.maxFinite,
                height: 194.0,
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
              child: Text(
                "Tap to add/change image",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ],
        );
      },
    );
  }
}

class ImageSection extends StatelessWidget {
  final String imageUrl;

  const ImageSection({Key key, @required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(RouteName.IMAGE_VIEWER_PAGE, arguments: imageUrl);
      },
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.grey.shade100),
        width: double.maxFinite,
        height: imageUrl.isNullOrEmpty() ? 0.0 : 194.0,
        child: !imageUrl.isNullOrEmpty()
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: NetworkImageWithError(
                  imageUrl: imageUrl,
                  boxFit: BoxFit.cover,
                ),
              )
            : null,
      ),
    );
  }
}

class TaskMetaInfo extends StatelessWidget {
  final TaskItem taskItem;

  const TaskMetaInfo({Key key, @required this.taskItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.maxFinite,
          padding: EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Icon(
                  Icons.title_rounded,
                  color: Colors.blueGrey,
                ),
              ),
              Flexible(
                child: Text(
                  taskItem.title,
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                      color: Colors.blueGrey, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 16.0,
        ),
        ColoredPageSection(
          sectionColor: Colors.grey.shade100,
          icon: Icon(
            Icons.event,
            color: Colors.black54,
          ),
          title: "Expected by",
          description:
              _yetAnotherDateConversion(taskItem.expectedCompletionDateTIme),
          textColor: Colors.black54,
          descriptionIsItalic: false,
        ),
        SizedBox(
          height: 16.0,
        ),
        ColoredPageSection(
          sectionColor: Colors.green.shade50,
          icon: Icon(
            Icons.notes_rounded,
            color: Colors.green,
          ),
          title: "Description",
          description: taskItem.description,
          textColor: Colors.green.shade700,
          descriptionIsItalic: false,
        ),
      ],
    );
  }

  String _yetAnotherDateConversion(String date) {
    try {
      DateFormat dateFormat = DateFormat("dd-MM-yyyy HH:mm:ss a");
      DateTime dateTime = dateFormat.parse(date);
      return DateFormat("EEE, dd MMM, yyyy").format(dateTime);
    } catch (e) {
      debugPrint(e);
    }
    return "";
  }
}
