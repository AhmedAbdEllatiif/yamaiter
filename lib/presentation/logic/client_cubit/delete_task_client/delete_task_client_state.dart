part of 'delete_task_client_cubit.dart';

abstract class DeleteTaskClientState extends Equatable {
  final int taskId;

  const DeleteTaskClientState(this.taskId);

  @override
  List<Object> get props => [];
}

/// initial
class DeleteTaskClientInitial extends DeleteTaskClientState {
  const DeleteTaskClientInitial(super.taskId);
}

/// loading
class LoadingDeleteTaskClient extends DeleteTaskClientState {
  const LoadingDeleteTaskClient(super.taskId);
}

/// unAuthorized
class UnAuthorizedDeleteTaskClient extends DeleteTaskClientState {
  const UnAuthorizedDeleteTaskClient(super.taskId);
}

/// not activated
class NotActivatedUserToDeleteTaskClient extends DeleteTaskClientState {
  const NotActivatedUserToDeleteTaskClient(super.taskId);
}

/// notFound
class NotFoundDeleteTaskClient extends DeleteTaskClientState {
  const NotFoundDeleteTaskClient(super.taskId);
}

/// success
class TaskClientDeletedSuccessfully extends DeleteTaskClientState {
  const TaskClientDeletedSuccessfully(super.taskId);
}

/// error
class ErrorWhileDeletingTaskClient extends DeleteTaskClientState {
  final AppError appError;

  const ErrorWhileDeletingTaskClient(
      {required this.appError, required int taskId})
      : super(taskId);

  @override
  List<Object> get props => [appError];
}
