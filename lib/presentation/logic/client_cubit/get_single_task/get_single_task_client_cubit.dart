import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/data/params/client/get_single_task_params_client.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/data/task_entity.dart';
import '../../../../domain/use_cases/client/tasks/single_task_case.dart';

part 'get_single_task_client_state.dart';

class GetSingleTaskClientCubit extends Cubit<GetSingleTaskClientState> {
  GetSingleTaskClientCubit() : super(GetSingleTaskClientInitial());

  void fetchSingleTaskClient({
    required String userToken,
    required int taskId,
  }) async {
    //==> loading
    _emitIfNotClosed(LoadingGetSingleTaskClient());

    //==> init case
    final useCase = getItInstance<GetSingleTaskClientCase>();

    //==> init params
    final params = GetSingleTaskParamsClient(
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
          SingleTaskClientFetchedSuccessfully(taskEntity: taskEntity)),
    );
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedGetSingleTaskClient());
    } else if (appError.appErrorType == AppErrorType.notActivatedUser) {
      _emitIfNotClosed(NotActivatedGetSingleTaskClient());
    } else {
      _emitIfNotClosed(ErrorWhileGettingSingleTaskClient(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(GetSingleTaskClientState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
