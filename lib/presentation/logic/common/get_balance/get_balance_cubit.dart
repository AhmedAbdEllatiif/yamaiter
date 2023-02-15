import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/data/params/payment/get_balance_params.dart';
import 'package:yamaiter/domain/entities/data/balance_entity.dart';
import 'package:yamaiter/domain/use_cases/payment/get_balance_case.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../di/git_it_instance.dart';
import '../../../../domain/entities/app_error.dart';

part 'get_balance_state.dart';

class GetBalanceCubit extends Cubit<GetBalanceState> {
  GetBalanceCubit() : super(GetBalanceInitial());

  /// to get user balance
  void tryToGetUserBalance({
    required String userToken,
  }) async {
    //==> loading
    _emitIfNotClosed(LoadingBalance());

    //==> init case
    final usecase = getItInstance<GetBalanceCase>();

    //==> init params
    final params = GetBalanceParams(
      userToken: userToken,
    );

    //==> send request
    final either = await usecase(params);

    //==> receive result
    either.fold(
      //==> error
      (appError) {
        _emitError(appError);
      },
      //==> success
      (balanceEntity) {
        if (balanceEntity.currentBalance == 0) {
          _emitIfNotClosed(UserHaveNoBalance());
        }

        _emitIfNotClosed(BalanceFetchedSuccessfully(
          balanceEntity: balanceEntity,
        ));
      },
    );
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedGetBalance());
    } else {
      _emitIfNotClosed(ErrorWhileFetchingBalance(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(GetBalanceState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
