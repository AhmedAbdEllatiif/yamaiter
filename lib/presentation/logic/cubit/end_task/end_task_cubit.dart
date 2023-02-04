import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../data/params/end_task_params.dart';
import '../../../../di/git_it_instance.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/use_cases/my_tasks/end_task.dart';

part 'end_task_state.dart';

class EndTaskCubit extends Cubit<EndTaskState> {
  EndTaskCubit() : super(EndTaskInitial());


  /// to end the current task
  void endTask({
    required String userToken,
    required final int taskId,
    required final double rating,
  }) async {
    //==> loading
    _emitIfNotClosed(LoadingEndTask());

    //==> init case
    final useCase = getItInstance<EndTaskCase>();

    //==> init params
    final params =
        EndTaskParams(taskId: taskId, userToken: userToken, rating: rating);

    //==> send request
    final either = await useCase(params);

    //==> receive result
    either.fold(
        (appError) => _emitError(appError),
        (success) => _emitIfNotClosed(
              TaskEndedSuccessfully(),
            ));
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedEndTask());
    } else if (appError.appErrorType == AppErrorType.idNotFound) {
      _emitIfNotClosed(TaskNotFound());
    } else if (appError.appErrorType == AppErrorType.notActivatedUser) {
      _emitIfNotClosed(NotActivatedUserToEndTask());
    } else {
      _emitIfNotClosed(ErrorWhileEndingTask(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(EndTaskState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
