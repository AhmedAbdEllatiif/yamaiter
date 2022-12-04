part of 'get_single_task_client_cubit.dart';

abstract class GetSingleTaskClientState extends Equatable {
  const GetSingleTaskClientState();

  @override
  List<Object?> get props => [];
}

/// initial
class GetSingleTaskClientInitial extends GetSingleTaskClientState {}

/// loading
class LoadingGetSingleTaskClient extends GetSingleTaskClientState {}

/// unAuthorized
class UnAuthorizedGetSingleTaskClient extends GetSingleTaskClientState {}

/// notActivated
class NotActivatedGetSingleTaskClient extends GetSingleTaskClientState {}

/// success
class SingleTaskClientFetchedSuccessfully extends GetSingleTaskClientState {
  final TaskEntity taskEntity;

  const SingleTaskClientFetchedSuccessfully({required this.taskEntity});

  @override
  List<Object> get props => [taskEntity];
}

/// error
class ErrorWhileGettingSingleTaskClient extends GetSingleTaskClientState {
  final AppError appError;

  const ErrorWhileGettingSingleTaskClient({required this.appError});

  @override
  List<Object> get props => [appError];
}
