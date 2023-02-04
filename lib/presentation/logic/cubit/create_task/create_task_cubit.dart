import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../data/params/create_task_params.dart';
import '../../../../di/git_it_instance.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/use_cases/my_tasks/create_task.dart';

part 'create_task_state.dart';

class CreateTaskCubit extends Cubit<CreateTaskState> {
  CreateTaskCubit() : super(CreateTaskInitial());

  /// to create Task
  void sendTask(
      {required String title,
      required String price,
      required String court,
      required String description,
      required String governorates,
      required String startingDate,
      required String token}) async {
    //==> loading
    _emitIfNotClosed(LoadingCreateTask());

    //==> init case
    final createTaskCase = getItInstance<CreateTaskCase>();

    //==> init params
    final params = CreateTaskParams(
        title: title,
        price: price,
        court: court,
        description: description,
        governorates: governorates,
        startingDate: startingDate,
        userToken: token);

    //==> send request
    final either = await createTaskCase(params);

    //==> receive result
    either.fold(
        (appError) => _emitError(appError),
        (success) => _emitIfNotClosed(
              TaskCreatedSuccessfully(),
            ));
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedCreateTask());
    } else if (appError.appErrorType == AppErrorType.notAcceptedYet) {
      _emitIfNotClosed(NotAcceptTermsToCreateTask());
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
