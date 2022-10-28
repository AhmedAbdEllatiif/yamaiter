part of 'accept_terms_cubit.dart';

abstract class AcceptTermsState extends Equatable {
  const AcceptTermsState();

  @override
  List<Object> get props => [];
}


/// initial
class AcceptTermsInitial extends AcceptTermsState {}


/// loading
class LoadingAcceptTerms extends AcceptTermsState {}

/// not a lawyer to  AcceptTerms
class NotActivatedUserToAcceptTerms extends AcceptTermsState {}

/// unAuthorized
class UnAuthorizedAcceptTerms extends AcceptTermsState {}

/// success
class TermsAcceptedSuccessfully extends AcceptTermsState {}

/// error
class ErrorWhileAcceptingTerms extends AcceptTermsState {
  final AppError appError;

  const ErrorWhileAcceptingTerms({required this.appError});

  @override
  List<Object> get props => [appError];
}
