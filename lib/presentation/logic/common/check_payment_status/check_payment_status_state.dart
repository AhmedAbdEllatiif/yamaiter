part of 'check_payment_status_cubit.dart';

abstract class CheckPaymentStatusState extends Equatable {
  const CheckPaymentStatusState();

  @override
  List<Object> get props => [];
}

/// initial
class CheckPaymentStatusInitial extends CheckPaymentStatusState {}

/// loading
class LoadingCheckPaymentStatus extends CheckPaymentStatusState {}

/// unAuthorized
class UnAuthorizedCheckPaymentStatus extends CheckPaymentStatusState {}

/// payment failed
class PaymentFailed extends CheckPaymentStatusState {}

/// not a payment process yet
class NotAPaymentProcessYet extends CheckPaymentStatusState {}

/// success
class PaymentSuccess extends CheckPaymentStatusState {}

/// error
class ErrorWhileCheckPaymentStatus extends CheckPaymentStatusState {
  final AppError appError;

  const ErrorWhileCheckPaymentStatus({required this.appError});

  @override
  List<Object> get props => [appError];
}
