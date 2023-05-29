import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/domain/entities/data/sos_entity.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../data/params/get_single_sos_params.dart';
import '../../../../di/git_it_instance.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/use_cases/sos/get_single_sos_case.dart';

part 'get_single_sos_state.dart';

class GetSingleSosCubit extends Cubit<GetSingleSosState> {
  GetSingleSosCubit() : super(GetSingleSosInitial());

  void tryToFetchSingleSos({
    required int sosId,
    required String userToken,
  }) async {
    //==> loading
    _emitIfNotClosed(LoadingSingleSos());

    //==> init case
    final useCase = getItInstance<GetSingleSosCase>();

    //==> init params
    final params = GetSingleSosParams(sosId: sosId, userToken: userToken);

    //==> send request
    final either = await useCase(params);

    //==> receive result
    either.fold(
        (appError) => _emitError(appError),
        (sosEntity) => _emitIfNotClosed(
              SosFetchedSuccessfully(sosEntity: sosEntity),
            ));
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthenticatedToFetchSingleSos());
    } else {
      _emitIfNotClosed(ErrorWhileFetchingSingleSos(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(GetSingleSosState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
