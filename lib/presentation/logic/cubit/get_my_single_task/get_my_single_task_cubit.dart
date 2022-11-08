import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/data/params/my_single_task_params.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/data/task_entity.dart';
import '../../../../domain/use_cases/my_tasks/get_my_single_task.dart';

part 'get_my_single_task_state.dart';

class GetMySingleTaskCubit extends Cubit<GetMySingleTaskState> {
  GetMySingleTaskCubit() : super(GetMySingleTaskInitial());

  void fetchMySingleTask({
    required String userToken,
    required int taskId,
  }) async {
    //==> loading
    _emitIfNotClosed(LoadingGetMySingleTask());

    //==> init case
    final useCase = getItInstance<GetMySingleTaskCase>();

    //==> init params
    final params = GetSingleTaskParams(
      userToken: userToken,
      taskId: taskId,
    );

    //==> send request
    final either = await useCase(params);

    //==> receive result
    either.fold(
      //==> error
      (appError) => _emitError(appError),

      //==>  fetched
      (taskEntity) => _emitIfNotClosed(
          MySingleTaskFetchedSuccessfully(taskEntity: taskEntity)),
    );
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedGetMySingleTask());
    } else if (appError.appErrorType == AppErrorType.notActivatedUser) {
      _emitIfNotClosed(NotActivatedGetMySingleTask());
    } else {
      _emitIfNotClosed(ErrorWhileGettingMySingleTask(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(GetMySingleTaskState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
