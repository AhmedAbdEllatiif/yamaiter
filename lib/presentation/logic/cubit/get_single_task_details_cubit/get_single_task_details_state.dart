part of 'get_single_task_details_cubit.dart';

abstract class GetSingleTaskDetailsState extends Equatable {
  const GetSingleTaskDetailsState();

  @override
  List<Object> get props => [];
}

/// initial
class GetSingleTaskDetailsInitial extends GetSingleTaskDetailsState {}

/// loading
class LoadingSingleTaskDetails extends GetSingleTaskDetailsState {}

/// unAuthenticated
class UnAuthenticatedToFetchSingleTaskDetails
    extends GetSingleTaskDetailsState {}

/// success
class TaskFetchedSuccessfully extends GetSingleTaskDetailsState {
  final TaskEntity taskEntity;

  const TaskFetchedSuccessfully({required this.taskEntity});

  @override
  List<Object> get props => [taskEntity];
}

/// error
class ErrorWhileFetchingTaskDetails extends GetSingleTaskDetailsState {
  final AppError appError;

  const ErrorWhileFetchingTaskDetails({required this.appError});

  @override
  List<Object> get props => [appError];
}
