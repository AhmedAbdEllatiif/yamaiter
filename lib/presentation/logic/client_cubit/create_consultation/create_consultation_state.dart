part of 'create_consultation_cubit.dart';

abstract class CreateConsultationState extends Equatable {
  const CreateConsultationState();

  @override
  List<Object> get props => [];
}

/// initial
class CreateConsultationInitial extends CreateConsultationState {}

/// loading
class LoadingCreateConsultation extends CreateConsultationState {}

/// not accept terms before create Task
class NotAcceptTermsToCreateConsultation extends CreateConsultationState {}

/// not a lawyer to create Task
class NotActivatedUserToCreateConsultation extends CreateConsultationState {}

/// unAuthorized
class UnAuthorizedCreateConsultation extends CreateConsultationState {}

/// payment link is ready to pay with credit card
class ConsultationPaymentLinkIsReady extends CreateConsultationState {
  final PayEntity payEntity;

  const ConsultationPaymentLinkIsReady({required this.payEntity});

  @override
  List<Object> get props => [payEntity];
}

/// success
class ConsultationPayedSuccessfullyWithWallet extends CreateConsultationState {}

/// Insufficient fund in the wallet
class InsufficientWalletFundToCreateConsultation extends CreateConsultationState {}


/// error
class ErrorWhileCreatingConsultation extends CreateConsultationState {
  final AppError appError;

  const ErrorWhileCreatingConsultation({required this.appError});

  @override
  List<Object> get props => [appError];
}
