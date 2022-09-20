part of 'pick_image_cubit.dart';

abstract class PickImageState extends Equatable {

  final XFile? imageFile;
  const PickImageState(this.imageFile);


  @override
  List<Object> get props => [];
}

/// initial
class PickImageInitial extends PickImageState {
  const PickImageInitial():super(null);
}


/// Image picked
class ImagePicked extends PickImageState {
  final XFile image;

  const ImagePicked({required this.image}) : super(image);


  @override
  List<Object> get props => [image];
}

/// NoImageSelected
class NoImageSelected extends PickImageState {
  const NoImageSelected():super(null);
}

/// error
class ErrorWhilePickingImage extends PickImageState {
  final AppError appError;

  const ErrorWhilePickingImage({required this.appError}):super(null);


  @override
  List<Object> get props => [appError];
}


