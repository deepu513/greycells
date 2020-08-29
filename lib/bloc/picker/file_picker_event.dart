part of 'file_picker_bloc.dart';

abstract class FilePickerEvent {}

class PickImageFile extends FilePickerEvent {}

class PickPdfFile extends FilePickerEvent {}
