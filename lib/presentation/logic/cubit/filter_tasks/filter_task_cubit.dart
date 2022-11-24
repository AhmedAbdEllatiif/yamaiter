import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/data/params/filter_task_params.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/data/task_entity.dart';
import '../../../../domain/use_cases/filter_tasks.dart';

part 'filter_task_state.dart';

class FilterTasksCubit extends Cubit<FilterTasksState> {
  FilterTasksCubit() : super(FilterTasksInitial());

  void filterTasksList({
    required FilterTasksParams filterTasksParams,
    required int currentListLength,
  }) async {
    //==> loading
    if (currentListLength == 0) {
      _emitIfNotClosed(LoadingFilterTasksList());
    } else {
      _emitIfNotClosed(LoadingMoreFilterTasks());
    }

    //==> init case
    final useCase = getItInstance<FilterTasksCase>();

    //==> init params
    final params = filterTasksParams;

    //==> send request
    final either = await useCase(params);

    //==> receive result
    either.fold(
      //==> error
      (appError) => _emitError(appError, currentListLength),

      //==> list fetched
      (sosEntityList) => _emitIfNotClosed(
          _statusToEmit(tasksList: sosEntityList, offset: filterTasksParams.offset)),
    );
  }

  /// to emit the result of success fetching the required sos
  /// * param [offset] is the current offset to fetch
  /// * if the offset > 0 and the length is zero,
  /// this means last page reached
  FilterTasksState _statusToEmit(
      {required List<TaskEntity> tasksList, required int offset}) {
    //==> last page reached
    if (offset > 0 && tasksList.isEmpty) {
      return LastPageFilterTasksFetched(taskEntityList: tasksList);
    }
    //==> empty list
    else if (tasksList.isEmpty) {
      return EmptyFilterTasks();
    }

    //==>  less than the limit
    else if (tasksList.length < 10) {
      return LastPageFilterTasksFetched(taskEntityList: tasksList);
    }

    //==> projects fetched
    else {
      return FilteredTasksFetchedSuccessfully(taskEntityList: tasksList);
    }
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError, int currentListSize) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedFilterTasks());
    } else if (appError.appErrorType == AppErrorType.notActivatedUser) {
      _emitIfNotClosed(NotActivatedUserToFilterTasks());
    } else if (currentListSize > 0) {
      _emitIfNotClosed(ErrorWhileFilteringTasks(appError: appError));
    } else {
      _emitIfNotClosed(ErrorWhileFilteringTasks(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(FilterTasksState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
