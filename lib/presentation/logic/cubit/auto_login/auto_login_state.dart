part of 'auto_login_cubit.dart';

abstract class AutoLoginState extends Equatable {
  final String userToken;

  const AutoLoginState({required this.userToken});

  @override
  List<Object?> get props => [userToken];
}

class CurrentAutoLoginStatus extends AutoLoginState {
  const CurrentAutoLoginStatus({required String userToken})
      : super(userToken: userToken);
}

class AutoLoginError extends AutoLoginState {
  final AppError appError;

  const AutoLoginError({
    required this.appError,
  }) : super(userToken: "");

  @override
  List<Object?> get props => [appError];
}
