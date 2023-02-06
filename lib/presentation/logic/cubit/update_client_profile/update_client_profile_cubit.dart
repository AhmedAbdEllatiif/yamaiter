import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/data/params/update_profile/update_client_params.dart';
import 'package:yamaiter/domain/entities/data/authorized_user_entity.dart';
import 'package:yamaiter/domain/use_cases/update_profile/update_client_profile_case.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../di/git_it_instance.dart';
import '../../../../domain/entities/app_error.dart';
import '../authorized_user/authorized_user_cubit.dart';

part 'update_client_profile_state.dart';

class UpdateClientProfileCubit extends Cubit<UpdateClientProfileState> {
  final AuthorizedUserCubit authorizedUserCubit;

  UpdateClientProfileCubit({required this.authorizedUserCubit})
      : super(UpdateClientProfileInitial());

  /// to update sos
  void tryUpdatingClientProfile({
    required String userToken,
    required String firstName,
    required String lastName,
    required String email,
    required String mobile,
    required String image,
    required String governorate,
  }) async {
    //==> loading
    _emitIfNotClosed(LoadingUpdateClientProfile());

    //==> init case
    final usecase = getItInstance<UpdateClientProfileCase>();

    //==> init params
    final params = UpdateClientParams(
      userToken: userToken,
      firstName: firstName,
      lastName: lastName,
      email: email,
      mobile: mobile,
      governorate: governorate,
      image: image,
    );

    //==> send request
    final either = await usecase(params);

    //==> receive result
    either.fold((appError) => _emitError(appError),
        (authorizedUserEntity) async {
      /// to update authorizedUserEntity in local preferences
      authorizedUserCubit.saveUserDataCase(authorizedUserEntity);

      _emitIfNotClosed(
        ClientProfileUpdatedSuccessfully(
            authorizedUserEntity: authorizedUserEntity),
      );
    });
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedUpdateClientProfile());
    } else if (appError.appErrorType == AppErrorType.notActivatedUser) {
      _emitIfNotClosed(NotActivatedUserToUpdateClientProfile());
    } else {
      _emitIfNotClosed(ErrorWhileUpdatingClientProfile(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(UpdateClientProfileState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
