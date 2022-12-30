part of 'refund_payment_cubit.dart';

abstract class RefundPaymentState extends Equatable {
  const RefundPaymentState();

  @override
  List<Object> get props => [];
}

/// initial
class RefundPaymentInitial extends RefundPaymentState {}

/// loading
class LoadingRefundPayment extends RefundPaymentState {}

/// unAuthorized
class UnAuthorizedRefundPayment extends RefundPaymentState {}

/// payment failed
class RefundFailed extends RefundPaymentState {}

/// success
class RefundSuccess extends RefundPaymentState {}

/// error
class ErrorWhileRefundingPayment extends RefundPaymentState {
  final AppError appError;

  const ErrorWhileRefundingPayment({required this.appError});

  @override
  List<Object> get props => [appError];
}
