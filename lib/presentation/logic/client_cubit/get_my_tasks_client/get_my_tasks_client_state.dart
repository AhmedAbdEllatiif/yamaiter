part of 'get_my_tasks_client_cubit.dart';

abstract class GetMyTasksClientState extends Equatable {
  const GetMyTasksClientState();

  @override
  List<Object> get props => [];
}

/// initial
class GetMyTasksClientInitial extends GetMyTasksClientState {}

/// loading
class LoadingGetMyTasksClientList extends GetMyTasksClientState {}

/// loading more
class LoadingMoreMyTasksClientList extends GetMyTasksClientState {}

/// empty
class EmptyMyTasksClientList extends GetMyTasksClientState {}

/// unAuthorized
class UnAuthorizedGetMyTasksClientList extends GetMyTasksClientState {}

/// not a lawyer to get my Tasks list
class NotActivatedUserToGetMyTasksClientList extends GetMyTasksClientState {}

/// lastPage fetched
class LastPageMyTasksClientListFetched extends GetMyTasksClientState {
  final List<TaskEntity> taskEntityList;

  const LastPageMyTasksClientListFetched({required this.taskEntityList});

  @override
  List<Object> get props => [taskEntityList];
}

/// success
class MyTasksClientListFetchedSuccessfully extends GetMyTasksClientState {
  final List<TaskEntity> taskEntityList;

  const MyTasksClientListFetchedSuccessfully({required this.taskEntityList});

  @override
  List<Object> get props => [taskEntityList];
}

/// onlyNames
class OnlyNames extends GetMyTasksClientState {
  final List<String> names;

  const OnlyNames({required this.names});

  @override
  List<Object> get props => [names];
}

/// error
class ErrorWhileGettingMyTasksClientList extends GetMyTasksClientState {
  final AppError appError;

  const ErrorWhileGettingMyTasksClientList({required this.appError});

  @override
  List<Object> get props => [appError];
}

/// error loading more
class ErrorWhileGettingMoreMyTasksClientList extends GetMyTasksClientState {
  final AppError appError;

  const ErrorWhileGettingMoreMyTasksClientList({required this.appError});

  @override
  List<Object> get props => [appError];
}