part of 'pick_image_cubit.dart';

abstract class PickImageState extends Equatable {
  final XFile? imageFile;
  final List<String>? multiImages;

  const PickImageState({
    this.imageFile,
    this.multiImages,
  });

  @override
  List<Object> get props => [];
}

/// initial
class PickImageInitial extends PickImageState {
  const PickImageInitial() : super(imageFile: null, multiImages: null);
}

/// Image picked
class ImagePicked extends PickImageState {
  final XFile image;

  const ImagePicked({required this.image})
      : super(imageFile: image, multiImages: null);

  @override
  List<Object> get props => [image];
}

/// Multi Images picked
class MultiImagesPicked extends PickImageState {
  final List<String> selectedImagesPaths;

  const MultiImagesPicked({required this.selectedImagesPaths})
      : super(imageFile: null, multiImages: selectedImagesPaths);

  @override
  List<Object> get props => [selectedImagesPaths];
}

/// NoImageSelected
class NoImageSelected extends PickImageState {
  const NoImageSelected() : super(imageFile: null, multiImages: null);
}

/// error
class ErrorWhilePickingImage extends PickImageState {
  final AppError appError;

  const ErrorWhilePickingImage({required this.appError})
      : super(imageFile: null, multiImages: null);

  @override
  List<Object> get props => [appError];
}
