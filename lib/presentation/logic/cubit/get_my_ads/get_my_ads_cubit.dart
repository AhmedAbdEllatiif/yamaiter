import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../di/git_it_instance.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/data/ad_entity.dart';
import '../../../../domain/use_cases/ads/get_my_ads.dart';

part 'get_my_ads_state.dart';

class GetMyAdsCubit extends Cubit<GetMyAdsState> {
  GetMyAdsCubit() : super(GetMyAdsInitial());

  void fetchMyAdsList({required String userToken}) async {
    //==> loading
    _emitIfNotClosed(LoadingGetMyAdsList());

    //==> init case
    final useCase = getItInstance<GetMyAdsCase>();

    //==> send request
    final either = await useCase(userToken);

    //==> receive result
    either.fold(
      (appError) => _emitError(appError),
      (adsList) => {
        if (adsList.isNotEmpty)
          {_emitIfNotClosed(MyAdsListFetchedSuccessfully(adsList: adsList))}
        else
          {_emitIfNotClosed(EmptyMyAdsList())}
      },
    );
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedGetMyAdsList());
    } else if (appError.appErrorType == AppErrorType.notActivatedUser) {
      _emitIfNotClosed(NotActivatedUserToGetMyAdsList());
    } else {
      _emitIfNotClosed(ErrorWhileGettingMyAdsList(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(GetMyAdsState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
