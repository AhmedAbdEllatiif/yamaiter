part of 'decline_task_cubit.dart';

abstract class DeclineTaskState extends Equatable {
  final int taskId;
  const DeclineTaskState(this.taskId);

  @override
  List<Object> get props => [];
}

/// initial
class DeclineTaskInitial extends DeclineTaskState {
  const DeclineTaskInitial(super.taskId);
}

/// loading
class LoadingDeclineTask extends DeclineTaskState {
  const LoadingDeclineTask(super.taskId);
}

/// unAuthorized
class UnAuthorizedDeclineTask extends DeclineTaskState {
  const UnAuthorizedDeclineTask(super.taskId);
}

/// not activated
class NotActivatedUserToDeclineTask extends DeclineTaskState {
  const NotActivatedUserToDeclineTask(super.taskId);
}

/// notFound
class NotFoundDeclineTask extends DeclineTaskState {
  const NotFoundDeclineTask(super.taskId);
}

/// success
class TaskDeclinedSuccessfully extends DeclineTaskState {
  const TaskDeclinedSuccessfully(super.taskId);
}

/// error
class ErrorWhileDeletingArticle extends DeclineTaskState {
  final AppError appError;

  const ErrorWhileDeletingArticle(
      {required this.appError, required int taskId})
      : super(taskId);

  @override
  List<Object> get props => [appError];
}

