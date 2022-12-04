import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../common/enum/task_status.dart';
import '../../../../data/params/client/get_my_task_params_client.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/data/task_entity.dart';
import '../../../../domain/use_cases/client/tasks/get_my_tasks_client.dart';

part 'get_my_tasks_client_state.dart';

class GetMyTasksClientCubit extends Cubit<GetMyTasksClientState> {
  GetMyTasksClientCubit() : super(GetMyTasksClientInitial());

  /// fetch myTasks
  void fetchMyTasksClientList({
    required String userToken,
    required TaskType taskType,
    required int currentListLength,
    int offset = 0,
    bool fetchOnlyNames = false,
  }) async {
    //==> loading
    if (currentListLength == 0) {
      _emitIfNotClosed(LoadingGetMyTasksClientList());
    } else {
      _emitIfNotClosed(LoadingMoreMyTasksClientList());
    }

    //==> init case
    final useCase = getItInstance<GetMyTasksCaseClient>();

    //==> init params
    final params = GetMyTasksClientParams(
      userToken: userToken,
      status: taskType.toShortString(),
      offset: offset,
    );

    //==> send request
    final either = await useCase(params);

    //==> receive result
    either.fold(
      //==> error
      (appError) => _emitError(appError),

      //==> list fetched
      (tasksList) => _emitIfNotClosed(
        _statusToEmit(
            tasksList: tasksList,
            offset: offset,
            emitOnlyNames: fetchOnlyNames),
      ),
    );
  }

  /// to emit the result of success fetching the required sos
  /// * param [offset] is the current offset to fetch
  /// * if the offset > 0 and the length is zero,
  /// this means last page reached
  GetMyTasksClientState _statusToEmit({
    required List<TaskEntity> tasksList,
    required int offset,
    required emitOnlyNames,
  }) {
    if (emitOnlyNames) {
      if (tasksList.isEmpty) {
        return EmptyMyTasksClientList();
      }

      return MyTasksClientListFetchedSuccessfully(taskEntityList: tasksList);
    }

    //==> last page reached
    if (offset > 0 && tasksList.isEmpty) {
      return LastPageMyTasksClientListFetched(taskEntityList: tasksList);
    }
    //==> empty list
    else if (tasksList.isEmpty) {
      return EmptyMyTasksClientList();
    }

    //==>  less than the limit
    else if (tasksList.length < 10) {
      return LastPageMyTasksClientListFetched(taskEntityList: tasksList);
    }

    //==> projects fetched
    else {
      return MyTasksClientListFetchedSuccessfully(taskEntityList: tasksList);
    }
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedGetMyTasksClientList());
    } else if (appError.appErrorType == AppErrorType.notActivatedUser) {
      _emitIfNotClosed(NotActivatedUserToGetMyTasksClientList());
    } else {
      _emitIfNotClosed(ErrorWhileGettingMyTasksClientList(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(GetMyTasksClientState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
