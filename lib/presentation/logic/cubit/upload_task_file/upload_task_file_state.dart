part of 'upload_task_file_cubit.dart';

abstract class UploadTaskFileState extends Equatable {
  const UploadTaskFileState();
  @override
  List<Object> get props => [];
}

/// initial
class UploadTaskFileInitial extends UploadTaskFileState {}

/// loading
class LoadingUploadTaskFile extends UploadTaskFileState {}



/// not a lawyer to create article
class NotActivatedUserToUploadTaskFile extends UploadTaskFileState {}

/// unAuthorized
class UnAuthorizedUploadTaskFile extends UploadTaskFileState {}

/// success
class TaskFiledUploadedSuccessfully extends UploadTaskFileState {}

/// error
class ErrorWhileUploadingTaskFile extends UploadTaskFileState {
  final AppError appError;

  const ErrorWhileUploadingTaskFile({required this.appError});

  @override
  List<Object> get props => [appError];
}
