import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../data/params/client/update_task_params.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/use_cases/client/tasks/update_task_client_case.dart';

part 'update_task_client_state.dart';

class UpdateTaskClientCubit extends Cubit<UpdateTaskClientState> {
  UpdateTaskClientCubit() : super(UpdateTaskClientInitial());

  /// to Update Task client
  void updateTaskClient(
      {required int id,
      required String title,
      required String price,
      required String court,
      required String description,
      required String governorates,
      required String startingDate,
      required String token}) async {
    //==> loading
    _emitIfNotClosed(LoadingUpdateTaskClient());

    //==> init case
    final useCase = getItInstance<UpdateTaskClientCase>();

    //==> init params
    final params = UpdateTaskClientParams(
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
              TaskClientUpdatedSuccessfully(),
            ));
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedUpdateTaskClient());
    } else if (appError.appErrorType == AppErrorType.notAcceptedYet) {
      _emitIfNotClosed(NotAcceptTermsToUpdateTaskClient());
    } else if (appError.appErrorType == AppErrorType.notActivatedUser) {
      _emitIfNotClosed(NotActivatedUserToUpdateTaskClient());
    } else {
      _emitIfNotClosed(ErrorWhileUpdatingTaskClient(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(UpdateTaskClientState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
