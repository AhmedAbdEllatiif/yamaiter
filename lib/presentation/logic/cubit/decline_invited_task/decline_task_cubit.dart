import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/data/params/decline_task_params.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/use_cases/applied_tasks/decline_invited_task.dart';

part 'decline_task_state.dart';

class DeclineTaskCubit extends Cubit<DeclineTaskState> {
  DeclineTaskCubit() : super(const DeclineTaskInitial(-1));

  /// to decline task
  void declineTask({required int taskId, required String token}) async {
    //==> loading
    _emitIfNotClosed(LoadingDeclineTask(taskId));

    //==> init case
    final declineTaskCase = getItInstance<DeclineInvitedTaskCase>();

    //==> init params
    final params = DeclineTaskParams(userToken: token, taskId: taskId);

    //==> send request
    final either = await declineTaskCase(params);

    //==> receive result
    either.fold(
        (appError) => _emitError(appError, taskId: taskId),
        (success) => _emitIfNotClosed(
              TaskDeclinedSuccessfully(taskId),
            ));
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError, {required int taskId}) {
    //==> unauthorizedUser
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedDeclineTask(taskId));
    }
    //==> notActivatedUser
    else if (appError.appErrorType == AppErrorType.notActivatedUser) {
      _emitIfNotClosed(NotActivatedUserToDeclineTask(taskId));
    }
    //==> notFound
    else if (appError.appErrorType == AppErrorType.notFound) {
      _emitIfNotClosed(NotFoundDeclineTask(taskId));
    }
    //==> other
    else {
      _emitIfNotClosed(ErrorWhileDeletingArticle(
        appError: appError,
        taskId: taskId,
      ));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(DeclineTaskState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
