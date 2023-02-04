import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/common/enum/payment_mission_type.dart';
import 'package:yamaiter/domain/entities/data/pay_entity.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../data/models/consultations/create_consultation_request_model.dart';
import '../../../../data/params/client/create_consultation_params.dart';
import '../../../../di/git_it_instance.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/use_cases/client/consultations/create_consultaion.dart';

part 'create_consultation_state.dart';

class CreateConsultationCubit extends Cubit<CreateConsultationState> {
  CreateConsultationCubit() : super(CreateConsultationInitial());

  /// to create Consultation
  void payForConsult({
    required String title,
    required double consultFees,
    required String description,
    required List<String> imagePaths,
    required String token,
  }) async {
    //==> loading
    _emitIfNotClosed(LoadingCreateConsultation());

    //==> init case
    final useCase = getItInstance<CreateConsultationCase>();

    //==> init params
    final params = PayForConsultationParams(
      requestModel: CreateConsultationRequestModel(
        paymentMissionType: PaymentMissionType.consultation,
        consultFees: consultFees,
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
      (payEntity) => _emitIfNotClosed(
        ConsultationCreatedSuccessfully(
          payEntity: payEntity,
        ),
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
