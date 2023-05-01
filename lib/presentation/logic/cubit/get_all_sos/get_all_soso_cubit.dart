import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/data/params/all_sos_params.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../di/git_it_instance.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/data/sos_entity.dart';
import '../../../../domain/use_cases/sos/get_all_sos.dart';

part 'get_all_sos_state.dart';

class GetAllSosCubit extends Cubit<GetAllSosState> {
  GetAllSosCubit() : super(GetAllSosInitial());

  /// to fetch all sos list
  Future fetchAllSosList({
    required String userToken,
    required int currentListLength,
    int offset = 0,
  }) async {
    //==> loading
    if (currentListLength == 0) {
      _emitIfNotClosed(LoadingGetAllSosList());
    } else {
      _emitIfNotClosed(LoadingMoreAllSosList());
    }

    //==> init params
    final params = GetSosParams(userToken: userToken, offset: offset);

    //==> init case
    final useCase = getItInstance<GetAllSosListCase>();

    //==> send request
    final either = await useCase(params);

    //==> receive result
    either.fold(
      (appError) => _emitError(appError),
      (sosEntityList) => {
        _emitIfNotClosed(
          _statusToEmit(sosList: sosEntityList, offset: offset),
        )
      },
    );
  }

  /// to emit the result of success fetching the required sos
  /// * param [offset] is the current offset to fetch
  /// * if the offset > 0 and the length is zero,
  /// this means last page reached
  GetAllSosState _statusToEmit(
      {required List<SosEntity> sosList, required int offset}) {
    //==> last page reached
    if (offset > 0 && sosList.isEmpty) {
      return LastPageAllSosReached(sosEntityList: sosList);
    }
    //==> empty list
    else if (sosList.isEmpty) {
      return EmptyAllSosList();
    }
    //==>  less than the limit
    else if (sosList.length < 10) {
      return LastPageAllSosReached(sosEntityList: sosList);
    }

    //==> projects fetched
    else {
      return AllSosListFetchedSuccessfully(sosEntityList: sosList);
    }
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
