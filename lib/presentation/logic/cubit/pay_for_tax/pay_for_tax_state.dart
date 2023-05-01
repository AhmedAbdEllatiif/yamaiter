part of 'pay_for_tax_cubit.dart';

abstract class PayForTaxState extends Equatable {
  const PayForTaxState();

  @override
  List<Object> get props => [];
}

/// initial
class CreateTaxInitial extends PayForTaxState {}

/// loTaxing
class LoadingCreateTax extends PayForTaxState {}

/// not a lawyer to create Tax
class NotActivatedUserToCreateTax extends PayForTaxState {}

/// unAuthorized
class UnAuthorizedCreateTax extends PayForTaxState {}

/// payment link is ready to pay with credit card
class TaxPaymentLinkIsReady extends PayForTaxState {
  final PayEntity payEntity;

  const TaxPaymentLinkIsReady({
    required this.payEntity,
  });

  @override
  List<Object> get props => [payEntity];
}

/// success
class TaxPayedSuccessfullyWithWallet extends PayForTaxState {}

/// error
class ErrorWhileCreatingTax extends PayForTaxState {
  final AppError appError;

  const ErrorWhileCreatingTax({required this.appError});

  @override
  List<Object> get props => [appError];
}
