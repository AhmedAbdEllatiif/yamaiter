part of 'create_task_cubit.dart';

abstract class CreateTaskState extends Equatable {
  const CreateTaskState();
  @override
  List<Object> get props => [];
}

/// initial
class CreateTaskInitial extends CreateTaskState {}

/// loading
class LoadingCreateTask extends CreateTaskState {}

/// not a lawyer to create Task
class NotActivatedUserToCreateTask extends CreateTaskState {}

/// unAuthorized
class UnAuthorizedCreateTask extends CreateTaskState {}

/// success
class TaskCreatedSuccessfully extends CreateTaskState {}

/// error
class ErrorWhileCreatingTask extends CreateTaskState {
  final AppError appError;

  const ErrorWhileCreatingTask({required this.appError});

  @override
  List<Object> get props => [appError];
}