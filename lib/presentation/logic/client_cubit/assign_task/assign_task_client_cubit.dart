import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../data/params/client/assign_task_params_client.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/use_cases/client/tasks/assign_task_client_case.dart';

part 'assign_task_client_state.dart';

class AssignTaskClientCubit extends Cubit<AssignTaskClientState> {
  AssignTaskClientCubit() : super(const AssignTaskClientInitial());

  /// to assignTask
  void assignTask(
      {required int userId, required int taskId, required String token}) async {
    //==> loading
    _emitIfNotClosed(LoadingAssignTaskClient(lawyerId: userId));

    //==> init case
    final useCase = getItInstance<AssignTaskClientCase>();

    //==> init params
    final params = AssignTaskParamsClient(
      userId: userId,
      taskId: taskId,
      userToken: token,
    );

    //==> send request
    final either = await useCase(params);

    //==> receive result
    either.fold(
        (appError) => _emitError(appError),
        (success) => _emitIfNotClosed(
              const TaskClientAssignedSuccessfully(),
            ));
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(const UnAuthorizedAssignTaskClient());
    } else if (appError.appErrorType == AppErrorType.notActivatedUser) {
      _emitIfNotClosed(const NotActivatedUserToAssignTaskClient());
    } else {
      _emitIfNotClosed(ErrorWhileAssigningTaskClient(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(AssignTaskClientState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
