part of 'update_task_client_cubit.dart';

abstract class UpdateTaskClientState extends Equatable {
  const UpdateTaskClientState();

  @override
  List<Object> get props => [];
}

/// initial
class UpdateTaskClientInitial extends UpdateTaskClientState {}

/// loading
class LoadingUpdateTaskClient extends UpdateTaskClientState {}

/// not accept terms before Update Task
class NotAcceptTermsToUpdateTaskClient extends UpdateTaskClientState {}

/// not a lawyer to Update Task
class NotActivatedUserToUpdateTaskClient extends UpdateTaskClientState {}

/// unAuthorized
class UnAuthorizedUpdateTaskClient extends UpdateTaskClientState {}

/// success
class TaskClientUpdatedSuccessfully extends UpdateTaskClientState {}

/// error
class ErrorWhileUpdatingTaskClient extends UpdateTaskClientState {
  final AppError appError;

  const ErrorWhileUpdatingTaskClient({required this.appError});

  @override
  List<Object> get props => [appError];
}
