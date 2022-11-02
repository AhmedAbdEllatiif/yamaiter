import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/common/enum/task_status.dart';
import 'package:yamaiter/data/params/get_my_tasks_params.dart';
import 'package:yamaiter/domain/use_cases/tasks/get_my_tasks.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/data/task_entity.dart';

part 'get_my_tasks_state.dart';

class GetMyTasksCubit extends Cubit<GetMyTasksState> {
  GetMyTasksCubit() : super(GetMyTasksInitial());

  void fetchMyTasksList({
    required String userToken,
    required TaskType taskType,
    required int currentListLength,
    int offset = 0,
  }) async {
    //==> loading
    if (currentListLength == 0) {
      _emitIfNotClosed(LoadingGetMyTasksList());
    } else {
      _emitIfNotClosed(LoadingMoreMyTasksList());
    }

    //==> init case
    final useCase = getItInstance<GetMyTasksCase>();

    //==> init params
    final params = GetMyTasksParams(
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
      (sosEntityList) => _emitIfNotClosed(
          _statusToEmit(tasksList: sosEntityList, offset: offset)),
    );
  }

  /// to emit the result of success fetching the required sos
  /// * param [offset] is the current offset to fetch
  /// * if the offset > 0 and the length is zero,
  /// this means last page reached
  GetMyTasksState _statusToEmit(
      {required List<TaskEntity> tasksList, required int offset}) {
    //==> last page reached
    if (offset > 0 && tasksList.isEmpty) {
      return LastPageMyTasksListFetched(taskEntityList: tasksList);
    }
    //==> empty list
    else if (tasksList.isEmpty) {
      return EmptyMyTasksList();
    }

    //==>  less than the limit
    else if (tasksList.length < 10) {
      return LastPageMyTasksListFetched(taskEntityList: tasksList);
    }

    //==> projects fetched
    else {
      return MyTasksListFetchedSuccessfully(taskEntityList: tasksList);
    }
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedGetMyTasksList());
    } else if (appError.appErrorType == AppErrorType.notActivatedUser) {
      _emitIfNotClosed(NotActivatedUserToGetMyTasksList());
    } else {
      _emitIfNotClosed(ErrorWhileGettingMyTasksList(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(GetMyTasksState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
