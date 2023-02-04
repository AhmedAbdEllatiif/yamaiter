import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../data/models/tasks/upload_task_params.dart';
import '../../../../di/git_it_instance.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/use_cases/applied_tasks/upload_task_file.dart';

part 'upload_task_file_state.dart';

class UploadTaskFileCubit extends Cubit<UploadTaskFileState> {
  UploadTaskFileCubit() : super(UploadTaskFileInitial());

  /// to UploadTaskFile
  void uploadTaskFile(
      {required taskFilePath, required int taskId, required String token}) async {
    //==> loading
    _emitIfNotClosed(LoadingUploadTaskFile());

    //==> init case
    final useCase = getItInstance<UploadTaskFileCase>();

    //==> init params
    final params = UploadTaskFileParams(
      taskId: taskId,
      userToken: token,
      files: [taskFilePath],
    );

    //==> send request
    final either = await useCase(params);

    //==> receive result
    either.fold(
            (appError) => _emitError(appError),
            (success) =>
            _emitIfNotClosed(
              TaskFiledUploadedSuccessfully(),
            ));
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedUploadTaskFile());
    } else if (appError.appErrorType == AppErrorType.notActivatedUser) {
      _emitIfNotClosed(NotActivatedUserToUploadTaskFile());
    } /*else if (appError.appErrorType == AppErrorType.alreadyAppliedToThisTask) {
      _emitIfNotClosed(AlreadyAppliedToThisTask());
    }*/
    else {
      _emitIfNotClosed(ErrorWhileUploadingTaskFile(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(UploadTaskFileState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
