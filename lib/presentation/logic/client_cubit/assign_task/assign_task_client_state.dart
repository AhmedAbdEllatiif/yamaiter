part of 'assign_task_client_cubit.dart';

abstract class AssignTaskClientState extends Equatable {
  const AssignTaskClientState();
  @override
  List<Object> get props => [];
}

/// initial
class AssignTaskClientInitial extends AssignTaskClientState {}

/// loading
class LoadingAssignTaskClient extends AssignTaskClientState {}

/// not a lawyer to create article
class NotActivatedUserToAssignTaskClient extends AssignTaskClientState {}

/// unAuthorized
class UnAuthorizedAssignTaskClient extends AssignTaskClientState {}

/// success
class TaskClientAssignedSuccessfully extends AssignTaskClientState {}

/// error
class ErrorWhileAssigningTaskClient extends AssignTaskClientState {
  final AppError appError;

  const ErrorWhileAssigningTaskClient({required this.appError});

  @override
  List<Object> get props => [appError];
}