part of 'get_accept_terms_cubit.dart';

abstract class GetAcceptTermsState extends Equatable {
  const GetAcceptTermsState();

  @override
  List<Object> get props => [];
}

/// initial
class GetAcceptTermsInitial extends GetAcceptTermsState {}

/// loading
class LoadingGetAcceptTerms extends GetAcceptTermsState {}

/// not a lawyer
class NotActivatedUserToGetAcceptTerms extends GetAcceptTermsState {}

/// unAuthorized
class UnAuthorizedGetAcceptTerms extends GetAcceptTermsState {}

/// terms accepted before
class TermsAlreadyAccepted extends GetAcceptTermsState {
  final AcceptTermsEntity acceptTermsEntity;

  const TermsAlreadyAccepted({required this.acceptTermsEntity});

  @override
  List<Object> get props => [acceptTermsEntity];
}

/// terms not accepted yet
class TermsNotAcceptedYet extends GetAcceptTermsState {
  final AcceptTermsEntity acceptTermsEntity;

  const TermsNotAcceptedYet({required this.acceptTermsEntity});

  @override
  List<Object> get props => [acceptTermsEntity];
}

/// error
class ErrorWhileGettingAcceptTerms extends GetAcceptTermsState {
  final AppError appError;

  const ErrorWhileGettingAcceptTerms({required this.appError});

  @override
  List<Object> get props => [appError];
}
