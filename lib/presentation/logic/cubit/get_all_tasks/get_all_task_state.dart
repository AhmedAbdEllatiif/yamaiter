part of 'get_all_task_cubit.dart';

abstract class GetAllTasksState extends Equatable {
  const GetAllTasksState();
  @override
  List<Object> get props => [];
}

/// initial
class GetAllTasksInitial extends GetAllTasksState {}

/// loading
class LoadingGetAllTasksList extends GetAllTasksState {}

/// loading more
class LoadingMoreAllTasksList extends GetAllTasksState {}

/// empty
class EmptyAllTasksList extends GetAllTasksState {}

/// unAuthorized
class UnAuthorizedGetAllTasksList extends GetAllTasksState {}

/// not a lawyer to get All Tasks list
class NotActivatedUserToGetAllTasksList extends GetAllTasksState {}

/// lastPage fetched
class LastPageAllTasksListFetched extends GetAllTasksState {
  final List<TaskEntity> taskEntityList;

  const LastPageAllTasksListFetched({required this.taskEntityList});

  @override
  List<Object> get props => [taskEntityList];
}

/// success
class AllTasksListFetchedSuccessfully extends GetAllTasksState {
  final List<TaskEntity> taskEntityList;

  const AllTasksListFetchedSuccessfully({required this.taskEntityList});

  @override
  List<Object> get props => [taskEntityList];
}

/// error
class ErrorWhileGettingAllTasksList extends GetAllTasksState {
  final AppError appError;

  const ErrorWhileGettingAllTasksList({required this.appError});

  @override
  List<Object> get props => [appError];
}

/// error loading more
class ErrorWhileGettingMoreAllTasksList extends GetAllTasksState {
  final AppError appError;

  const ErrorWhileGettingMoreAllTasksList({required this.appError});

  @override
  List<Object> get props => [appError];
}