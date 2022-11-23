import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/data/params/search_for_lawyer_params.dart';
import 'package:yamaiter/domain/entities/data/lawyer_entity.dart';
import 'package:yamaiter/domain/use_cases/search_for_lawyers.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';

part 'search_for_lawyers_state.dart';

class SearchForLawyersCubit extends Cubit<SearchForLawyersState> {
  SearchForLawyersCubit() : super(SearchForLawyersInitial());

  void searchForLawyer({
    required String userToken,
    required String governorates,
    required int currentListLength,
    int offset = 0,
  }) async {
    //==> loading
    if (currentListLength == 0) {
      _emitIfNotClosed(LoadingSearchForLawyersList());
    } else {
      _emitIfNotClosed(LoadingMoreAllTasksList());
    }

    //==> init case
    final useCase = getItInstance<SearchForLawyerCase>();

    //==> init params
    final params = SearchForLawyerParams(
      userToken: userToken,
      offset: offset,
      governorates: governorates,
    );

    //==> send request
    final either = await useCase(params);

    //==> receive result
    either.fold(
      //==> error
      (appError) => _emitError(appError, currentListLength),

      //==> list fetched
      (lawyersResult) => _emitIfNotClosed(
          _statusToEmit(lawyersResult: lawyersResult, offset: offset)),
    );
  }

  /// to emit the result of success fetching the required sos
  /// * param [offset] is the current offset to fetch
  /// * if the offset > 0 and the length is zero,
  /// this means last page reached
  SearchForLawyersState _statusToEmit(
      {required List<LawyerEntity> lawyersResult, required int offset}) {
    //==> last page reached
    if (offset > 0 && lawyersResult.isEmpty) {
      return LastPageSearchForLawyersFetched(lawyersResult: lawyersResult);
    }
    //==> empty list
    else if (lawyersResult.isEmpty) {
      return NoLawyersFound();
    }

    //==>  less than the limit
    else if (lawyersResult.length < 10) {
      return LastPageSearchForLawyersFetched(lawyersResult: lawyersResult);
    }

    //==> projects fetched
    else {
      return SearchLawyersResult(lawyersResult: lawyersResult);
    }
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError, int currentListSize) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedSearchForLawyers());
    } else if (appError.appErrorType == AppErrorType.notActivatedUser) {
      _emitIfNotClosed(NotActivatedUserToSearchForLawyers());
    } else if (currentListSize > 0) {
      _emitIfNotClosed(ErrorWhileLoadingMoreLawyers(appError: appError));
    } else {
      _emitIfNotClosed(ErrorWhileSearchingForLawyers(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(SearchForLawyersState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
