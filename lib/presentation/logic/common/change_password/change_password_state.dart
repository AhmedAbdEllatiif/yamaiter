part of 'change_password_cubit.dart';

abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object> get props => [];
}

/// initial
class ChangePasswordInitial extends ChangePasswordState {}

/// loading
class LoadingChangePassword extends ChangePasswordState {}

/// wrong old password
class WrongPasswordWhileChangePassword extends ChangePasswordState {}

/// unAuthorized
class UnAuthorizedWhileChangePassword extends ChangePasswordState {}

/// success
class PasswordChangeSuccessfully extends ChangePasswordState {}

/// error
class ErrorWhileChangingPassword extends ChangePasswordState {
  final AppError appError;

  const ErrorWhileChangingPassword({required this.appError});

  @override
  List<Object> get props => [appError];
}
