part of 'update_sos_cubit.dart';

abstract class UpdateSosState extends Equatable {
  const UpdateSosState();

  @override
  List<Object> get props => [];
}

/// initial
class UpdateSosInitial extends UpdateSosState {}

/// loading
class LoadingUpdateSos extends UpdateSosState {}

/// updated
class SosUpdatedSuccessfully extends UpdateSosState {}

/// not activated
class NotActivatedUserToUpdateSos extends UpdateSosState {}

/// unAuthorized
class UnAuthorizedUpdateSos extends UpdateSosState {}

/// error
class ErrorWhileUpdatingSos extends UpdateSosState {
  final AppError appError;

  const ErrorWhileUpdatingSos({required this.appError});

  @override
  List<Object> get props => [appError];
}
