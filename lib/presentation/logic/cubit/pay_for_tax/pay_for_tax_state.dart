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

/// success
class TaxCreatedSuccessfully extends PayForTaxState {
  final PayEntity payEntity;

  const TaxCreatedSuccessfully({required this.payEntity});

  @override
  List<Object> get props => [payEntity];
}

/// error
class ErrorWhileCreatingTax extends PayForTaxState {
  final AppError appError;

  const ErrorWhileCreatingTax({required this.appError});

  @override
  List<Object> get props => [appError];
}
