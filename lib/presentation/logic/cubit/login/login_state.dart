part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

/// initial
class LoginInitial extends LoginState {}

/// loading
class LoadingLogin extends LoginState {}

/// wrong email
class WrongEmail extends LoginState {}

/// wrong password
class WrongPassword extends LoginState {}

/// success
class LoginSuccess extends LoginState {
  final LoginResponseEntity loginResponseEntity;

  const LoginSuccess({required this.loginResponseEntity});

  @override
  List<Object> get props => [loginResponseEntity];
}

/// error
class ErrorWhileLogin extends LoginState {
  final AppError appError;

  const ErrorWhileLogin({required this.appError});

  @override
  List<Object> get props => [appError];
}
