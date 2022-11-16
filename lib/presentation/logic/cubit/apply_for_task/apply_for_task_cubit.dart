import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../data/params/apply_for_task.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/use_cases/applied_tasks/apply_for_task.dart';

part 'apply_for_task_state.dart';

class ApplyForTaskCubit extends Cubit<ApplyForTaskState> {
  ApplyForTaskCubit() : super(ApplyForTaskInitial());

  /// to ApplyForTask
  void applyForTask(
      {required int cost, required int taskId, required String token}) async {
    //==> loading
    _emitIfNotClosed(LoadingApplyForTask());

    //==> init case
    final useCase = getItInstance<ApplyForTaskCase>();

    //==> init params
    final params = ApplyForTaskParams(
      taskId: taskId,
      userToken: token,
      cost: cost,
    );

    //==> send request
    final either = await useCase(params);

    //==> receive result
    either.fold(
            (appError) => _emitError(appError),
            (success) =>
            _emitIfNotClosed(
              AppliedForTaskSuccessfully(),
            ));
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedApplyForTask());
    } else if (appError.appErrorType == AppErrorType.notActivatedUser) {
      _emitIfNotClosed(NotActivatedUserToApplyForTask());
    } else if (appError.appErrorType == AppErrorType.alreadyAppliedToThisTask) {
      _emitIfNotClosed(AlreadyAppliedToThisTask());
    }
    else {
      _emitIfNotClosed(ErrorWhileApplyingForTask(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(ApplyForTaskState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
