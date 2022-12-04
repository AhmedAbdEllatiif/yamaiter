part of 'assign_task_client_cubit.dart';

abstract class AssignTaskClientState extends Equatable {
  final int lawyerId;

  const AssignTaskClientState(this.lawyerId);

  @override
  List<Object> get props => [];
}

/// initial
class AssignTaskClientInitial extends AssignTaskClientState {
  const AssignTaskClientInitial() : super(-1);
}

/// loading
class LoadingAssignTaskClient extends AssignTaskClientState {
  final int lawyerId;

  const LoadingAssignTaskClient({required this.lawyerId}) : super(lawyerId);
}

/// not a lawyer to create article
class NotActivatedUserToAssignTaskClient extends AssignTaskClientState {
  const NotActivatedUserToAssignTaskClient() : super(-1);
}

/// unAuthorized
class UnAuthorizedAssignTaskClient extends AssignTaskClientState {
  const UnAuthorizedAssignTaskClient() : super(-1);
}

/// success
class TaskClientAssignedSuccessfully extends AssignTaskClientState {
  const TaskClientAssignedSuccessfully() : super(-1);
}

/// error
class ErrorWhileAssigningTaskClient extends AssignTaskClientState {
  final AppError appError;

  const ErrorWhileAssigningTaskClient({required this.appError}) : super(-1);

  @override
  List<Object> get props => [appError];
}
