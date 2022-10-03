part of 'get_my_sos_cubit.dart';

abstract class GetMySosState extends Equatable {
  const GetMySosState();

  @override
  List<Object> get props => [];
}

/// initial
class GetMySosInitial extends GetMySosState {}

/// loading
class LoadingGetMySosList extends GetMySosState {}

/// unAuthorized
class UnAuthorizedGetMySosList extends GetMySosState {}

/// not a lawyer to get my sos list
class NotActivatedUserToGetMySosList extends GetMySosState {}

/// success
class MySosListFetchedSuccessfully extends GetMySosState {
  final List<SosEntity> sosEntityList;

  const MySosListFetchedSuccessfully({required this.sosEntityList});

  @override
  List<Object> get props => [sosEntityList];
}

/// error
class ErrorWhileGettingMySosList extends GetMySosState {
  final AppError appError;

  const ErrorWhileGettingMySosList({required this.appError});

  @override
  List<Object> get props => [appError];
}
