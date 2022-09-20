import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/auto_login_entity.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/use_cases/app_settings/auto_login/delete_auto_login.dart';
import '../../../../domain/use_cases/app_settings/auto_login/get_auto_login.dart';
import '../../../../domain/use_cases/app_settings/auto_login/save_auto_login.dart';

part 'auto_login_state.dart';

class AutoLoginCubit extends Cubit<AutoLoginState> {
  final GetAutoLoginCase getAutoLoginCase;
  final SaveAutoLoginCase saveAutoLoginCase;
  final DeleteAutoLoginCase deleteAutoLoginCase;

  AutoLoginCubit({
    required this.getAutoLoginCase,
    required this.saveAutoLoginCase,
    required this.deleteAutoLoginCase,
  }) : super(const CurrentAutoLoginStatus(userToken: ""));

  void _emitIfNotClosed(AutoLoginState state) {
    if (!isClosed) {
      emit(state);
    }
  }

  Future<void> save(String userToken) async {
    await saveAutoLoginCase(AutoLoginEntity(userToken: userToken));
    await loadCurrentAutoLoginStatus();
  }

  Future<void> delete() async {
    await deleteAutoLoginCase(NoParams());
    await loadCurrentAutoLoginStatus();
  }

  Future<void> loadCurrentAutoLoginStatus() async {
    final either = await getAutoLoginCase(NoParams());
    either.fold(
      (appError) => _emitIfNotClosed(AutoLoginError(appError: appError)),
      (currentUserToken) =>
          _emitIfNotClosed(CurrentAutoLoginStatus(userToken: currentUserToken)),
    );
  }
}
