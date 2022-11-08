part of 'get_my_single_task_cubit.dart';

abstract class GetMySingleTaskState extends Equatable {
  const GetMySingleTaskState();

  @override
  List<Object?> get props => [];
}

/// initial
class GetMySingleTaskInitial extends GetMySingleTaskState {}

/// loading
class LoadingGetMySingleTask extends GetMySingleTaskState {}

/// unAuthorized
class UnAuthorizedGetMySingleTask extends GetMySingleTaskState {}

/// notActivated
class NotActivatedGetMySingleTask extends GetMySingleTaskState {}

/// success
class MySingleTaskFetchedSuccessfully extends GetMySingleTaskState {
  final TaskEntity taskEntity;

  const MySingleTaskFetchedSuccessfully({required this.taskEntity});

  @override
  List<Object> get props => [taskEntity];
}

/// error
class ErrorWhileGettingMySingleTask extends GetMySingleTaskState {
  final AppError appError;

  const ErrorWhileGettingMySingleTask({required this.appError});

  @override
  List<Object> get props => [appError];
}
