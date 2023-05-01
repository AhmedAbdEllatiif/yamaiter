import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/data/params/payment/charge_balance_params.dart';
import 'package:yamaiter/domain/entities/data/charge_balance_entity.dart';
import 'package:yamaiter/domain/use_cases/payment/charge_balance_case.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../di/git_it_instance.dart';
import '../../../../domain/entities/app_error.dart';

part 'charge_balance_state.dart';

class ChargeBalanceCubit extends Cubit<ChargeBalanceState> {
  ChargeBalanceCubit() : super(ChargeBalanceInitial());

  void tryToChargeBalance({
    required String userToken,
    required double amount,
  }) async {
    //==> loading
    _emitIfNotClosed(LoadingToChargeBalance());

    //==> init case
    final useCase = getItInstance<ChargeBalanceCase>();

    //==> init params
    final params =
        ChargeBalanceParams(amountToCharge: amount, userToken: userToken);

    //==> send request
    final either = await useCase(params);

    //==> receive result
    either.fold(
        (appError) => _emitError(appError),
        (chargeBalanceEntity) => _emitIfNotClosed(
              BalanceChargedSuccessfully(
                  chargeBalanceEntity: chargeBalanceEntity),
            ));
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedToChargeBalance());
    } else if (appError.appErrorType == AppErrorType.notActivatedUser) {
      //_emitIfNotClosed(NotActivatedUserToCreateAd());
    } else {
      _emitIfNotClosed(ErrorWhileChargingBalance(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(ChargeBalanceState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
