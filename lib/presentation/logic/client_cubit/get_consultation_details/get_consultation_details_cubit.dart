import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/domain/entities/data/client/consultation_entity.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../data/params/client/get_consultation_details.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/use_cases/client/consultations/get_consultation_details_case.dart';

part 'get_consultation_details_state.dart';

class GetConsultationDetailsCubit extends Cubit<GetConsultationDetailsState> {
  GetConsultationDetailsCubit() : super(GetConsultationDetailsInitial());

  void fetchConsultationDetails(
      {required int consultationId, required String userToken}) async {
    //==> loading
    _emitIfNotClosed(LoadingConsultationDetails());

    //==> init case
    final useCase = getItInstance<GetConsultationDetailsCase>();

    //==> init params
    final params = GetConsultationDetailsParams(
        consultationId: consultationId, userToken: userToken);

    //==> send request
    final either = await useCase(params);

    //==> receive result
    either.fold(
        (appError) => _emitError(appError),
        (consultationEntity) => _emitIfNotClosed(
              ConsultationDetailsFetchedSuccessfully(
                  consultationEntity: consultationEntity),
            ));
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedGetConsultationDetails());
    } else if (appError.appErrorType == AppErrorType.notActivatedUser) {
      _emitIfNotClosed(NotActivatedUserToGetConsultationDetails());
    } else {
      _emitIfNotClosed(
          ErrorWhileGettingConsultationDetails(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(GetConsultationDetailsState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
