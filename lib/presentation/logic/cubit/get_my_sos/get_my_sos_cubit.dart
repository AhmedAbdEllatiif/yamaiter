import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/domain/entities/data/sos_entity.dart';
import 'package:yamaiter/domain/use_cases/sos/get_my_sos_list.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../data/params/all_sos_params.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';

part 'get_my_sos_state.dart';

class GetMySosCubit extends Cubit<GetMySosState> {
  GetMySosCubit() : super(GetMySosInitial());

  void fetchMySosList({
    required String userToken,
    required int currentListLength,
    int offset = 0,
  }) async {
    //==> loading
    if (currentListLength == 0) {
      _emitIfNotClosed(LoadingGetMySosList());
    } else {
      _emitIfNotClosed(LoadingMoreMySosList());
    }

    //==> init case
    final useCase = getItInstance<GetMySosListCase>();

    //==> init params
    final params = GetSosParams(userToken: userToken, offset: offset);

    //==> send request
    final either = await useCase(params);

    //==> receive result
    either.fold(
      //==> error
      (appError) => _emitError(appError),

      //==> list fetched
      (sosEntityList) => _emitIfNotClosed(
          _statusToEmit(sosList: sosEntityList, offset: offset)),
    );
  }

  /// to emit the result of success fetching the required sos
  /// * param [offset] is the current offset to fetch
  /// * if the offset > 0 and the length is zero,
  /// this means last page reached
  GetMySosState _statusToEmit(
      {required List<SosEntity> sosList, required int offset}) {
    //==> last page reached
    if (offset > 0 && sosList.isEmpty) {
      return LastPageMySosListFetched(sosEntityList: sosList);
    }
    //==> empty list
    else if (sosList.isEmpty) {
      return EmptyMySosList();
    }

    //==>  less than the limit
    else if (sosList.length < 10) {
      return LastPageMySosListFetched(sosEntityList: sosList);
    }

    //==> projects fetched
    else {
      return MySosListFetchedSuccessfully(sosEntityList: sosList);
    }
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
