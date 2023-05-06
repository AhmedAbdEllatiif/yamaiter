import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/data/params/payment/pay_out_params.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/use_cases/payment/payout_case.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../di/git_it_instance.dart';

part 'payout_state.dart';

class PayoutCubit extends Cubit<PayoutState> {
  PayoutCubit() : super(PayoutInitial());

  /// to send payout
  void tryToSendPayout({
    required String userToken,
    required String method,
    required String phoneNum,
  }) async {
    //==> loading
    _emitIfNotClosed(LoadingPayout());

    //==> init case
    final useCase = getItInstance<PayoutCase>();

    //==> init params
    final params = PayoutParams(
      userToken: userToken,
      method: method,
      phone: phoneNum,
    );

    //==> send request
    final either = await useCase(params);

    //==> receive result
    either.fold(
        (appError) => _emitError(appError),
        (success) => _emitIfNotClosed(
              PayoutSentSuccessfully(),
            ));
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedToSendPayout());
    } else if (appError.appErrorType == AppErrorType.errorFromPayMobServer) {
      _emitIfNotClosed(NoPayoutErrorFromPayMobServer());
    } else if (appError.appErrorType == AppErrorType.noWithdrawalAmount) {
      _emitIfNotClosed(NoAmountToPayout());
    } else {
      _emitIfNotClosed(ErrorWhileSendingPayout(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(PayoutState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
