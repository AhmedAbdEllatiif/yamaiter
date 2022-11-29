part of 'create_task_client_cubit.dart';

abstract class CreateTaskClientState extends Equatable {
  const CreateTaskClientState();

  @override
  List<Object> get props => [];
}

/// initial
class CreateTaskClientInitial extends CreateTaskClientState {}

/// loading
class LoadingCreateTaskClient extends CreateTaskClientState {}

/// not accept terms before create Task
class NotAcceptTermsToCreateTaskClient extends CreateTaskClientState {}

/// not a lawyer to create Task
class NotActivatedUserToCreateTaskClient extends CreateTaskClientState {}

/// unAuthorized
class UnAuthorizedCreateTaskClient extends CreateTaskClientState {}

/// success
class ClientTaskCreatedSuccessfully extends CreateTaskClientState {}

/// error
class ErrorWhileCreatingTaskClient extends CreateTaskClientState {
  final AppError appError;

  const ErrorWhileCreatingTaskClient({required this.appError});

  @override
  List<Object> get props => [appError];
}
