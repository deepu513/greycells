import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'image_picker_event.dart';

part 'image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  @override
  ImagePickerState get initialState => ImagePickerInitial();

  @override
  Stream<ImagePickerState> mapEventToState(
    ImagePickerEvent event,
  ) async* {
    if (event is PickImage) {
      yield StateImagePickInProgress();

      final picker = ImagePicker();
      final pickedFile = await picker.getImage(
        source: event.source,
        imageQuality: 30,
      );

      yield StateImagePicked(File(pickedFile.path));
    }
  }
}
