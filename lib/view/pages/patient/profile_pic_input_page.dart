import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greycells/bloc/patient_details/patient_details_bloc.dart';
import 'package:greycells/bloc/picker/image_picker_bloc.dart';
import 'package:greycells/constants/strings.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePicInputPage extends StatelessWidget {
  const ProfilePicInputPage();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ImagePickerBloc, ImagePickerState>(
      listener: (context, state) {
        if (state is StateImagePicked) {
          BlocProvider.of<PatientDetailsBloc>(context)
              .patient
              .localProfilePicFilePath = state.pickedImageFile.path;
        }

        if(state is StateImageRemoved) {
          BlocProvider.of<PatientDetailsBloc>(context)
              .patient
              .localProfilePicFilePath = "";
        }
      },
      child: BlocBuilder<ImagePickerBloc, ImagePickerState>(
        builder: (context, imagePickerState) {
          if (imagePickerState is StateImagePicked) {
            return CircleAvatarWidget(imagePickerState.pickedImageFile,
                onSelectionRequested: () => _pickImage(context),
                onRemoveRequested: () => _removeImage(context));
          } else
            return _ProfilePicSelector(
                onSelectionRequested: () => _pickImage(context));
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

class CircleAvatarWidget extends StatelessWidget {
  final VoidCallback onSelectionRequested;
  final VoidCallback onRemoveRequested;

  final File imageFile;

  const CircleAvatarWidget(this.imageFile,
      {this.onSelectionRequested, this.onRemoveRequested});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onSelectionRequested,
          child: CircleAvatar(
            radius: 100,
            backgroundImage: FileImage(imageFile),
            onBackgroundImageError: (exception, stackTrace) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(Strings.imageError),
                duration: Duration(milliseconds: 2000),
              ));
            },
          ),
        ),
        SizedBox(
          height: 24.0,
        ),
        FlatButton(
          onPressed: onRemoveRequested,
          child: Text(
            Strings.removeImage.toUpperCase(),
            style: Theme.of(context).textTheme.button.copyWith(
                color: Theme.of(context).accentColor, letterSpacing: 0.7),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            Strings.or.toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .copyWith(letterSpacing: 0.8),
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
        Text(
          Strings.nextToProceed,
          style: Theme.of(context)
              .textTheme
              .subtitle1
              .copyWith(color: Colors.grey[600], letterSpacing: 0.8),
        ),
      ],
    );
  }
}

class _ProfilePicSelector extends StatelessWidget {
  final VoidCallback onSelectionRequested;

  const _ProfilePicSelector({Key key, this.onSelectionRequested});

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
