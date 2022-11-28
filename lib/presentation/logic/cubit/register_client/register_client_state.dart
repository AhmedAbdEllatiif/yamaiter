part of 'register_client_cubit.dart';

abstract class RegisterClientState extends Equatable {
  const RegisterClientState();

  @override
  List<Object> get props => [];
}

/// initial
class RegisterClientInitial extends RegisterClientState {}

/// loading
class LoadingRegisterClient extends RegisterClientState {}

/// emailAlreadyExists
class ClientEmailAlreadyExists extends RegisterClientState {}

/// numberAlreadyExists
class ClientNumberAlreadyExists extends RegisterClientState {}

/// success
class RegisterClientSuccess extends RegisterClientState {
  final RegisterResponseEntity registerResponseEntity;

  const RegisterClientSuccess({required this.registerResponseEntity});

  @override
  List<Object> get props => [registerResponseEntity];
}

/// error
class ErrorWhileRegistrationClient extends RegisterClientState {
  final AppError appError;

  const ErrorWhileRegistrationClient({required this.appError});

  @override
  List<Object> get props => [appError];
}
