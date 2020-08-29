part of 'file_picker_bloc.dart';

@immutable
abstract class FilePickerState {}

class FilePickerInitial extends FilePickerState {}

class ImageFilePicked extends FilePickerState {
  final File pickedFile;

  ImageFilePicked(this.pickedFile);
}

class PdfFilePicked extends FilePickerState {
  final File pickedFile;

  PdfFilePicked(this.pickedFile);
}

class UnsupportedFilePicked extends FilePickerState {}

class FileSizeTooLarge extends FilePickerState {}

class FilePickCancelled extends FilePickerState {}