import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/common/enum/app_error_type.dart';
import 'package:yamaiter/data/api/requests/get_requests/about_app.dart';
import 'package:yamaiter/di/git_it.dart';
import 'package:yamaiter/domain/entities/data/about/about_entity.dart';
import 'package:yamaiter/domain/use_cases/about.dart';

import '../../../../domain/entities/app_error.dart';

part 'about_state.dart';

class AboutCubit extends Cubit<AboutState> {
  AboutCubit() : super(AboutInitial());

  void getAppAbout(String userToken) async {
    // loading
    _emitIfNotClosed(LoadingAbout());

    // init get about case
    final aboutCase = getItInstance<GetAboutCase>();

    // send about request
    final either = await aboutCase(userToken);

    either.fold(
      //==> error
      (appError) => _emitError(appError),

      //==> about list
      (aboutList) => _emitIfNotClosed(
        AboutFetchedSuccess(aboutList: aboutList),
      ),
    );
  }

  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedAbout());
    } else {
      _emitIfNotClosed(ErrorWhileGettingAbout(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(AboutState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
