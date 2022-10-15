import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/data/params/update_sos_params.dart';
import 'package:yamaiter/domain/use_cases/sos/update_sos.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../data/models/sos/create_sos/sos_request_model.dart';
import '../../../../data/params/create_sos_params.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';

part 'update_sos_state.dart';

class UpdateSosCubit extends Cubit<UpdateSosState> {
  UpdateSosCubit() : super(UpdateSosInitial());


  /// to update sos
  void updateSos({required String type,
    required String governorate,
    required String description,
    required int sosId,
    required String token}) async {
    //==> loading
    _emitIfNotClosed(LoadingUpdateSos());

    //==> init case
    final createSosCase = getItInstance<UpdateSosCase>();

    //==> init params
    final params = UpdateSosParams(
      sosId:sosId,
      sosRequestModel: SosRequestModel(
          type: type, governorate: governorate, description: description),
      token: token,
    );

    //==> send request
    final either = await createSosCase(params);

    //==> receive result
    either.fold(
            (appError) => _emitError(appError),
            (success) =>
            _emitIfNotClosed(
              SosUpdatedSuccessfully(),
            ));
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedUpdateSos());
    } else if (appError.appErrorType == AppErrorType.notActivatedUser) {
      _emitIfNotClosed(NotActivatedUserToUpdateSos());
    } else {
      _emitIfNotClosed(ErrorWhileUpdatingSos(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(UpdateSosState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
