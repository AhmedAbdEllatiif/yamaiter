part of 'assign_task_cubit.dart';

abstract class PaymentToAssignTaskState extends Equatable {
  const PaymentToAssignTaskState();

  @override
  List<Object> get props => [];
}

/// initial
class PaymentToAssignTaskInitial extends PaymentToAssignTaskState {}

/// loading
class LoadingPaymentToAssignTask extends PaymentToAssignTaskState {}

/// not a lawyer to create article
class NotActivatedUserToPayToAssignTask extends PaymentToAssignTaskState {}

/// unAuthorized
class UnAuthorizedPayToAssignTask extends PaymentToAssignTaskState {}

/// success
class PaymentLinkToAssignTaskFetched extends PaymentToAssignTaskState {
  final PayEntity payEntity;

  const PaymentLinkToAssignTaskFetched({required this.payEntity});

  @override
  List<Object> get props => [payEntity];
}

/// error
class ErrorWhilePaymentToAssignTask extends PaymentToAssignTaskState {
  final AppError appError;

  const ErrorWhilePaymentToAssignTask({required this.appError});

  @override
  List<Object> get props => [appError];
}
