part of 'store_firebase_token_cubit.dart';

abstract class StoreFirebaseTokenState extends Equatable {
  const StoreFirebaseTokenState();

  @override
  List<Object> get props => [];
}

/// initial
class StoreFirebaseTokenInitial extends StoreFirebaseTokenState {}

/// loading
class LoadingToStoreFbToken extends StoreFirebaseTokenState {}

/// unAuthorized
class UnAuthorizedToStoreFbToken extends StoreFirebaseTokenState {}

/// success
class FbTokenStoredSuccessfully extends StoreFirebaseTokenState {}

/// error
class ErrorWhileStoringFbToken extends StoreFirebaseTokenState {
  final AppError appError;

  const ErrorWhileStoringFbToken({required this.appError});

  @override
  List<Object> get props => [appError];
}
