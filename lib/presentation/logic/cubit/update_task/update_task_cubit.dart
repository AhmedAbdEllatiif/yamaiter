import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../data/params/create_task_params.dart';
import '../../../../data/params/update_task_params.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/use_cases/tasks/update_task.dart';

part 'update_task_state.dart';

class UpdateTaskCubit extends Cubit<UpdateTaskState> {
  UpdateTaskCubit() : super(UpdateTaskInitial());

  /// to Update Task
  void updateTask(
      {required int id,
      required String title,
      required String price,
      required String court,
      required String description,
      required String governorates,
      required String startingDate,
      required String token}) async {
    //==> loading
    _emitIfNotClosed(LoadingUpdateTask());

    //==> init case
    final useCase = getItInstance<UpdateTaskCase>();

    //==> init params
    final params = UpdateTaskParams(
        id: id,
        title: title,
        price: price,
        court: court,
        description: description,
        governorates: governorates,
        startingDate: startingDate,
        userToken: token);

    //==> send request
    final either = await useCase(params);

    //==> receive result
    either.fold(
        (appError) => _emitError(appError),
        (success) => _emitIfNotClosed(
              TaskUpdatedSuccessfully(),
            ));
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedUpdateTask());
    } else if (appError.appErrorType == AppErrorType.notAcceptedYet) {
      _emitIfNotClosed(NotAcceptTermsToUpdateTask());
    } else if (appError.appErrorType == AppErrorType.notActivatedUser) {
      _emitIfNotClosed(NotActivatedUserToUpdateTask());
    } else {
      _emitIfNotClosed(ErrorWhileUpdatingTask(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(UpdateTaskState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
