part of 'end_task_client_cubit.dart';

abstract class EndTaskClientState extends Equatable {
  const EndTaskClientState();

  @override
  List<Object> get props => [];
}

/// initial
class EndTaskClientInitial extends EndTaskClientState {}

/// loading
class LoadingEndTaskClient extends EndTaskClientState {}

/// task not found
class TaskNotFound extends EndTaskClientState {}

/// not a lawyer to create article
class NotActivatedUserToEndTaskClient extends EndTaskClientState {}

/// unAuthorized
class UnAuthorizedEndTaskClient extends EndTaskClientState {}

/// success
class TaskClientEndedSuccessfully extends EndTaskClientState {}

/// error
class ErrorWhileEndingTaskClient extends EndTaskClientState {
  final AppError appError;

  const ErrorWhileEndingTaskClient({required this.appError});

  @override
  List<Object> get props => [appError];
}
