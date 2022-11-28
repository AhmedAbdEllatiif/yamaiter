import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/domain/entities/data/authorized_user_entity.dart';

import '../../../../common/enum/user_type.dart';
import '../../../../data/params/no_params.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/use_cases/authorized_user/authorized_user_data/delete_user_data.dart';
import '../../../../domain/use_cases/authorized_user/authorized_user_data/get_user_data.dart';
import '../../../../domain/use_cases/authorized_user/authorized_user_data/save_user_data.dart';

part 'authorized_user_state.dart';

class AuthorizedUserCubit extends Cubit<AuthorizedUserState> {
  final SaveUserDataCase saveUserDataCase;
  final GetUserDataCase getUserDataCase;
  final DeleteUserDataCase deleteUserDataCase;

  AuthorizedUserCubit({
    required this.saveUserDataCase,
    required this.getUserDataCase,
    required this.deleteUserDataCase,
  }) : super(
          CurrentAuthorizedUserData(
            userEntity: AuthorizedUserEntity.empty(),
          ),
        );

  /// save current authorized user data
  Future<void> save(AuthorizedUserEntity userEntity) async {
    await saveUserDataCase(userEntity);
    await loadCurrentAuthorizedUserData();
  }

  /// delete current authorized user data
  Future<void> delete() async {
    await deleteUserDataCase(NoParams());
    await loadCurrentAuthorizedUserData();
  }

  /// save current authorized user data
  Future<void> loadCurrentAuthorizedUserData() async {
    final either = await getUserDataCase(NoParams());
    either.fold(
      //==> error
      (appError) =>
          _emitIfNotClosed(CurrentAuthorizedUserDataError(appError: appError)),

      //==> success
      (userEntity) =>
          _emitIfNotClosed(CurrentAuthorizedUserData(userEntity: userEntity)),
    );
  }

  /// emit if not closed
  void _emitIfNotClosed(AuthorizedUserState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
