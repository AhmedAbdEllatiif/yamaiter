part of 'update_task_cubit.dart';

abstract class UpdateTaskState extends Equatable {
  const UpdateTaskState();
  @override
  List<Object> get props => [];
}

/// initial
class UpdateTaskInitial extends UpdateTaskState {}

/// loading
class LoadingUpdateTask extends UpdateTaskState {}

/// not accept terms before Update Task
class NotAcceptTermsToUpdateTask extends UpdateTaskState {}

/// not a lawyer to Update Task
class NotActivatedUserToUpdateTask extends UpdateTaskState {}

/// unAuthorized
class UnAuthorizedUpdateTask extends UpdateTaskState {}

/// success
class TaskUpdatedSuccessfully extends UpdateTaskState {}

/// error
class ErrorWhileUpdatingTask extends UpdateTaskState {
  final AppError appError;

  const ErrorWhileUpdatingTask({required this.appError});

  @override
  List<Object> get props => [appError];
}