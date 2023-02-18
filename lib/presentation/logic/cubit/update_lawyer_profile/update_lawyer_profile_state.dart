part of 'update_lawyer_profile_cubit.dart';

abstract class UpdateLawyerProfileState extends Equatable {
  const UpdateLawyerProfileState();

  @override
  List<Object> get props => [];
}

/// initial
class UpdateLawyerProfileInitial extends UpdateLawyerProfileState {}

/// loading
class LoadingUpdateLawyerProfile extends UpdateLawyerProfileState {}

/// not activated
class NotActivatedUserToUpdateLawyerProfile extends UpdateLawyerProfileState {}

/// unAuthorized
class UnAuthorizedUpdateLawyerProfile extends UpdateLawyerProfileState {}

/// success
class LawyerProfileUpdatedSuccessfully extends UpdateLawyerProfileState {
  final AuthorizedUserEntity authorizedUserEntity;

  const LawyerProfileUpdatedSuccessfully({required this.authorizedUserEntity});

  @override
  List<Object> get props => [authorizedUserEntity];
}

/// error
class ErrorWhileUpdatingLawyerProfile extends UpdateLawyerProfileState {
  final AppError appError;

  const ErrorWhileUpdatingLawyerProfile({required this.appError});

  @override
  List<Object> get props => [appError];
}
