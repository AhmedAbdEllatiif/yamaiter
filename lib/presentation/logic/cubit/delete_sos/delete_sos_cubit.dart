import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../data/params/delete_sos_params.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/use_cases/sos/delete_sos.dart';

part 'delete_sos_state.dart';

class DeleteSosCubit extends Cubit<DeleteSosState> {
  DeleteSosCubit() : super(const DeleteSosInitial(-1));

  void cancelDelete() {
    _emitIfNotClosed(DeleteSosInitial(state.sosId));
  }

  /// to delete Sos
  void deleteSos({required int sosId, required String token}) async {
    //==> loading
    _emitIfNotClosed(LoadingDeleteSos(sosId));

    //==> init case
    final deleteSosCase = getItInstance<DeleteSosCase>();

    //==> init params
    final params = DeleteSosParams(id: sosId, userToken: token);

    //==> send request
    final either = await deleteSosCase(params);

    //==> receive result
    either.fold(
            (appError) => _emitError(appError, sosId: sosId),
            (success) => _emitIfNotClosed(
          SosDeletedSuccessfully(sosId),
        ));
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError, {required int sosId}) {
    //==> unauthorizedUser
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedDeleteSos(sosId));
    }
    //==> notActivatedUser
    else if (appError.appErrorType == AppErrorType.notActivatedUser) {
      _emitIfNotClosed(NotActivatedUserToDeleteSos(sosId));
    }
    //==> notFound
    else if (appError.appErrorType == AppErrorType.notFound) {
      _emitIfNotClosed(NotFoundDeleteSos(sosId));
    }
    //==> other
    else {
      _emitIfNotClosed(ErrorWhileDeletingSos(
        appError: appError,
        sosId: sosId,
      ));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(DeleteSosState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
