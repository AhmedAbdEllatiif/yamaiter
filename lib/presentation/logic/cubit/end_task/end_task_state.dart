part of 'end_task_cubit.dart';

abstract class EndTaskState extends Equatable {
  const EndTaskState();
  @override
  List<Object> get props => [];
}

/// initial
class EndTaskInitial extends EndTaskState {}

/// loading
class LoadingEndTask extends EndTaskState {}

/// task not found
class TaskNotFound extends EndTaskState {}

/// not a lawyer to create article
class NotActivatedUserToEndTask extends EndTaskState {}

/// unAuthorized
class UnAuthorizedEndTask extends EndTaskState {}

/// success
class TaskEndedSuccessfully extends EndTaskState {}

/// error
class ErrorWhileEndingTask extends EndTaskState {
  final AppError appError;

  const ErrorWhileEndingTask({required this.appError});

  @override
  List<Object> get props => [appError];
}
