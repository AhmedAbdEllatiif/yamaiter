import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/data/models/payment/refund_request_model.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../common/enum/payment_mission_type.dart';
import '../../../../data/params/payment/refund_params.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/use_cases/payment/refund_payment.dart';

part 'refund_payment_state.dart';

class RefundPaymentCubit extends Cubit<RefundPaymentState> {
  RefundPaymentCubit() : super(RefundPaymentInitial());

  /// to refundPayment
  void refundPayment(
      {required PaymentMissionType missionType,
      required int missionId,
      required String token}) async {
    //==> loading
    _emitIfNotClosed(LoadingRefundPayment());

    //==> init case
    final useCase = getItInstance<RefundPaymentCase>();

    //==> init params
    final params = RefundParams(
      model: RefundRequestModel(
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
              RefundSuccess(),
            ));
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedRefundPayment());
    } else if (appError.appErrorType == AppErrorType.paymentFailed) {
      _emitIfNotClosed(RefundFailed());
    } else {
      _emitIfNotClosed(ErrorWhileRefundingPayment(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(RefundPaymentState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
