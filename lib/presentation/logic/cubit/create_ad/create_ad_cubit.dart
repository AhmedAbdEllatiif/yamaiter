import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../data/params/create_ad_params.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/use_cases/ads/create_ad.dart';

part 'create_ad_state.dart';

class CreateAdCubit extends Cubit<CreateAdState> {
  CreateAdCubit() : super(CreateAdInitial());

  /// to create Ad
  void createAd({required String place, required String token}) async {
    //==> loading
    _emitIfNotClosed(LoadingCreateAd());

    //==> init case
    final createAdCase = getItInstance<CreateAdCase>();

    //==> init params
    final params = CreateAdParams(place: place, userToken: token);

    //==> send request
    final either = await createAdCase(params);

    //==> receive result
    either.fold(
        (appError) => _emitError(appError),
        (success) => _emitIfNotClosed(
              AdCreatedSuccessfully(),
            ));
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedCreateAd());
    } else if (appError.appErrorType == AppErrorType.notActivatedUser) {
      _emitIfNotClosed(NotActivatedUserToCreateAd());
    } else {
      _emitIfNotClosed(ErrorWhileCreatingAd(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(CreateAdState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
