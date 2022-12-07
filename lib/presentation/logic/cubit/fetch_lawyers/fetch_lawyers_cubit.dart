import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/data/params/client/get_lawyers_params.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/use_cases/fetch_lawyers.dart';


import '../../../../common/enum/app_error_type.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/data/lawyer_entity.dart';

part 'fetch_lawyers_state.dart';

class FetchLawyersCubit extends Cubit<FetchLawyersState> {
  FetchLawyersCubit() : super(FetchLawyersInitial());

  void fetchLawyers({
    required String userToken,
    required int currentListLength,
    int offset = 0,
  }) async {
    //==> loading
    if (currentListLength == 0) {
      _emitIfNotClosed(LoadingLawyers());
    } else {
      _emitIfNotClosed(LoadingMoreLawyers());
    }

    //==> init params
    final params = GetLawyersParams(
      userToken: userToken,
      offset: offset,
    );

    //==> init case
    final useCase = getItInstance<FetchLawyersCase>();

    //==> send request
    final either = await useCase(params);

    //==> receive result
    either.fold(
      (appError) => _emitError(appError),
      (lawyersList) => {
        _emitIfNotClosed(
          _statusToEmit(lawyersList: lawyersList, offset: offset),
        )
      },
    );
  }

  void fetchToRatedLawyers({
    required String userToken,
  }) async {
    //==> loading
    _emitIfNotClosed(LoadingLawyers());

    //==> init case
    final useCase = getItInstance<FetchLawyersCase>();

    //==> init params
    final params = GetLawyersParams(
      userToken: userToken,
      offset: 0,
    );

    //==> send request
    final either = await useCase(params);

    //==> receive result
    either.fold(
        //==> error
        (appError) => _emitError(appError),

        //==>  fetched
        (lawyerList) => {
              if (lawyerList.isNotEmpty)
                {
                  _emitIfNotClosed(
                    LawyersFetched(lawyersList: lawyerList),
                  ),
                }
              else
                {
                  _emitIfNotClosed(EmptyLawyers()),
                }
            });
  }

  /// to emit the result of success fetching the required Articles
  /// * param [offset] is the current offset to fetch
  /// * if the offset > 0 and the length is zero,
  /// this means last page reached
  FetchLawyersState _statusToEmit(
      {required List<LawyerEntity> lawyersList, required int offset}) {
    //==> last page reached
    if (offset > 0 && lawyersList.isEmpty) {
      return LastPageLawyersFetched(lawyersList: lawyersList);
    }
    //==> empty list
    else if (lawyersList.isEmpty) {
      return EmptyLawyers();
    }
    //==>  less than the limit
    else if (lawyersList.length < 10) {
      return LastPageLawyersFetched(lawyersList: lawyersList);
    }

    //==> fetched
    else {
      return LawyersFetched(lawyersList: lawyersList);
    }
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedToFetchLawyers());
    } else {
      _emitIfNotClosed(ErrorWhileLoadingLawyers(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(FetchLawyersState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
