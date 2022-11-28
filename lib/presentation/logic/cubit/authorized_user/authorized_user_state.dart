part of 'authorized_user_cubit.dart';

abstract class AuthorizedUserState extends Equatable {
  final AuthorizedUserEntity userEntity;
  late final UserType currentUserType;

  AuthorizedUserState(this.userEntity) {
    currentUserType = userEntity.userType;
  }

  @override
  List<Object?> get props => [userEntity];
}

/// current data of the current authorized user
class CurrentAuthorizedUserData extends AuthorizedUserState {
  CurrentAuthorizedUserData({required AuthorizedUserEntity userEntity})
      : super(userEntity);
}

/// error
class CurrentAuthorizedUserDataError extends AuthorizedUserState {
  final AppError appError;

  CurrentAuthorizedUserDataError({
    required this.appError,
  }) : super(AuthorizedUserEntity.empty());

  @override
  List<Object?> get props => [appError];
}
