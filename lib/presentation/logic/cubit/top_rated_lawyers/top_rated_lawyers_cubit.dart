import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/use_cases/top_rated_lawyers.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/data/lawyer_entity.dart';

part 'top_rated_lawyers_state.dart';

class TopRatedLawyersCubit extends Cubit<TopRatedLawyersState> {
  TopRatedLawyersCubit() : super(TopRatedLawyersInitial());

  void fetchToRatedLawyers({
    required String userToken,
  }) async {
    //==> loading
    _emitIfNotClosed(LoadingTopRatedLawyers());

    //==> init case
    final useCase = getItInstance<TopRatedLawyersCase>();

    //==> init params
    /*final params = TopRatedLawyersCase(
      userToken: userToken,

    );*/

    //==> send request
    final either = await useCase(userToken);

    //==> receive result
    either.fold(
        //==> error
        (appError) => _emitError(appError),

        //==>  fetched
        (lawyerList) => {
              if (lawyerList.isNotEmpty)
                {
                  _emitIfNotClosed(
                    TopRatedLawyersFetched(lawyerList: lawyerList),
                  ),
                }
              else
                {
                  _emitIfNotClosed(EmptyTopRatedLawyers()),
                }
            });
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedTopRatedLawyers());
    } else {
      _emitIfNotClosed(ErrorWhileLoadingTopRatedLawyers(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(TopRatedLawyersState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
