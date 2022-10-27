import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../domain/entities/app_error.dart';

part 'create_task_state.dart';

class CreateTaskCubit extends Cubit<CreateTaskState> {
  CreateTaskCubit() : super(CreateTaskInitial());

  /// to create Task
  void sendTask(
      {required String type,
        required String governorate,
        required String description,
        required String token}) async {
    //==> loading
    _emitIfNotClosed(LoadingCreateTask());

    /* //==> init case
    final createTaskCase = getItInstance<CreateTaskCase>();

    //==> init params
    final params = CreateTaskParams(
        TaskRequestModel: TaskRequestModel(
            type: type, governorate: governorate, description: description),
        token: token);

    //==> send request
    final either = await createTaskCase(params);

    //==> receive result
    either.fold(
            (appError) => _emitError(appError),
            (success) => _emitIfNotClosed(
          TaskCreatedSuccessfully(),
        ));*/
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedCreateTask());
    } else if (appError.appErrorType == AppErrorType.notActivatedUser) {
      _emitIfNotClosed(NotActivatedUserToCreateTask());
    } else {
      _emitIfNotClosed(ErrorWhileCreatingTask(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(CreateTaskState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
