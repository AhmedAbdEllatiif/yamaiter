import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/data/params/my_single_task_params.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/entities/data/task_entity.dart';
import 'package:yamaiter/domain/use_cases/get_single_task_details_case.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../di/git_it_instance.dart';

part 'get_single_task_details_state.dart';

class GetSingleTaskDetailsCubit extends Cubit<GetSingleTaskDetailsState> {
  GetSingleTaskDetailsCubit() : super(GetSingleTaskDetailsInitial());

  void tryToFetchTaskDetails({
    required int taskId,
    required String userToken,
  }) async {
    //==> loading
    _emitIfNotClosed(LoadingSingleTaskDetails());

    //==> init case
    final useCase = getItInstance<GetSingleTaskDetailsCase>();

    //==> init params
    final params = GetSingleTaskParams(taskId: taskId, userToken: userToken);

    //==> send request
    final either = await useCase(params);

    //==> receive result
    either.fold(
        (appError) => _emitError(appError),
        (taskEntity) => _emitIfNotClosed(
              TaskFetchedSuccessfully(taskEntity: taskEntity),
            ));
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthenticatedToFetchSingleTaskDetails());
    } else {
      _emitIfNotClosed(ErrorWhileFetchingTaskDetails(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(GetSingleTaskDetailsState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
