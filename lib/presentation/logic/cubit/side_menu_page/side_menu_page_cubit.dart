import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/common/enum/side_menu_page.dart';
import 'package:yamaiter/domain/use_cases/about.dart';
import 'package:yamaiter/domain/use_cases/privacy.dart';

import 'package:yamaiter/domain/use_cases/terms_and_conditions.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../di/git_it_instance.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/data/side_menu_page_entity.dart';
import '../../../../domain/use_cases/contact_us.dart';

part 'side_menu_page_state.dart';

class AboutUsPageCubit extends Cubit<AboutUsPageState> {
  AboutUsPageCubit() : super(SideMenuPageInitial());


  UseCase _getUserCase(SideMenuPage sideMenuPage){
    switch(sideMenuPage){

      case SideMenuPage.about:
        return getItInstance<GetAboutCase>();
      case SideMenuPage.termsAndConditions:
        return getItInstance<GetTermsAndConditionsCase>();
      case SideMenuPage.privacy:
        return getItInstance<GetPrivacyCase>();
      case SideMenuPage.contactUs:
        return getItInstance<GetContactUsCase>();
    }
  }

  void getAppSideMenuData(
      {required String userToken, required SideMenuPage sideMenuPage}) async {
    // loading
    _emitIfNotClosed(LoadingAboutUsPage());

    // init get case
    final useCase = _getUserCase(sideMenuPage);

    // send request
    final either = await useCase(userToken);

    either.fold(
      //==> error
      (appError) => _emitError(appError),

      //==> fetched
      (sideMenuPageEntity) => _emitIfNotClosed(
        AboutUsPageFetchedSuccess(sideMenuPages: sideMenuPageEntity),
      ),
    );
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedToFetchAboutUsPage());
    } else {
      _emitIfNotClosed(ErrorWhileGettingAboutUsPage(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(AboutUsPageState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
