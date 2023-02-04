import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

abstract class MyFilePickerState extends Equatable {
  const MyFilePickerState();

  @override
  List<Object> get props => [];
}

/// no file selected
class NoFileSelected extends MyFilePickerState {}

/// max file size reached
class MaxFileSizeReached extends MyFilePickerState {
  final String maxSizeToSelect;

  const MaxFileSizeReached({required this.maxSizeToSelect});
}

/// success
class FilePickedSuccessfully extends MyFilePickerState {
  final PlatformFile selectedFile;

  const FilePickedSuccessfully({required this.selectedFile});

  @override
  List<Object> get props => [selectedFile];
}

/// error
class ErrorWhilePickingFile extends MyFilePickerState {
  final String errorMessage;

  const ErrorWhilePickingFile({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
