import 'dart:ui';
import 'package:equatable/equatable.dart';

abstract class MyImagePickerState extends Equatable {
  const MyImagePickerState();

  @override
  List<Object> get props => [];
}

/// no Image selected
class NoImageSelected extends MyImagePickerState {}

/// max Image size reached
class MaxImageSizeReached extends MyImagePickerState {
  final String maxSizeToSelect;

  const MaxImageSizeReached({required this.maxSizeToSelect});
}

/// success
class ImagePickedSuccessfully extends MyImagePickerState {
  final Image selectedImage;
  final String imageName;
  final num imageSize;
  final String imagePath;

  const ImagePickedSuccessfully({
    required this.selectedImage,
    required this.imagePath,
    required this.imageName,
    required this.imageSize,
  });

  @override
  List<Object> get props => [selectedImage];
}

/// error
class ErrorWhilePickingImage extends MyImagePickerState {
  final String errorMessage;

  const ErrorWhilePickingImage({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
