part of 'user_token_cubit.dart';

abstract class UserTokenState extends Equatable {
  final String userToken;

  const UserTokenState({required this.userToken});

  @override
  List<Object?> get props => [userToken];
}

class CurrentAutoLoginStatus extends UserTokenState {
  const CurrentAutoLoginStatus({required String userToken})
      : super(userToken: userToken);
}

class AutoLoginError extends UserTokenState {
  final AppError appError;

  const AutoLoginError({
    required this.appError,
  }) : super(userToken: "");

  @override
  List<Object?> get props => [appError];
}
