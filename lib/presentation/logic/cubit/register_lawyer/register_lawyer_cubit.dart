import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/data/params/register_lawyer_request_params.dart';
import 'package:yamaiter/domain/entities/data/register_response_entity.dart';
import 'package:yamaiter/domain/use_cases/register_lawyer.dart';

import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';

part 'register_lawyer_state.dart';

class RegisterLawyerCubit extends Cubit<RegisterLawyerState> {
  RegisterLawyerCubit() : super(RegisterLawyerInitial());

  /// Send register lawyer request
  void tryToRegister({
    required String name,
    required String email,
    required String phone,
    required String governorates,
    required String courtName,
    required String password,
    required String idPhotoPath,
  }) async {
    // loading
    _emitIfNotClosed(LoadingRegisterLawyer());

    // init register case
    final registerCase = getItInstance<RegisterLawyerCase>();

    // init params
    final params = RegisterLawyerRequestParams(
      name: name,
      email: email,
      phone: phone,
      governorates: governorates,
      courtName: courtName,
      password: password,
      idPhotoPath: idPhotoPath,
    );

    // send register lawyer request
    final either = await registerCase(params);

    either.fold(
      // error
      (appError) => _emitIfNotClosed(ErrorWhileRegistrationLawyer(appError: appError)),

      // success to register lawyer
      (registerLawyerResponseEntity) => _emitIfNotClosed(
        RegisterLawyerSuccess(registerResponseEntity: registerLawyerResponseEntity),
      ),
    );
  }

  /// emit if not close
  void _emitIfNotClosed(RegisterLawyerState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
