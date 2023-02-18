part of 'forget_password_cubit.dart';

abstract class ForgetPasswordState extends Equatable {
  const ForgetPasswordState();

  @override
  List<Object> get props => [];
}

/// initial
class ForgetPasswordInitial extends ForgetPasswordState {}

/// loading
class LoadingForgetPassword extends ForgetPasswordState {}

/// wrong old password
class WrongEmailWhileForgetPassword extends ForgetPasswordState {}

/// success
class ForgetPasswordSentSuccessfully extends ForgetPasswordState {}

/// error
class ErrorWhileSendForgetPasswordPassword extends ForgetPasswordState {
  final AppError appError;

  const ErrorWhileSendForgetPasswordPassword({required this.appError});

  @override
  List<Object> get props => [appError];
}
