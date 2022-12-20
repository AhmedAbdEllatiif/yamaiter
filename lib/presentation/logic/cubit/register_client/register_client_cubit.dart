import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../data/params/register_client_params.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/data/register_response_entity.dart';
import '../../../../domain/use_cases/client_auth/register_client.dart';

part 'register_client_state.dart';

class RegisterClientCubit extends Cubit<RegisterClientState> {
  RegisterClientCubit() : super(RegisterClientInitial());

  /// Send register Client request
  void tryToRegister({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String governorates,
    required String password,
    required bool isTermsAccepted,
  }) async {
    // loading
    _emitIfNotClosed(LoadingRegisterClient());

    // init case
    final useCase = getItInstance<RegisterClientCase>();

    // init params
    final params = RegisterClientParams(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      governorates: governorates,
      password: password,
      isTermsAccepted: isTermsAccepted,
    );

    // send register Client request
    final either = await useCase(params);

    either.fold(
      // error
      (appError) => _emitError(appError),

      // success
      (registerResponseEntity) => _emitIfNotClosed(
        RegisterClientSuccess(registerResponseEntity: registerResponseEntity),
      ),
    );
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.emailAlreadyExists) {
      _emitIfNotClosed(ClientEmailAlreadyExists());
    } else if (appError.appErrorType == AppErrorType.alreadyPhoneUsedBefore) {
      _emitIfNotClosed(ClientNumberAlreadyExists());
    } else {
      _emitIfNotClosed(ErrorWhileRegistrationClient(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(RegisterClientState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
