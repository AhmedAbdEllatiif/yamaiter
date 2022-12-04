import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../data/params/client/end_task_params_client.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/use_cases/client/tasks/end_task_client_case.dart';

part 'end_task_client_state.dart';

class EndTaskClientCubit extends Cubit<EndTaskClientState> {
  EndTaskClientCubit() : super(EndTaskClientInitial());

  /// to end the current task
  void endTaskClient({
    required String userToken,
    required final int taskId,
    required final double rating,
  }) async {
    //==> loading
    _emitIfNotClosed(LoadingEndTaskClient());

    //==> init case
    final useCase = getItInstance<EndTaskClientCase>();

    //==> init params
    final params = EndTaskParamsClient(
        taskId: taskId, userToken: userToken, rating: rating);

    //==> send request
    final either = await useCase(params);

    //==> receive result
    either.fold(
        (appError) => _emitError(appError),
        (success) => _emitIfNotClosed(
              TaskClientEndedSuccessfully(),
            ));
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedEndTaskClient());
    } else if (appError.appErrorType == AppErrorType.idNotFound) {
      _emitIfNotClosed(TaskNotFound());
    } else if (appError.appErrorType == AppErrorType.notActivatedUser) {
      _emitIfNotClosed(NotActivatedUserToEndTaskClient());
    } else {
      _emitIfNotClosed(ErrorWhileEndingTaskClient(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(EndTaskClientState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
