import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/data/models/tasks/client/create_task_request_model_client.dart';
import 'package:yamaiter/data/params/client/create_task_params.dart';
import 'package:yamaiter/domain/use_cases/client/tasks/create_task_client_case.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';

part 'create_task_client_state.dart';

class CreateTaskClientCubit extends Cubit<CreateTaskClientState> {
  CreateTaskClientCubit() : super(CreateTaskClientInitial());

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
    _emitIfNotClosed(LoadingCreateTaskClient());

    //==> init case
    final useCase = getItInstance<CreateTaskClientCase>();

    //==> init params
    final params = CreateTaskParamsClient(
      createTaskRequestModelClient: CreateTaskRequestModelClient(
        title: title,
        price: price,
        court: court,
        description: description,
        governorates: governorates,
        startingDate: startingDate,
      ),
      userToken: token,
    );

    //==> send request
    final either = await useCase(params);

    //==> receive result
    either.fold(
      (appError) => _emitError(appError),
      (success) => _emitIfNotClosed(
        ClientTaskCreatedSuccessfully(),
      ),
    );
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedCreateTaskClient());
    } else if (appError.appErrorType == AppErrorType.notAcceptedYet) {
      _emitIfNotClosed(NotAcceptTermsToCreateTaskClient());
    } else if (appError.appErrorType == AppErrorType.notActivatedUser) {
      _emitIfNotClosed(NotActivatedUserToCreateTaskClient());
    } else {
      _emitIfNotClosed(ErrorWhileCreatingTaskClient(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(CreateTaskClientState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
