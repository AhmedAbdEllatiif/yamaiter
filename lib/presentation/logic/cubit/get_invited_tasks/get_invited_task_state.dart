part of 'get_invited_task_cubit.dart';

abstract class GetInvitedTasksState extends Equatable {
  const GetInvitedTasksState();
  @override
  List<Object> get props => [];
}

/// initial
class GetInvitedTasksInitial extends GetInvitedTasksState {}

/// loading
class LoadingGetInvitedTasksList extends GetInvitedTasksState {}

/// loading more
class LoadingMoreInvitedTasksList extends GetInvitedTasksState {}

/// empty
class EmptyInvitedTasksList extends GetInvitedTasksState {}

/// unAuthorized
class UnAuthorizedGetInvitedTasksList extends GetInvitedTasksState {}

/// not a lawyer to get my Tasks list
class NotActivatedUserToGetInvitedTasksList extends GetInvitedTasksState {}

/// lastPage fetched
class LastPageInvitedTasksListFetched extends GetInvitedTasksState {
  final List<TaskEntity> taskEntityList;

  const LastPageInvitedTasksListFetched({required this.taskEntityList});

  @override
  List<Object> get props => [taskEntityList];
}

/// success
class InvitedTasksListFetchedSuccessfully extends GetInvitedTasksState {
  final List<TaskEntity> taskEntityList;

  const InvitedTasksListFetchedSuccessfully({required this.taskEntityList});

  @override
  List<Object> get props => [taskEntityList];
}

/// error
class ErrorWhileGettingInvitedTasksList extends GetInvitedTasksState {
  final AppError appError;

  const ErrorWhileGettingInvitedTasksList({required this.appError});

  @override
  List<Object> get props => [appError];
}

/// error loading more
class ErrorWhileGettingMoreInvitedTasksList extends GetInvitedTasksState {
  final AppError appError;

  const ErrorWhileGettingMoreInvitedTasksList({required this.appError});

  @override
  List<Object> get props => [appError];
}