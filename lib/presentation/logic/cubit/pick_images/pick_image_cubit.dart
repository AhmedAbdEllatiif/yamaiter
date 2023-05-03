import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yamaiter/common/enum/app_error_type.dart';
import 'package:yamaiter/domain/entities/app_error.dart';

part 'pick_image_state.dart';

class PickImageCubit extends Cubit<PickImageState> {
  PickImageCubit() : super(const PickImageInitial());

  /// to pick single image
  void pickSingleImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        //maxWidth: maxWidth,
        //maxHeight: maxHeight,
        //imageQuality: quality,
      );

      _emitIfNotClosed(ImagePicked(image: pickedFile!));
    } catch (e) {
      _emitIfNotClosed(
        ErrorWhilePickingImage(
          appError: AppError(AppErrorType.pickImage, message: "$e"),
        ),
      );
    }
  }

  /// to pick multi images
  void pickMultiImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final List<XFile> selectedImages = await picker.pickMultiImage(
          //maxWidth: maxWidth,
          //maxHeight: maxHeight,
          //imageQuality: quality,
          );

      List<String> strList = [];
      for (var element in selectedImages) {
        strList.add(element.path);
      }
      _emitIfNotClosed(MultiImagesPicked(selectedImagesPaths: strList));
    } catch (e) {
      _emitIfNotClosed(
        ErrorWhilePickingImage(
          appError: AppError(AppErrorType.pickImage, message: "$e"),
        ),
      );
    }
  }

  /// to validate on single image selected
  void validateOnSingleImage() {
    if (state.imageFile == null) {
      _emitIfNotClosed(const NoImageSelected());
    } else {
      _emitIfNotClosed(ImagePicked(image: state.imageFile!));
    }
  }

  /// to validate on multi images selected
  void validateOnMultiImages() {
    if (state.multiImages == null) {
      _emitIfNotClosed(const NoImageSelected());
    } else {
      _emitIfNotClosed(MultiImagesPicked(selectedImagesPaths: state.multiImages!));
    }
  }

  /// emit if not closed
  void _emitIfNotClosed(PickImageState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
