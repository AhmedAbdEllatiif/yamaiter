part of 'delete_remote_user_cubit.dart';

abstract class DeleteRemoteUserState extends Equatable {
  const DeleteRemoteUserState();

  @override
  List<Object> get props => [];
}

class DeleteRemoteUserInitial extends DeleteRemoteUserState {}

/// loading
class LoadingDeleteUser extends DeleteRemoteUserState {}

/// unAuthroized
class UnAuthorizedToDeleteUser extends DeleteRemoteUserState {}

/// success
class UserDeletedSuccessfully extends DeleteRemoteUserState {}

/// error
class ErrorWhileDeletingUser extends DeleteRemoteUserState {
  final AppError appError;

  const ErrorWhileDeletingUser({required this.appError});

  @override
  List<Object> get props => [appError];
}
