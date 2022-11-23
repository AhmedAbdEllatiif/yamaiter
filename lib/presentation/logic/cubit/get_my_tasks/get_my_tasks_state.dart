part of 'get_my_tasks_cubit.dart';

abstract class GetMyTasksState extends Equatable {
  const GetMyTasksState();

  @override
  List<Object> get props => [];
}

/// initial
class GetMyTasksInitial extends GetMyTasksState {}

/// loading
class LoadingGetMyTasksList extends GetMyTasksState {}

/// loading more
class LoadingMoreMyTasksList extends GetMyTasksState {}

/// empty
class EmptyMyTasksList extends GetMyTasksState {}

/// unAuthorized
class UnAuthorizedGetMyTasksList extends GetMyTasksState {}

/// not a lawyer to get my Tasks list
class NotActivatedUserToGetMyTasksList extends GetMyTasksState {}

/// lastPage fetched
class LastPageMyTasksListFetched extends GetMyTasksState {
  final List<TaskEntity> taskEntityList;

  const LastPageMyTasksListFetched({required this.taskEntityList});

  @override
  List<Object> get props => [taskEntityList];
}

/// success
class MyTasksListFetchedSuccessfully extends GetMyTasksState {
  final List<TaskEntity> taskEntityList;

  const MyTasksListFetchedSuccessfully({required this.taskEntityList});

  @override
  List<Object> get props => [taskEntityList];
}

/// onlyNames
class OnlyNames extends GetMyTasksState {
  final List<String> names;

  const OnlyNames({required this.names});

  @override
  List<Object> get props => [names];
}

/// error
class ErrorWhileGettingMyTasksList extends GetMyTasksState {
  final AppError appError;

  const ErrorWhileGettingMyTasksList({required this.appError});

  @override
  List<Object> get props => [appError];
}

/// error loading more
class ErrorWhileGettingMoreMyTasksList extends GetMyTasksState {
  final AppError appError;

  const ErrorWhileGettingMoreMyTasksList({required this.appError});

  @override
  List<Object> get props => [appError];
}
