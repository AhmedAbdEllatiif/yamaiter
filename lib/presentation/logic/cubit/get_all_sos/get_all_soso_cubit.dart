import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/data/params/all_sos_params.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/data/sos_entity.dart';
import '../../../../domain/use_cases/get_all_sos.dart';

part 'get_all_sos_state.dart';

class GetAllSosCubit extends Cubit<GetAllSosState> {
  GetAllSosCubit() : super(GetAllSosInitial());

  void fetchAllSosList({required String userToken,int offset = 0}) async {
    //==> loading
    _emitIfNotClosed(LoadingGetAllSosList());

    //==> init params
    final params = GetAllSosParams(userToken: userToken, offset: offset);

    //==> init case
    final useCase = getItInstance<GetAllSosListCase>();

    //==> send request
    final either = await useCase(params);

    //==> receive result
    either.fold(
      (appError) => _emitError(appError),
      (sosEntityList) => {
        if (sosEntityList.isNotEmpty)
          {
            _emitIfNotClosed(
                AllSosListFetchedSuccessfully(sosEntityList: sosEntityList))
          }
        // empty
        else
          {_emitIfNotClosed(EmptyAllSosList())}
      },
    );
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedGetAllSosList());
    } else if (appError.appErrorType == AppErrorType.notActivatedUser) {
      _emitIfNotClosed(NotActivatedUserToGetAllSosList());
    } else {
      _emitIfNotClosed(ErrorWhileGettingAllSosList(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(GetAllSosState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
