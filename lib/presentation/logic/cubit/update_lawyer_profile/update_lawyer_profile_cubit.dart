import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../data/params/update_profile/update_lawyer_profile.dart';
import '../../../../di/git_it_instance.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/data/authorized_user_entity.dart';
import '../../../../domain/use_cases/update_profile/update_lawyer_profile_case.dart';
import '../authorized_user/authorized_user_cubit.dart';

part 'update_lawyer_profile_state.dart';

class UpdateLawyerProfileCubit extends Cubit<UpdateLawyerProfileState> {
  final AuthorizedUserCubit authorizedUserCubit;

  UpdateLawyerProfileCubit({required this.authorizedUserCubit})
      : super(UpdateLawyerProfileInitial());

  /// to update lawyer profile
  void tryUpdatingLawyerProfile({
    required String userToken,
    required String firstName,
    required String lastName,
    required String email,
    required String mobile,
    required String image,
    required String governorate,
    required String court,
    required String description,
  }) async {
    //==> loading
    _emitIfNotClosed(LoadingUpdateLawyerProfile());

    //==> init case
    final usecase = getItInstance<UpdateLawyerProfileCase>();

    //==> init params
    final params = UpdateLawyerParams(
      userToken: userToken,
      firstName: firstName,
      lastName: lastName,
      email: email,
      mobile: mobile,
      governorate: governorate,
      image: image,
      court: court,
      description: description,
    );

    //==> send request
    final either = await usecase(params);

    //==> receive result
    either.fold((appError) => _emitError(appError),
        (authorizedUserEntity) async {
      log("UpdateLawyerProfileCubit >> $authorizedUserEntity");

      /// to update authorizedUserEntity in local preferences
      authorizedUserCubit.save(authorizedUserEntity);

      _emitIfNotClosed(
        LawyerProfileUpdatedSuccessfully(
            authorizedUserEntity: authorizedUserEntity),
      );
    });
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedUpdateLawyerProfile());
    } else if (appError.appErrorType == AppErrorType.notActivatedUser) {
      _emitIfNotClosed(NotActivatedUserToUpdateLawyerProfile());
    } else {
      _emitIfNotClosed(ErrorWhileUpdatingLawyerProfile(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(UpdateLawyerProfileState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
