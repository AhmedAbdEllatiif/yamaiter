import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/data/params/get_app_announcements.dart';
import 'package:yamaiter/domain/entities/data/news_entity.dart';
import 'package:yamaiter/domain/use_cases/get_app_announcements_case.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../di/git_it_instance.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/data/ad_entity.dart';

part 'get_app_announcements_state.dart';

class GetAppAnnouncementsCubit extends Cubit<GetAppAnnouncementsState> {
  GetAppAnnouncementsCubit() : super(GetAppAnnouncementsInitial());

  /// to get app announcements
  void tryToGetAppAnnouncements({
    required String adsPlace,
    required String userToken,
  }) async {
    //==> loading
    _emitIfNotClosed(LoadingGetAppAnnouncements());

    //==> init case
    final usecase = getItInstance<GetAppAnnouncementsCase>();

    //==> init params
    final params = GetAnnouncementsParams(
      userToken: userToken,
      page: adsPlace,
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
      (appAnnouncementEntity) {
        final newsAsString = _buildNewsAsOnString(appAnnouncementEntity.news);
        _emitIfNotClosed(AppAnnouncementsFetchedSuccessfully(
          adsList: appAnnouncementEntity.ads,
          newsAsString: newsAsString,
        ));
      },
    );
  }

  String _buildNewsAsOnString(List<NewsEntity> news) {
    String newsAsString = "";

    for (var element in news) {
      final content = element.content;
      if (content != AppUtils.undefined) {
        newsAsString += "$content.    ";
      }
    }

    return newsAsString;
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedGetAppAnnouncements());
    } else {
      _emitIfNotClosed(ErrorWhileFetchingAppAnnouncements(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(GetAppAnnouncementsState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
