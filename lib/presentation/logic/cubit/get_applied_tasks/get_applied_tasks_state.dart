part of 'get_applied_tasks_cubit.dart';

abstract class GetAppliedTasksState extends Equatable {
  const GetAppliedTasksState();

  @override
  List<Object> get props => [];
}

/// initial
class GetAppliedTasksInitial extends GetAppliedTasksState {}

/// loading
class LoadingGetAppliedTasksList extends GetAppliedTasksState {}

/// loading more
class LoadingMoreAppliedTasksList extends GetAppliedTasksState {}

/// empty
class EmptyAppliedTasksList extends GetAppliedTasksState {}

/// unAuthorized
class UnAuthorizedGetAppliedTasksList extends GetAppliedTasksState {}

/// not a lawyer to get my Tasks list
class NotActivatedUserToGetAppliedTasksList extends GetAppliedTasksState {}

/// lastPage fetched
class LastPageAppliedTasksListFetched extends GetAppliedTasksState {
  final List<TaskEntity> taskEntityList;

  const LastPageAppliedTasksListFetched({required this.taskEntityList});

  @override
  List<Object> get props => [taskEntityList];
}

/// success
class AppliedTasksListFetchedSuccessfully extends GetAppliedTasksState {
  final List<TaskEntity> taskEntityList;

  const AppliedTasksListFetchedSuccessfully({required this.taskEntityList});

  @override
  List<Object> get props => [taskEntityList];
}

/// error
class ErrorWhileGettingAppliedTasksList extends GetAppliedTasksState {
  final AppError appError;

  const ErrorWhileGettingAppliedTasksList({required this.appError});

  @override
  List<Object> get props => [appError];
}

/// error loading more
class ErrorWhileGettingMoreAppliedTasksList extends GetAppliedTasksState {
  final AppError appError;

  const ErrorWhileGettingMoreAppliedTasksList({required this.appError});

  @override
  List<Object> get props => [appError];
}
