import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../common/enum/task_status.dart';
import '../../../../data/params/get_applied_tasks_params.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/data/task_entity.dart';
import '../../../../domain/use_cases/applied_tasks/get_applied_tasks.dart';

part 'get_applied_tasks_state.dart';

class GetAppliedTasksCubit extends Cubit<GetAppliedTasksState> {
  GetAppliedTasksCubit() : super(GetAppliedTasksInitial());

  void fetchAppliedTasksList({
    required String userToken,
    required TaskType taskType,
    required int currentListLength,
    int offset = 0,
  }) async {
    //==> loading
    if (currentListLength == 0) {
      _emitIfNotClosed(LoadingGetAppliedTasksList());
    } else {
      _emitIfNotClosed(LoadingMoreAppliedTasksList());
    }

    //==> init case
    final useCase = getItInstance<GetAppliedTasksCase>();

    //==> init params
    final params = GetAppliedTasksParams(
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
      (tasksList) =>
          _emitIfNotClosed(_statusToEmit(tasksList: tasksList, offset: offset)),
    );
  }

  /// to emit the result of success fetching the required sos
  /// * param [offset] is the current offset to fetch
  /// * if the offset > 0 and the length is zero,
  /// this means last page reached
  GetAppliedTasksState _statusToEmit(
      {required List<TaskEntity> tasksList, required int offset}) {
    //==> last page reached
    if (offset > 0 && tasksList.isEmpty) {
      return LastPageAppliedTasksListFetched(taskEntityList: tasksList);
    }
    //==> empty list
    else if (tasksList.isEmpty) {
      return EmptyAppliedTasksList();
    }

    //==>  less than the limit
    else if (tasksList.length < 10) {
      return LastPageAppliedTasksListFetched(taskEntityList: tasksList);
    }

    //==> fetched
    else {
      return AppliedTasksListFetchedSuccessfully(taskEntityList: tasksList);
    }
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedGetAppliedTasksList());
    } else if (appError.appErrorType == AppErrorType.notActivatedUser) {
      _emitIfNotClosed(NotActivatedUserToGetAppliedTasksList());
    } else {
      _emitIfNotClosed(ErrorWhileGettingAppliedTasksList(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(GetAppliedTasksState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
