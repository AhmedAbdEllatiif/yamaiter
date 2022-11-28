import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/auto_login_entity.dart';
import '../../../../data/params/no_params.dart';
import '../../../../domain/use_cases/authorized_user/user_token/delete_user_token.dart';
import '../../../../domain/use_cases/authorized_user/user_token/get_user_token.dart';
import '../../../../domain/use_cases/authorized_user/user_token/save_user_token.dart';

part 'user_token_state.dart';

class UserTokenCubit extends Cubit<UserTokenState> {
  final GetUserTokenCase getUserTokenCase;
  final SaveUserTokenCase saveUserTokenCase;
  final DeleteUserTokenCase deleteUserTokenCase;

  UserTokenCubit({
    required this.getUserTokenCase,
    required this.saveUserTokenCase,
    required this.deleteUserTokenCase,
  }) : super(const CurrentAutoLoginStatus(userToken: ""));

  void _emitIfNotClosed(UserTokenState state) {
    if (!isClosed) {
      emit(state);
    }
  }

  Future<void> save(String userToken) async {
    await saveUserTokenCase(AutoLoginEntity(userToken: userToken));
    await loadCurrentAutoLoginStatus();
  }

  Future<void> delete() async {
    await deleteUserTokenCase(NoParams());
    await loadCurrentAutoLoginStatus();
  }

  Future<void> loadCurrentAutoLoginStatus() async {
    final either = await getUserTokenCase(NoParams());
    either.fold(
      (appError) => _emitIfNotClosed(AutoLoginError(appError: appError)),
      (currentUserToken) =>
          _emitIfNotClosed(CurrentAutoLoginStatus(userToken: currentUserToken)),
    );
  }
}
