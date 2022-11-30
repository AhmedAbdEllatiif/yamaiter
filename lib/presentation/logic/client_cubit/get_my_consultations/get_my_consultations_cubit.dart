import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/data/params/client/get_my_consultations_params.dart';
import 'package:yamaiter/domain/entities/data/client/consultation_entity.dart';
import 'package:yamaiter/domain/use_cases/client/consultations/get_my_consultations.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';

part 'get_my_consultations_state.dart';

class GetMyConsultationsCubit extends Cubit<GetMyConsultationsState> {
  GetMyConsultationsCubit() : super(GetMyConsultationsInitial());

  void fetchMyConsultationsList({
    required String userToken,
    required int currentListLength,
    int offset = 0,
  }) async {
    //==> loading
    if (currentListLength == 0) {
      _emitIfNotClosed(LoadingGetMyConsultationsList());
    } else {
      _emitIfNotClosed(LoadingMoreMyConsultationsList());
    }

    //==> init case
    final useCase = getItInstance<GetMyConsultationsCase>();

    //==> init params
    final params = GetMyConsultationParams(
      userToken: userToken,
      offset: offset,
    );

    //==> send request
    final either = await useCase(params);

    //==> receive result
    either.fold(
      //==> error
      (appError) => _emitError(appError, currentListLength),

      //==> list fetched
      (consultationsList) => _emitIfNotClosed(
          _statusToEmit(consultationsList: consultationsList, offset: offset)),
    );
  }

  /// to emit the result of success fetching the required sos
  /// * param [offset] is the current offset to fetch
  /// * if the offset > 0 and the length is zero,
  /// this means last page reached
  GetMyConsultationsState _statusToEmit(
      {required List<ConsultationEntity> consultationsList,
      required int offset}) {
    //==> last page reached
    if (offset > 0 && consultationsList.isEmpty) {
      return LastPageMyConsultationsListFetched(
          consultationsList: consultationsList);
    }
    //==> empty list
    else if (consultationsList.isEmpty) {
      return EmptyMyConsultationsList();
    }

    //==>  less than the limit
    else if (consultationsList.length < 10) {
      return LastPageMyConsultationsListFetched(
          consultationsList: consultationsList);
    }

    //==> success
    else {
      return MyConsultationsListFetchedSuccessfully(
          consultationsList: consultationsList);
    }
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError, int currentListSize) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedGetMyConsultationsList());
    } else if (appError.appErrorType == AppErrorType.notActivatedUser) {
      _emitIfNotClosed(NotActivatedUserToGetMyConsultationsList());
    } else if (currentListSize > 0) {
      _emitIfNotClosed(
          ErrorWhileGettingMoreMyConsultationsList(appError: appError));
    } else {
      _emitIfNotClosed(
          ErrorWhileGettingMyConsultationsList(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(GetMyConsultationsState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
