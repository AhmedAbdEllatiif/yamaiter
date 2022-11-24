part of 'filter_task_cubit.dart';

abstract class FilterTasksState extends Equatable {
  const FilterTasksState();

  @override
  List<Object> get props => [];
}

/// initial
class FilterTasksInitial extends FilterTasksState {}

/// loading
class LoadingFilterTasksList extends FilterTasksState {}

/// loading more
class LoadingMoreFilterTasks extends FilterTasksState {}

/// empty
class EmptyFilterTasks extends FilterTasksState {}

/// unAuthorized
class UnAuthorizedFilterTasks extends FilterTasksState {}

/// not a lawyer to get All Tasks list
class NotActivatedUserToFilterTasks extends FilterTasksState {}

/// lastPage fetched
class LastPageFilterTasksFetched extends FilterTasksState {
  final List<TaskEntity> taskEntityList;

  const LastPageFilterTasksFetched({required this.taskEntityList});

  @override
  List<Object> get props => [taskEntityList];
}

/// success
class FilteredTasksFetchedSuccessfully extends FilterTasksState {
  final List<TaskEntity> taskEntityList;

  const FilteredTasksFetchedSuccessfully({required this.taskEntityList});

  @override
  List<Object> get props => [taskEntityList];
}

/// error
class ErrorWhileFilteringTasks extends FilterTasksState {
  final AppError appError;

  const ErrorWhileFilteringTasks({required this.appError});

  @override
  List<Object> get props => [appError];
}

/// error loading more
class ErrorWhileFilteringMoreTasks extends FilterTasksState {
  final AppError appError;

  const ErrorWhileFilteringMoreTasks({required this.appError});

  @override
  List<Object> get props => [appError];
}
