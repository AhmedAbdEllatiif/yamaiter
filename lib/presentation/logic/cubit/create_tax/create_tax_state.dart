part of 'create_tax_cubit.dart';

abstract class CreateTaxState extends Equatable {
  const CreateTaxState();

  @override
  List<Object> get props => [];
}

/// initial
class CreateTaxInitial extends CreateTaxState {}

/// loTaxing
class LoadingCreateTax extends CreateTaxState {}

/// not a lawyer to create Tax
class NotActivatedUserToCreateTax extends CreateTaxState {}

/// unAuthorized
class UnAuthorizedCreateTax extends CreateTaxState {}

/// success
class TaxCreatedSuccessfully extends CreateTaxState {}

/// error
class ErrorWhileCreatingTax extends CreateTaxState {
  final AppError appError;

  const ErrorWhileCreatingTax({required this.appError});

  @override
  List<Object> get props => [appError];
}
