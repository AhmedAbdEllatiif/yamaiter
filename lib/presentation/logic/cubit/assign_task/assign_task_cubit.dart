import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/data/params/assign_task_params.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/use_cases/my_tasks/assign_task.dart';

part 'assign_task_state.dart';

class AssignTaskCubit extends Cubit<AssignTaskState> {
  AssignTaskCubit() : super(AssignTaskInitial());

  /// to assignTask
  void assignTask(
      {required int userId, required int taskId, required String token}) async {
    //==> loading
    _emitIfNotClosed(LoadingAssignTask());

    //==> init case
    final useCase = getItInstance<AssignTaskCase>();

    //==> init params
    final params = AssignTaskParams(
      userId: userId,
      taskId: taskId,
      userToken: token,
    );

    //==> send request
    final either = await useCase(params);

    //==> receive result
    either.fold(
        (appError) => _emitError(appError),
        (success) => _emitIfNotClosed(
              TaskAssignedSuccessfully(),
            ));
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedAssignTask());
    } else if (appError.appErrorType == AppErrorType.notActivatedUser) {
      _emitIfNotClosed(NotActivatedUserToAssignTask());
    } else {
      _emitIfNotClosed(ErrorWhileAssigningTask(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(AssignTaskState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
