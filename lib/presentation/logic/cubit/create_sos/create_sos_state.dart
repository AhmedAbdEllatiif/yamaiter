part of 'create_sos_cubit.dart';

abstract class CreateSosState extends Equatable {
  const CreateSosState();

  @override
  List<Object> get props => [];
}


/// initial
class CreateSosInitial extends CreateSosState {}


/// loading
class LoadingCreateSos extends CreateSosState {}

/// not a lawyer to create sos
class NotActivatedUserToCreateSos extends CreateSosState {}

/// unAuthorized
class UnAuthorizedCreateSos extends CreateSosState {}

/// success
class SosCreatedSuccessfully extends CreateSosState {}

/// error
class ErrorWhileCreatingSos extends CreateSosState {
  final AppError appError;

  const ErrorWhileCreatingSos({required this.appError});

  @override
  List<Object> get props => [appError];
}
