import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/common/enum/app_error_type.dart';
import 'package:yamaiter/data/params/login_request_params.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/entities/data/login_response_entity.dart';
import 'package:yamaiter/domain/use_cases/login.dart';

import '../../../../di/git_it_instance.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  /// Send login request
  void tryToLogin({required String email, required String password}) async {
    // loading
    _emitIfNotClosed(LoadingLogin());

    // init login case
    final loginCase = getItInstance<LoginCase>();

    // send login request
    final either =
    await loginCase(LoginRequestParams(email: email, password: password));

    either.fold(
      // error
          (appError) => _emitError(appError),

      // success to login
          (loginResponseEntity) =>
          _emitIfNotClosed(
            LoginSuccess(loginResponseEntity: loginResponseEntity),
          ),
    );
  }

  /// To emit the required state according to [appError]
  /// * [appError] the received app error from Login request
  void _emitError(AppError appError) {
    final appErrorType = appError.appErrorType;

    // wrongPassword
    if (appErrorType == AppErrorType.wrongPassword) {
      _emitIfNotClosed(WrongPassword());
    }

    // wrongEmail
    else if (appErrorType == AppErrorType.wrongEmail) {
      _emitIfNotClosed(WrongEmail());
    }

    // any error
    else {
      _emitIfNotClosed(ErrorWhileLogin(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(LoginState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
