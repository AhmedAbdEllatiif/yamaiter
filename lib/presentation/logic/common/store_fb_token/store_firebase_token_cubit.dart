import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/use_cases/store_firebase_token_case.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../data/params/store_fb_token.dart';
import '../../../../di/git_it_instance.dart';

part 'store_firebase_token_state.dart';

class StoreFirebaseTokenCubit extends Cubit<StoreFirebaseTokenState> {
  StoreFirebaseTokenCubit() : super(StoreFirebaseTokenInitial());

  /// to try to store fb token
  void tryToStoreFirebaseToken({
    required String userToken,
    required String firebaseToken,
  }) async {
    //==> loading
    _emitIfNotClosed(LoadingToStoreFbToken());

    //==> init case
    final useCase = getItInstance<StoreFirebaseTokenCase>();

    //==> init params
    final params = StoreFirebaseTokenParams(
        userToken: userToken, firebaseToken: firebaseToken);

    //==> send request
    final either = await useCase(params);

    //==> receive result
    either.fold(
        (appError) => _emitError(appError),
        (success) => _emitIfNotClosed(
              FbTokenStoredSuccessfully(),
            ));
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedToStoreFbToken());
    } else {
      _emitIfNotClosed(ErrorWhileStoringFbToken(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(StoreFirebaseTokenState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
