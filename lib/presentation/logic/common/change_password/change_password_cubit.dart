import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/data/params/change_password_params.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/use_cases/change_password.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../di/git_it_instance.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordInitial());

  /// to send changePassword request
  void tryToChangePassword({
    required String userToken,
    required String oldPassword,
    required String newPassword,
  }) async {
    //==> loading
    _emitIfNotClosed(LoadingChangePassword());

    //==> init case
    final useCase = getItInstance<ChangePasswordCase>();

    //==> init params
    final params = ChangePasswordParams(
      userToken: userToken,
      oldPassword: oldPassword,
      newPassword: newPassword,
    );

    //==> send request
    final either = await useCase(params);

    //==> receive result
    either.fold(
        (appError) => _emitError(appError),
        (success) => _emitIfNotClosed(
              PasswordChangeSuccessfully(),
            ));
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedWhileChangePassword());
    }
    else if (appError.appErrorType == AppErrorType.wrongPassword) {
      _emitIfNotClosed(WrongPasswordWhileChangePassword());
    }
    else {
      _emitIfNotClosed(ErrorWhileChangingPassword(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(ChangePasswordState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
