part of 'assign_task_cubit.dart';

abstract class AssignTaskState extends Equatable {
  const AssignTaskState();

  @override
  List<Object> get props => [];
}

/// initial
class AssignTaskInitial extends AssignTaskState {}

/// loading
class LoadingAssignTask extends AssignTaskState {}

/// not a lawyer to create article
class NotActivatedUserToAssignTask extends AssignTaskState {}

/// unAuthorized
class UnAuthorizedAssignTask extends AssignTaskState {}

/// success
class TaskAssignedSuccessfully extends AssignTaskState {}

/// error
class ErrorWhileAssigningTask extends AssignTaskState {
  final AppError appError;

  const ErrorWhileAssigningTask({required this.appError});

  @override
  List<Object> get props => [appError];
}
