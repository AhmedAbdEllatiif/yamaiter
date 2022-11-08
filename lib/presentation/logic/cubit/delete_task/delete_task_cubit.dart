import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../data/params/delete_task_params.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/use_cases/my_tasks/delete_task.dart';

part 'delete_task_state.dart';

class DeleteTaskCubit extends Cubit<DeleteTaskState> {
  DeleteTaskCubit() : super(const DeleteTaskInitial(-1));

  /// to delete Task
  void deleteTask({required int taskId, required String token}) async {
    //==> loading
    _emitIfNotClosed(LoadingDeleteTask(taskId));

    //==> init case
    final deleteTaskCase = getItInstance<DeleteTaskCase>();

    //==> init params
    final params = DeleteTaskParams(id: taskId, userToken: token);

    //==> send request
    final either = await deleteTaskCase(params);

    //==> receive result
    either.fold(
        (appError) => _emitError(appError, taskId: taskId),
        (success) => _emitIfNotClosed(
              TaskDeletedSuccessfully(taskId),
            ));
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError, {required int taskId}) {
    //==> unauthorizedUser
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedDeleteTask(taskId));
    }
    //==> notActivatedUser
    else if (appError.appErrorType == AppErrorType.notActivatedUser) {
      _emitIfNotClosed(NotActivatedUserToDeleteTask(taskId));
    }
    //==> notFound
    else if (appError.appErrorType == AppErrorType.notFound) {
      _emitIfNotClosed(NotFoundDeleteTask(taskId));
    }
    //==> other
    else {
      _emitIfNotClosed(ErrorWhileDeletingTask(
        appError: appError,
        taskId: taskId,
      ));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(DeleteTaskState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
