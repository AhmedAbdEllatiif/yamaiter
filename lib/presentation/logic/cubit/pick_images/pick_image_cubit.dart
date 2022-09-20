import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yamaiter/common/enum/app_error_type.dart';
import 'package:yamaiter/domain/entities/app_error.dart';

part 'pick_image_state.dart';

class PickImageCubit extends Cubit<PickImageState> {
  PickImageCubit() : super(const PickImageInitial());

  void validate() {
    if (state.imageFile == null) {
      _emitIfNotClosed(const NoImageSelected());
    } else {
      _emitIfNotClosed(ImagePicked(image: state.imageFile!));
    }
  }

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

  /// emit if not closed
  void _emitIfNotClosed(PickImageState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
