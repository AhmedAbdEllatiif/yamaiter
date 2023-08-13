import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/data/params/delete_user_params.dart';
import 'package:yamaiter/domain/use_cases/delete_remote_user.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../di/git_it_instance.dart';
import '../../../../domain/entities/app_error.dart';

part 'delete_remote_user_state.dart';

class DeleteRemoteUserCubit extends Cubit<DeleteRemoteUserState> {
  DeleteRemoteUserCubit() : super(DeleteRemoteUserInitial());

  /// to delete current user
  void tryToDeleteUser({
    required String userToken,
    required String userId,
  }) async {
    //==> loading
    _emitIfNotClosed(LoadingDeleteUser());

    //==> init case
    final usecase = getItInstance<DeleteRemoteUserCase>();

    //==> init params
    final params = DeleteUserParams(
      userToken: userToken,
      userId: userId,
    );

    //==> send request
    final either = await usecase(params);

    //==> receive result
    either.fold(
      //==> error
      (appError) {
        _emitError(appError);
      },
      //==> success
      (_) => _emitIfNotClosed(UserDeletedSuccessfully()),
    );
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedToDeleteUser());
    } else {
      _emitIfNotClosed(ErrorWhileDeletingUser(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(DeleteRemoteUserState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
