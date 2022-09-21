part of 'register_lawyer_cubit.dart';

abstract class RegisterLawyerState extends Equatable {
  const RegisterLawyerState();
  @override
  List<Object> get props => [];
}

/// initial
class RegisterLawyerInitial extends RegisterLawyerState {}

/// loading
class LoadingRegisterLawyer extends RegisterLawyerState {}


/// success
class RegisterLawyerSuccess extends RegisterLawyerState {
  final RegisterResponseEntity registerResponseEntity;

  const RegisterLawyerSuccess({required this.registerResponseEntity});

  @override
  List<Object> get props => [registerResponseEntity];
}

/// error
class ErrorWhileRegistrationLawyer extends RegisterLawyerState {
  final AppError appError;

  const ErrorWhileRegistrationLawyer({required this.appError});

  @override
  List<Object> get props => [appError];
}