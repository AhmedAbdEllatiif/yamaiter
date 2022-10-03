import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/data/models/sos/create_sos/sos_request_model.dart';
import 'package:yamaiter/data/params/create_sos_params.dart';
import 'package:yamaiter/di/git_it.dart';
import 'package:yamaiter/domain/entities/data/sos_entity.dart';
import 'package:yamaiter/domain/use_cases/create_sos.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../data/models/success_model.dart';
import '../../../../domain/entities/app_error.dart';

part 'create_sos_state.dart';

class CreateSosCubit extends Cubit<CreateSosState> {
  CreateSosCubit() : super(CreateSosInitial());

  /// to create sos
  void sendSos(
      {required String type,
      required String governorate,
      required String description,
      required String token}) async {
    //==> loading
    _emitIfNotClosed(LoadingCreateSos());

    //==> init case
    final createSosCase = getItInstance<CreateSosCase>();

    //==> init params
    final params = CreateSosParams(
        sosRequestModel: SosRequestModel(
            type: type, governorate: governorate, description: description),
        token: token);

    //==> send request
    final either = await createSosCase(params);

    //==> receive result
    either.fold(
        (appError) => _emitError(appError),
        (success) => _emitIfNotClosed(
              SosCreatedSuccessfully(),
            ));
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedCreateSos());
    } else if (appError.appErrorType == AppErrorType.notActivatedUser) {
      _emitIfNotClosed(NotActivatedUserToCreateSos());
    } else {
      _emitIfNotClosed(ErrorWhileCreatingSos(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(CreateSosState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
