import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mental_health/bloc/picker/image_picker_bloc.dart';
import 'package:mental_health/constants/strings.dart';
import 'package:mental_health/view/widgets/centered_circular_loading.dart';

class ProfilePicInputPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ImagePickerBloc>(
      create: (_) => ImagePickerBloc(),
      child: Builder(
        builder: (context) {
          return BlocBuilder<ImagePickerBloc, ImagePickerState>(
            builder: (context, imagePickerState) {
              if (imagePickerState is ImagePickerInitial) {
                return _ProfilePicSelector(
                  onSelectionRequested: () => _pickImage(context),
                );
              } else if (imagePickerState is StateImagePicked) {
                return CircleAvatarWidget(
                  imagePickerState.pickedImageFile,
                  onSelectionRequested: () => _pickImage(context),
                );
              } else if (imagePickerState is StateImagePickInProgress) {
                return CenteredCircularLoadingIndicator();
              } else
                return Container();
            },
          );
        },
      ),
    );
  }

  void _pickImage(BuildContext context) {
    return BlocProvider.of<ImagePickerBloc>(context)
        .add(PickImage(ImageSource.gallery));
  }
}

class CircleAvatarWidget extends StatelessWidget {
  final VoidCallback onSelectionRequested;

  final File imageFile;

  CircleAvatarWidget(this.imageFile, {this.onSelectionRequested});

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
          iconSize: 40.0,
          splashRadius: 56.0,
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
