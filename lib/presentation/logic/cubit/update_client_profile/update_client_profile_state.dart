part of 'update_client_profile_cubit.dart';

abstract class UpdateClientProfileState extends Equatable {
  const UpdateClientProfileState();

  @override
  List<Object> get props => [];
}

/// initial
class UpdateClientProfileInitial extends UpdateClientProfileState {}

/// loading
class LoadingUpdateClientProfile extends UpdateClientProfileState {}

/// not activated
class NotActivatedUserToUpdateClientProfile extends UpdateClientProfileState {}

/// unAuthorized
class UnAuthorizedUpdateClientProfile extends UpdateClientProfileState {}

/// success
class ClientProfileUpdatedSuccessfully extends UpdateClientProfileState {
  final AuthorizedUserEntity authorizedUserEntity;

  const ClientProfileUpdatedSuccessfully({required this.authorizedUserEntity});

  @override
  List<Object> get props => [authorizedUserEntity];
}

/// error
class ErrorWhileUpdatingClientProfile extends UpdateClientProfileState {
  final AppError appError;

  const ErrorWhileUpdatingClientProfile({required this.appError});

  @override
  List<Object> get props => [appError];
}
