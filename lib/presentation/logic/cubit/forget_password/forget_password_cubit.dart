import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../data/params/forget_password_params.dart';
import '../../../../di/git_it_instance.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/use_cases/forget_password.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  /// to send ForgetPassword request
  void tryToSendForgetPassword({
    required String email,
  }) async {
    //==> loading
    _emitIfNotClosed(LoadingForgetPassword());

    //==> init case
    final useCase = getItInstance<ForgetPasswordCase>();

    //==> init params
    final params = ForgetPasswordParams(
      email: email,
    );

    //==> send request
    final either = await useCase(params);

    //==> receive result
    either.fold(
        (appError) => _emitError(appError),
        (success) => _emitIfNotClosed(
              ForgetPasswordSentSuccessfully(),
            ));
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.wrongEmail) {
      _emitIfNotClosed(WrongEmailWhileForgetPassword());
    } else {
      _emitIfNotClosed(
          ErrorWhileSendForgetPasswordPassword(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(ForgetPasswordState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
