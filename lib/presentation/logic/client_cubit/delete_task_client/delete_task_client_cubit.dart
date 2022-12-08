import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../data/params/client/delete_task_params.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/use_cases/client/tasks/delete_task_client_case.dart';

part 'delete_task_client_state.dart';

class DeleteTaskClientCubit extends Cubit<DeleteTaskClientState> {
  DeleteTaskClientCubit() : super(const DeleteTaskClientInitial(-1));

  /// to delete Task client
  void deleteTaskClient({required int taskId, required String token}) async {
    //==> loading
    _emitIfNotClosed(LoadingDeleteTaskClient(taskId));

    //==> init case
    final deleteTaskClientCase = getItInstance<DeleteTaskClientCase>();

    //==> init params
    final params = DeleteTaskClientParams(id: taskId, userToken: token);

    //==> send request
    final either = await deleteTaskClientCase(params);

    //==> receive result
    either.fold(
        (appError) => _emitError(appError, taskId: taskId),
        (success) => _emitIfNotClosed(
              TaskClientDeletedSuccessfully(taskId),
            ));
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError, {required int taskId}) {
    //==> unauthorizedUser
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedDeleteTaskClient(taskId));
    }
    //==> notActivatedUser
    else if (appError.appErrorType == AppErrorType.notActivatedUser) {
      _emitIfNotClosed(NotActivatedUserToDeleteTaskClient(taskId));
    }
    //==> notFound
    else if (appError.appErrorType == AppErrorType.notFound) {
      _emitIfNotClosed(NotFoundDeleteTaskClient(taskId));
    }
    //==> other
    else {
      _emitIfNotClosed(ErrorWhileDeletingTaskClient(
        appError: appError,
        taskId: taskId,
      ));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(DeleteTaskClientState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
