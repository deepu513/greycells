import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greycells/bloc/patient_details/patient_details_edit_bloc.dart';
import 'package:greycells/bloc/picker/image_picker_bloc.dart';
import 'package:greycells/bloc/validation/validation_bloc.dart';
import 'package:greycells/bloc/validation/validation_event.dart';
import 'package:greycells/bloc/validation/validation_field.dart';
import 'package:greycells/bloc/validation/validation_state.dart';
import 'package:greycells/constants/strings.dart';
import 'package:greycells/interface/validatable.dart';
import 'package:greycells/models/home/patient_home.dart';
import 'package:greycells/view/widgets/circle_avatar_or_initials.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:greycells/extensions.dart';

class PersonalDetailsEditPage extends StatelessWidget implements Validatable {
  const PersonalDetailsEditPage();

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: <Widget>[
                Text(
                  Strings.addressDetails,
                  style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Colors.black87, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            SizedBox(
              height: 24.0,
            ),
            _ProfilePicWidget(),
            SizedBox(
              height: 24.0,
            ),
            TextField(
              controller: TextEditingController(
                  text: Provider.of<PatientHome>(context, listen: false)
                          .patient
                          .user
                          .firstName ??
                      ""),
              maxLines: 1,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(
                  Icons.person,
                  size: 20.0,
                ),
                enabled: false,
                helperText: Strings.tapToEnter,
                labelText: Strings.firstName,
                contentPadding: EdgeInsets.zero,
              ),
              autofocus: false,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.words,
              enabled: false,
            ),
            TextField(
              maxLines: 1,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(
                  Icons.brightness_1,
                  size: 20.0,
                  color: Colors.transparent,
                ),
                enabled: false,
                helperText: Strings.tapToEnter,
                labelText: Strings.lastName,
                contentPadding: EdgeInsets.zero,
              ),
              autofocus: false,
              enabled: false,
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.text,
              controller: TextEditingController(
                  text: Provider.of<PatientHome>(context, listen: false)
                          .patient
                          .user
                          .lastName ??
                      ""),
            ),
            BlocBuilder<ValidationBloc, ValidationState>(
              builder: (context, validationState) {
                return TextField(
                    maxLines: 1,
                    maxLength: 10,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(
                        Icons.phone,
                        size: 20.0,
                      ),
                      helperText: Strings.tapToEnter,
                      labelText: Strings.mobileNumber,
                      contentPadding: EdgeInsets.zero,
                      errorText: validationState
                              .isFieldInvalid(ValidationField.CONTACT_NUMBER)
                          ? ValidationField.CONTACT_NUMBER.errorMessage()
                          : null,
                    ),
                    autofocus: false,
                    keyboardType: TextInputType.phone,
                    controller: TextEditingController(
                        text: BlocProvider.of<PatientDetailsEditBloc>(context)
                                .patient
                                .user
                                .mobileNumber ??
                            ""),
                    onChanged: (value) =>
                        BlocProvider.of<PatientDetailsEditBloc>(context)
                            .patient
                            .user
                            .mobileNumber = value.trim(),
                    onEditingComplete: () =>
                        FocusScope.of(context).nextFocus());
              },
            ),
          ],
        ),
      ),
    ]);
  }

  @override
  FutureOr<bool> validate(BuildContext context, ValidationBloc validationBloc) {
    final completer = Completer<bool>();

    StreamSubscription subscription;

    subscription = validationBloc.listen((validationState) {
      if (validationState is PersonalDetailsValid) {
        BlocProvider.of<PatientDetailsEditBloc>(context)
            .add(PersonalDetailsValidated());
        completer.complete(true);
      } else if (validationState is ValidationInvalidField) {
        completer.complete(false);
      } else {
        completer.completeError(Exception());
      }
      subscription.cancel();
    });

    validationBloc.add(ValidatePersonalDetailsField(
        BlocProvider.of<PatientDetailsEditBloc>(context).patient));

    return completer.future;
  }
}

class _ProfilePicWidget extends StatefulWidget {
  @override
  __ProfilePicWidgetState createState() => __ProfilePicWidgetState();
}

class __ProfilePicWidgetState extends State<_ProfilePicWidget> {
  bool hasImage = false;
  String fileName;
  String patientFullName;

  @override
  void initState() {
    super.initState();
    if (Provider.of<PatientHome>(context, listen: false).patient.file != null) {
      hasImage = true;
      fileName =
          Provider.of<PatientHome>(context, listen: false).patient.file.name;
      patientFullName =
          Provider.of<PatientHome>(context, listen: false).patient.fullName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ImagePickerBloc, ImagePickerState>(
      listener: (context, state) {
        if (state is StateImagePicked) {
          BlocProvider.of<PatientDetailsEditBloc>(context)
              .patient
              .localProfilePicFilePath = state.pickedImageFile.path;
        }

        if (state is StateImageRemoved) {
          BlocProvider.of<PatientDetailsEditBloc>(context)
              .patient
              .localProfilePicFilePath = "";
        }
      },
      child: BlocBuilder<ImagePickerBloc, ImagePickerState>(
        builder: (context, imagePickerState) {
          if (imagePickerState is StateImagePicked) {
            return InkWell(
              onTap: () => _pickImage(context),
              child: CircleAvatar(
                radius: 96.0,
                backgroundImage: FileImage(imagePickerState.pickedImageFile),
                onBackgroundImageError: (exception, stackTrace) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(Strings.imageError),
                    duration: Duration(milliseconds: 2000),
                  ));
                },
              ),
            );
          }
          if (hasImage) {
            return InkWell(
              onTap: () => _pickImage(context),
              child: CircleAvatarOrInitials(
                radius: 96.0,
                imageUrl:
                    fileName != null ? fileName.withBaseUrlForImage() : "",
                stringForInitials: patientFullName,
              ),
            );
          } else
            return _ProfilePicSelector(
              onSelectionRequested: () => _pickImage(context),
            );
        },
      ),
    );
  }

  void _pickImage(BuildContext context) {
    return BlocProvider.of<ImagePickerBloc>(context)
        .add(PickImage(ImageSource.gallery));
  }

  void _removeImage(BuildContext context) {
    return BlocProvider.of<ImagePickerBloc>(context).add(RemoveSelectedImage());
  }
}

class _ProfilePicSelector extends StatelessWidget {
  final VoidCallback onSelectionRequested;

  const _ProfilePicSelector({this.onSelectionRequested});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          onPressed: onSelectionRequested,
          icon: Icon(Icons.add_a_photo),
          iconSize: 40.0,
          splashRadius: 56.0,
        ),
        SizedBox(
          height: 24.0,
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
