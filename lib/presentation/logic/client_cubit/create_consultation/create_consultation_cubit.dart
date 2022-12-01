import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../data/models/consultations/create_consultation_request_model.dart';
import '../../../../data/params/client/create_consultation_params.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/use_cases/client/consultations/create_consultaion.dart';

part 'create_consultation_state.dart';

class CreateConsultationCubit extends Cubit<CreateConsultationState> {
  CreateConsultationCubit() : super(CreateConsultationInitial());

  /// to create Consultation
  void sendConsultation({
    required String title,
    required String description,
    required List<String> imagePaths,
    required String token,
  }) async {
    //==> loading
    _emitIfNotClosed(LoadingCreateConsultation());

    //==> init case
    final useCase = getItInstance<CreateConsultationCase>();

    //==> init params
    final params = CreateConsultationParams(
      requestModel: CreateConsultationRequestModel(
        title: title,
        description: description,
        imageList: imagePaths,
      ),
      token: token,
    );

    //==> send request
    final either = await useCase(params);

    //==> receive result
    either.fold(
      (appError) => _emitError(appError),
      (success) => _emitIfNotClosed(
        ConsultationCreatedSuccessfully(),
      ),
    );
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedCreateConsultation());
    } else if (appError.appErrorType == AppErrorType.notAcceptedYet) {
      _emitIfNotClosed(NotAcceptTermsToCreateConsultation());
    } else if (appError.appErrorType == AppErrorType.notActivatedUser) {
      _emitIfNotClosed(NotActivatedUserToCreateConsultation());
    } else {
      _emitIfNotClosed(ErrorWhileCreatingConsultation(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(CreateConsultationState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
