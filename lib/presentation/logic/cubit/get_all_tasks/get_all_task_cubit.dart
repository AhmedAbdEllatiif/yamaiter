import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../data/params/get_all_task_params.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/data/task_entity.dart';
import '../../../../domain/use_cases/tasks/get_all_tasks.dart';

part 'get_all_task_state.dart';

class GetAllTaskCubit extends Cubit<GetAllTasksState> {
  GetAllTaskCubit() : super(GetAllTasksInitial());

  void fetchAllTasksList({
    required String userToken,
    required int currentListLength,
    int offset = 0,
  }) async {
    //==> loading
    if (currentListLength == 0) {
      _emitIfNotClosed(LoadingGetAllTasksList());
    } else {
      _emitIfNotClosed(LoadingMoreAllTasksList());
    }

    //==> init case
    final useCase = getItInstance<GetAllTasksCase>();

    //==> init params
    final params = GetAllTasksParams(
      userToken: userToken,
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
  GetAllTasksState _statusToEmit(
      {required List<TaskEntity> tasksList, required int offset}) {
    //==> last page reached
    if (offset > 0 && tasksList.isEmpty) {
      return LastPageAllTasksListFetched(taskEntityList: tasksList);
    }
    //==> empty list
    else if (tasksList.isEmpty) {
      return EmptyAllTasksList();
    }

    //==>  less than the limit
    else if (tasksList.length < 10) {
      return LastPageAllTasksListFetched(taskEntityList: tasksList);
    }

    //==> projects fetched
    else {
      return AllTasksListFetchedSuccessfully(taskEntityList: tasksList);
    }
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedGetAllTasksList());
    } else if (appError.appErrorType == AppErrorType.notActivatedUser) {
      _emitIfNotClosed(NotActivatedUserToGetAllTasksList());
    } else {
      _emitIfNotClosed(ErrorWhileGettingAllTasksList(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(GetAllTasksState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
