import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/data/params/invite_to_task_params.dart';
import 'package:yamaiter/domain/use_cases/my_tasks/invite_to_task.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../di/git_it_instance.dart';
import '../../../../domain/entities/app_error.dart';

part 'invite_lawyer_state.dart';

class InviteLawyerCubit extends Cubit<InviteLawyerState> {
  InviteLawyerCubit() : super(InviteLawyerInitial());

  /// to end the current task
  void inviteLawyer({
    required String userToken,
    required final int taskId,
    required final int lawyerId,
  }) async {
    //==> loading
    _emitIfNotClosed(LoadingInviteLawyer());

    //==> init case
    final useCase = getItInstance<InviteToTaskCase>();

    //==> init params
    final params = InviteToTaskParams(
      taskId: taskId,
      userToken: userToken,
      lawyerId: lawyerId,
    );

    //==> send request
    final either = await useCase(params);

    //==> receive result
    either.fold(
        (appError) => _emitError(appError),
        (success) => _emitIfNotClosed(
              InviteLawyerSendSuccessfully(),
            ));
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedInviteLawyer());
    } else if (appError.appErrorType == AppErrorType.idNotFound) {
      _emitIfNotClosed(NoTaskFoundToInviteLawyer());
    } else if (appError.appErrorType == AppErrorType.notActivatedUser) {
      _emitIfNotClosed(NotActivatedUserToInviteLawyer());
    } else {
      _emitIfNotClosed(ErrorWhileInvitingLawyer(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(InviteLawyerState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
