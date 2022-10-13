import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/domain/entities/data/sos_entity.dart';
import 'package:yamaiter/domain/use_cases/sos/get_my_sos_list.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';

part 'get_my_sos_state.dart';

class GetMySosCubit extends Cubit<GetMySosState> {
  GetMySosCubit() : super(GetMySosInitial());

  void fetchMySosList({required String userToken}) async {
    //==> loading
    _emitIfNotClosed(LoadingGetMySosList());

    //==> init case
    final useCase = getItInstance<GetMySosListCase>();

    //==> send request
    final either = await useCase(userToken);

    //==> receive result
    either.fold(
      (appError) => _emitError(appError),
      (sosEntityList) => {
        if (sosEntityList.isNotEmpty)
          {
            _emitIfNotClosed(
                MySosListFetchedSuccessfully(sosEntityList: sosEntityList))
          }
        else
          {_emitIfNotClosed(EmptyMySosList())}
      },
    );
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedGetMySosList());
    } else if (appError.appErrorType == AppErrorType.notActivatedUser) {
      _emitIfNotClosed(NotActivatedUserToGetMySosList());
    } else {
      _emitIfNotClosed(ErrorWhileGettingMySosList(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(GetMySosState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
