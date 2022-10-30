import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/data/params/accept_terms_params.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/use_cases/accept_terms/accept_terms.dart';

part 'accept_terms_state.dart';

class AcceptTermsCubit extends Cubit<AcceptTermsState> {
  AcceptTermsCubit() : super(AcceptTermsInitial());

  /// to send accept terms
  void sendAcceptTerms({required String token}) async {
    //==> loading
    _emitIfNotClosed(LoadingAcceptTerms());

    //==> init case
    final createSosCase = getItInstance<AcceptTermsCase>();

    //==> init params
    final params = AcceptTermsParams(isAccepted: true, userToken: token);

    //==> send request
    final either = await createSosCase(params);

    //==> receive result
    either.fold(
        (appError) => _emitError(appError),
        (success) => _emitIfNotClosed(
              TermsAcceptedSuccessfully(),
            ));
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedAcceptTerms());
    } else if (appError.appErrorType == AppErrorType.notActivatedUser) {
      _emitIfNotClosed(NotActivatedUserToAcceptTerms());
    } else {
      _emitIfNotClosed(ErrorWhileAcceptingTerms(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(AcceptTermsState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
