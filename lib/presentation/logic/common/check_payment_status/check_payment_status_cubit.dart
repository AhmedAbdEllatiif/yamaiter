import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/common/enum/payment_mission_type.dart';
import 'package:yamaiter/data/models/payment/chech_payment_status_request_model.dart';
import 'package:yamaiter/data/params/payment/check_payment_status_params.dart';
import 'package:yamaiter/domain/use_cases/payment/check_paymet_status.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../di/git_it_instance.dart';
import '../../../../domain/entities/app_error.dart';

part 'check_payment_status_state.dart';

class CheckPaymentStatusCubit extends Cubit<CheckPaymentStatusState> {
  CheckPaymentStatusCubit() : super(CheckPaymentStatusInitial());

  /// to checkForPaymentProcessStatus
  void checkForPaymentProcessStatus(
      {required PaymentMissionType missionType,
      required int missionId,
      required String token}) async {
    //==> loading
    _emitIfNotClosed(LoadingCheckPaymentStatus());

    //==> init case
    final useCase = getItInstance<CheckPaymentStatusCase>();

    //==> init params
    final params = CheckPaymentStatusParams(
      model: CheckPaymentStatusModel(
        missionType: missionType.toShortString(),
        missionId: missionId,
      ),
      userToken: token,
    );

    //==> send request
    final either = await useCase(params);

    //==> receive result
    either.fold(
        (appError) => _emitError(appError),
        (success) => _emitIfNotClosed(
              PaymentSuccess(),
            ));
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedCheckPaymentStatus());
    } else if (appError.appErrorType == AppErrorType.notAPaymentProcess) {
      _emitIfNotClosed(NotAPaymentProcessYet());
    } else if (appError.appErrorType == AppErrorType.paymentFailed) {
      _emitIfNotClosed(PaymentFailed());
    } else {
      _emitIfNotClosed(ErrorWhileCheckPaymentStatus(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(CheckPaymentStatusState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
