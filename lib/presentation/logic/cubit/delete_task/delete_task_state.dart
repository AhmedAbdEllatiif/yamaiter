part of 'delete_task_cubit.dart';

abstract class DeleteTaskState extends Equatable {
  final int taskId;
  const DeleteTaskState(this.taskId);
  @override
  List<Object> get props => [];
}

/// initial
class DeleteTaskInitial extends DeleteTaskState {
  const DeleteTaskInitial(super.taskId);
}

/// loading
class LoadingDeleteTask extends DeleteTaskState {
  const LoadingDeleteTask(super.taskId);
}

/// unAuthorized
class UnAuthorizedDeleteTask extends DeleteTaskState {
  const UnAuthorizedDeleteTask(super.taskId);
}

/// not activated
class NotActivatedUserToDeleteTask extends DeleteTaskState {
  const NotActivatedUserToDeleteTask(super.taskId);
}

/// notFound
class NotFoundDeleteTask extends DeleteTaskState {
  const NotFoundDeleteTask(super.taskId);
}

/// success
class TaskDeletedSuccessfully extends DeleteTaskState {
  const TaskDeletedSuccessfully(super.taskId);
}

/// error
class ErrorWhileDeletingTask extends DeleteTaskState {
  final AppError appError;

  const ErrorWhileDeletingTask(
      {required this.appError, required int taskId})
      : super(taskId);

  @override
  List<Object> get props => [appError];
}
