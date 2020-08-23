part of 'file_picker_bloc.dart';

abstract class FilePickerEvent {}

class PickFiles extends FilePickerEvent {
  List<String> fileExtensions;

  PickFiles(this.fileExtensions);
}
