import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/di/git_it.dart';
import 'package:yamaiter/domain/entities/data/help_question_entity.dart';
import 'package:yamaiter/domain/use_cases/help.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../domain/entities/app_error.dart';

part 'get_help_state.dart';

class GetHelpCubit extends Cubit<GetHelpState> {
  GetHelpCubit() : super(GetHelpInitial());

  void getAppHelp({required String userToken}) async {
    // loading
    _emitIfNotClosed(LoadingGetHelp());

    // init get case
    final useCase = getItInstance<GetHelpCase>();

    // send request
    final either = await useCase(userToken);

    either.fold(
      //==> error
      (appError) => _emitError(appError),

      //==> fetched
      (questionsEntities) => _emitIfNotClosed(
        HelpFetchedSuccess(questionsEntities: questionsEntities),
      ),
    );
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedGetHelp());
    } else {
      _emitIfNotClosed(ErrorWhileGettingHelp(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(GetHelpState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
