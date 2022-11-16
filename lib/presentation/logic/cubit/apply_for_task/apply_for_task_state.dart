part of 'apply_for_task_cubit.dart';

abstract class ApplyForTaskState extends Equatable {
  const ApplyForTaskState();

  @override
  List<Object> get props => [];
}

/// initial
class ApplyForTaskInitial extends ApplyForTaskState {}

/// loading
class LoadingApplyForTask extends ApplyForTaskState {}

/// already applied to this task
class AlreadyAppliedToThisTask extends ApplyForTaskState {}

/// not a lawyer to create article
class NotActivatedUserToApplyForTask extends ApplyForTaskState {}

/// unAuthorized
class UnAuthorizedApplyForTask extends ApplyForTaskState {}

/// success
class AppliedForTaskSuccessfully extends ApplyForTaskState {}

/// error
class ErrorWhileApplyingForTask extends ApplyForTaskState {
  final AppError appError;

  const ErrorWhileApplyingForTask({required this.appError});

  @override
  List<Object> get props => [appError];
}