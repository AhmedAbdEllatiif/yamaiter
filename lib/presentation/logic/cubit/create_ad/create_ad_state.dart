part of 'create_ad_cubit.dart';

abstract class CreateAdState extends Equatable {
  const CreateAdState();

  @override
  List<Object> get props => [];
}

/// initial
class CreateAdInitial extends CreateAdState {}

/// loading
class LoadingCreateAd extends CreateAdState {}

/// not a lawyer to create Ad
class NotActivatedUserToCreateAd extends CreateAdState {}

/// unAuthorized
class UnAuthorizedCreateAd extends CreateAdState {}

/// success
class AdCreatedSuccessfully extends CreateAdState {}

/// error
class ErrorWhileCreatingAd extends CreateAdState {
  final AppError appError;

  const ErrorWhileCreatingAd({required this.appError});

  @override
  List<Object> get props => [appError];
}
