import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../data/params/get_invited_task_params.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/data/task_entity.dart';
import '../../../../domain/use_cases/invited_tasks.dart';

part 'get_invited_task_state.dart';

class GetInvitedTasksCubit extends Cubit<GetInvitedTasksState> {
  GetInvitedTasksCubit() : super(GetInvitedTasksInitial());

  void fetchInvitedTasksList({
    required String userToken,
    required int currentListLength,
    int offset = 0,
  }) async {
    //==> loading
    if (currentListLength == 0) {
      _emitIfNotClosed(LoadingGetInvitedTasksList());
    } else {
      _emitIfNotClosed(LoadingMoreInvitedTasksList());
    }

    //==> init case
    final useCase = getItInstance<GetInvitedTasksCase>();

    //==> init params
    final params = GetInvitedTasksParams(
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
      (tasksList) =>
          _emitIfNotClosed(_statusToEmit(tasksList: tasksList, offset: offset)),
    );
  }

  /// to emit the result of success fetching the required sos
  /// * param [offset] is the current offset to fetch
  /// * if the offset > 0 and the length is zero,
  /// this means last page reached
  GetInvitedTasksState _statusToEmit(
      {required List<TaskEntity> tasksList, required int offset}) {
    //==> last page reached
    if (offset > 0 && tasksList.isEmpty) {
      return LastPageInvitedTasksListFetched(taskEntityList: tasksList);
    }
    //==> empty list
    else if (tasksList.isEmpty) {
      return EmptyInvitedTasksList();
    }

    //==>  less than the limit
    else if (tasksList.length < 10) {
      return LastPageInvitedTasksListFetched(taskEntityList: tasksList);
    }

    //==> fetched
    else {
      return InvitedTasksListFetchedSuccessfully(taskEntityList: tasksList);
    }
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedGetInvitedTasksList());
    } else if (appError.appErrorType == AppErrorType.notActivatedUser) {
      _emitIfNotClosed(NotActivatedUserToGetInvitedTasksList());
    } else {
      _emitIfNotClosed(ErrorWhileGettingInvitedTasksList(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(GetInvitedTasksState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
