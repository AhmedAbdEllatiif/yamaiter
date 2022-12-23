import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/domain/entities/data/accept_terms/accept_terms_entity.dart';
import 'package:yamaiter/domain/use_cases/accept_terms/get_accept_terms.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';

part 'get_accept_terms_state.dart';

class GetAcceptTermsCubit extends Cubit<GetAcceptTermsState> {
  GetAcceptTermsCubit() : super(GetAcceptTermsInitial());

  /// to get accept terms
  void getAcceptTerms({required String token}) async {
    //==> loading
    _emitIfNotClosed(LoadingGetAcceptTerms());

    //==> init case
    final getTermsCase = getItInstance<GetAcceptTermsCase>();

    //==> send request
    final either = await getTermsCase(token);

    //==> receive result
    either.fold(
      //error
      (appError) => _emitError(appError),
      // success
      (acceptTermsEntity) => _emitAfterSuccess(acceptTermsEntity),
    );
  }

  /// to emit the state after the request is succeed
  void _emitAfterSuccess(AcceptTermsEntity acceptTermsEntity) {
    final state = acceptTermsEntity.isUserAcceptedTerms
        ? TermsAlreadyAccepted()
        : TermsNotAcceptedYet(acceptTermsEntity: acceptTermsEntity);

    _emitIfNotClosed(state);
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedGetAcceptTerms());
    } else if (appError.appErrorType == AppErrorType.notActivatedUser) {
      _emitIfNotClosed(NotActivatedUserToGetAcceptTerms());
    } else {
      _emitIfNotClosed(ErrorWhileGettingAcceptTerms(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(GetAcceptTermsState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
